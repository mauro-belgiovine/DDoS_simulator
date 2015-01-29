#include <omnetpp.h>
#include "IPv4_hack.h"
#include "IPv4ControlInfo_hacked_m.h"
#include "ARPPacket_m.h"

Define_Module( IPv4_hack);

IPv4_hack::IPv4_hack()
{
    tracingOn = false;
    spoofingAllowed = false;
    startTrace = false;
    totalTrace = udpTrace = tcpTrace = icmpTrace = 0;
    totalPackets = udpPackets = tcpPackets = icmpPackets = 0;
    traceInterval = 0.;
    traceMsg = NULL;
}

IPv4_hack::~IPv4_hack()
{
    if (traceMsg)
    {
        if (traceMsg->isScheduled())
            cancelAndDelete(traceMsg);
        else
            delete traceMsg;
    }
}

void IPv4_hack::initialize()
{
    IPv4::initialize(0); //TODO check if int stage must be 0 or 1
    spoofingAllowed = par("spoofingOn").boolValue();
    tracingOn = par("tracingOn").boolValue();
    if(spoofingAllowed)
        EV << "Spoofing is allowed for module "<<getFullPath()<<"\n";
    if(tracingOn)
    {
        EV << "Write TraceVector for module "<<getFullPath()<<"\n";
        output.setName("trace history");
        udpout.setName("udpout");
        tcpout.setName("tcpout");
        icmpout.setName("icmpout");
        traceMsg = new cMessage("traceOut");
        traceInterval = par("tracingInterval");
        double startTime = par("traceStartTime");
        if(startTime <=0)
        scheduleAt(simTime() + traceInterval, traceMsg);
        else
        scheduleAt(simTime() + startTime, traceMsg);
    }
}

/**
 * Handles interval timer message.
 *
 * In case tracing support is activated, a periodic traceMessage is sent
 * and received. In case of reception the recorded values (drops, frames)
 * of the current interval are written out to vector file.
 * Then the state variables are reset to 0 for the next interval.
 *
 * @param msg Message to handle
 */
void IPv4_hack::handleMessage(cMessage *msg)
{
    if (msg->isSelfMessage())
    {
        if (msg == traceMsg)
        {
            // start tracing in case of first message
            if (!startTrace)
            {
                startTrace = true;
                totalTrace = 0;
                icmpTrace = 0;
                tcpTrace = 0;
                udpTrace = 0;
                scheduleAt(simTime() + traceInterval, traceMsg);
                return;
            }

            // write packet counts into vector file
            if (tracingOn)
            {
                output.recordWithTimestamp(simTime(), totalTrace);
                icmpout.recordWithTimestamp(simTime(), icmpTrace);
                tcpout.recordWithTimestamp(simTime(), tcpTrace);
                udpout.recordWithTimestamp(simTime(), udpTrace);
                totalTrace = icmpTrace = tcpTrace = udpTrace = 0;
            }
            if (traceMsg->isScheduled())
                cancelEvent(traceMsg);
            scheduleAt(simTime() + traceInterval, traceMsg);
        }
        else
            //AbstractQueue::handleMessage(msg);
            QueueBase::handleMessage(msg);
    }
    else IPv4::handleMessage(msg); //use default IPv4 msg handler
}

/**
 * Dispatch received message to correct handler.
 *
 * @param msg Received message to be dispatched
 */
void IPv4_hack::endService(cPacket *packet)
{
    if (!isUp) {
        EV << "IPv4 is down -- discarding message\n";
        delete packet;
        return;
    }
    if (packet->getArrivalGate()->isName("transportIn")) //TODO packet->getArrivalGate()->getBaseId() == transportInGateBaseId
    {
        handlePacketFromHL(packet);
    }
    else if (packet->getArrivalGate() == arpInGate)
    {
        handlePacketFromARP(packet);
    }
    else // from network
    {
        const InterfaceEntry *fromIE = getSourceInterfaceFrom(packet);
        if (dynamic_cast<ARPPacket *>(packet))
            handleIncomingARPPacket((ARPPacket *)packet, fromIE);
        else if (dynamic_cast<IPv4Datagram *>(packet))
            handleIncomingDatagram((IPv4Datagram *)packet, fromIE);
        else
            throw cRuntimeError(packet, "Unexpected packet type");
    }

    if (ev.isGUI())
        updateDisplayString();
}

/**
 * Overloads original method to allow for address spoofing and tagging
 * of attack packets.
 * Original method encapsulates packet from transport layer into
 * IP packet.
 */
IPv4Datagram *IPv4::encapsulate(cPacket *transportPacket, IPv4ControlInfo *controlInfo)
{
    IPv4Datagram_hacked *datagram = new IPv4Datagram_hacked(transportPacket->getName());
    datagram->setByteLength(IP_HEADER_BYTES);
    datagram->encapsulate(transportPacket);

    // set source and destination address
    IPv4Address dest = controlInfo->getDestAddr();
    datagram->setDestAddress(dest);

    IPv4Address src = controlInfo->getSrcAddr();

    // set the attackTag in case of attack packets
    if (dynamic_cast<IPv4ControlInfo_hacked*> (controlInfo))
        datagram->setAttackTag(((IPv4ControlInfo_hacked *) controlInfo)->getAttackTag());

    // when source address was given, use it; otherwise it'll get the address
    // of the outgoing interface after routing
    if (!src.isUnspecified())
    {
        // if interface parameter does not match existing interface, do not send datagram
        if (rt->getInterfaceByAddress(src)==NULL)
            throw cRuntimeError("Wrong source address %s in (%s)%s: no interface with such address",
                      src.str().c_str(), transportPacket->getClassName(), transportPacket->getFullName());

        datagram->setSrcAddress(src);
    }

    // set other fields
    datagram->setTypeOfService(controlInfo->getTypeOfService());

    datagram->setIdentification(curFragmentId++);
    datagram->setMoreFragments(false);
    datagram->setDontFragment(controlInfo->getDontFragment());
    datagram->setFragmentOffset(0);

    short ttl;
    if (controlInfo->getTimeToLive() > 0)
        ttl = controlInfo->getTimeToLive();
    else if (datagram->getDestAddress().isLinkLocalMulticast())
        ttl = 1;
    else if (datagram->getDestAddress().isMulticast())
        ttl = defaultMCTimeToLive;
    else
        ttl = defaultTimeToLive;
    datagram->setTimeToLive(ttl);
    datagram->setTransportProtocol(controlInfo->getProtocol());

    // setting IPv4 options is currently not supported

    return datagram;
}

/**
 * Invokes encapsulate(), then routePacket().
 *
 * This is an exact copy of the original method but it is the only way to
 * call the encapsulate methode overwritten by this class, which allows for
 * address spoofing.
 */
void IPv4_hack::handlePacketFromHL(cPacket *packet)
{
    // if no interface exists, do not send datagram
        if (ift->getNumInterfaces() == 0)
        {
            EV << "No interfaces exist, dropping packet\n";
            numDropped++;
            delete packet;
            return;
        }

        // encapsulate and send
        IPv4Datagram *datagram = dynamic_cast<IPv4Datagram *>(packet);
        IPv4ControlInfo *controlInfo = NULL;
        //FIXME dubious code, remove? how can the HL tell IP whether it wants tunneling or forwarding?? --Andras
        if (!datagram) // if HL sends an IPv4Datagram, route the packet
        {
            // encapsulate
            controlInfo = check_and_cast<IPv4ControlInfo*>(packet->removeControlInfo());
            datagram = encapsulate(packet, controlInfo);
        }

        // extract requested interface and next hop
        const InterfaceEntry *destIE = controlInfo ? const_cast<const InterfaceEntry *>(ift->getInterfaceById(controlInfo->getInterfaceId())) : NULL;

        if (controlInfo)
            datagram->setControlInfo(controlInfo);    //FIXME ne rakjuk bele a cntrInfot!!!!! de kell :( kulonben a hook queue-ban elveszik a multicastloop flag

        // TODO:
        IPv4Address nextHopAddr(IPv4Address::UNSPECIFIED_ADDRESS);
        if (datagramLocalOutHook(datagram, destIE, nextHopAddr) == INetfilter::IHook::ACCEPT)
            datagramLocalOut(datagram, destIE, nextHopAddr);
}

void IPv4_hack::handleIncomingDatagram(IPv4Datagram *datagram, const InterfaceEntry *fromIE)
{
    ASSERT(datagram);
    ASSERT(fromIE);

    //
    // "Prerouting"
    //

    // check for header biterror
    if (datagram->hasBitError())
    {
        // probability of bit error in header = size of header / size of total message
        // (ignore bit error if in payload)
        double relativeHeaderLength = datagram->getHeaderLength() / (double)datagram->getByteLength();
        if (dblrand() <= relativeHeaderLength)
        {
            EV << "bit error found, sending ICMP_PARAMETER_PROBLEM\n";
            icmpAccess.get()->sendErrorMessage(datagram, fromIE->getInterfaceId(), ICMP_PARAMETER_PROBLEM, 0);
            return;
        }
    }

    EV << "Received datagram `" << datagram->getName() << "' with dest=" << datagram->getDestAddress() << "\n";

    const InterfaceEntry *destIE = NULL;
    IPv4Address nextHop(IPv4Address::UNSPECIFIED_ADDRESS);
    if (datagramPreRoutingHook(datagram, fromIE, destIE, nextHop) == INetfilter::IHook::ACCEPT)
        preroutingFinish(datagram, fromIE, destIE, nextHop);

    // ReaSE: check for IP-Options before routing the packet
    processPacket(datagram, NULL, false, true);
}

/**
 * This method is called by handleFromNetwork and does an additional check
 * for IP options before forwarding the packet.
 */
void IPv4_hack::processPacket(IPv4Datagram *datagram, InterfaceEntry *destIE, bool fromHL, bool checkOpts)
{
    if (checkOpts && (datagram->getOptionCode() != IPOPTION_NO_OPTION))
    {
        // handleIPOption
        bool sendToControl = false;

        // check for IP-Options
        // FIXME: RFC says, the datagram could contain more than one option
        switch (datagram->getOptionCode())
        {
            case IPOPTION_END_OF_OPTIONS:
                break;
            case IPOPTION_NO_OPTION:
                break;
            case IPOPTION_SECURITY:
                //TODO
                break;
            case IPOPTION_LOOSE_SOURCE_ROUTING:
                //TODO
                break;
            case IPOPTION_TIMESTAMP:
                //TODO
                break;
            case IPOPTION_RECORD_ROUTE:
                //TODO
                break;
            case IPOPTION_STREAM_ID:
                //TODO
                break;
            case IPOPTION_STRICT_SOURCE_ROUTING:
                //TODO
                break;
            case IPOPTION_ROUTER_ALERT:
                //TODO
                break;
            default:
                opp_error("unknown IP option\n");
        }
    }

    // process local or remote routing
    //
    if (!datagram->getDestAddress().isMulticast())
        routePacket(datagram, NULL, false);
    else
        routeMulticastPacket(datagram, NULL, getSourceInterfaceFrom(datagram));
}

void IPv4_hack::finish() {

    recordScalar("Total packets", totalPackets);
    recordScalar("TCP packets", tcpPackets);
    recordScalar("UDP packets", udpPackets);
    recordScalar("ICMP packets", icmpPackets);
}
