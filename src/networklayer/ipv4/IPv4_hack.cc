#include <omnetpp.h>
#include "IPv4_hack.h"

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
void IPv4_hack::endService(cPacket *msg)
{
    IPv4::endService(msg);
}

//TODO: edit this function (original from newer INET) to match the ReaSE one
/**
 * Overloads original method to allow for address spoofing and tagging
 * of attack packets.
 * Original method encapsulates packet from transport layer into
 * IP packet.
 */
/*
IPDatagram *IP_hack::encapsulate(cPacket *transportPacket, InterfaceEntry *&destIE)
{
    IPControlInfo *controlInfo = check_and_cast<IPControlInfo*> (transportPacket->removeControlInfo());

    IPDatagram_hacked *datagram = new IPDatagram_hacked(transportPacket->getName());
    datagram->setByteLength(IP_HEADER_BYTES);
    datagram->encapsulate(transportPacket);

    // set source and destination address
    IPAddress dest = controlInfo->getDestAddr();
    datagram->setDestAddress(dest);

    // IP_MULTICAST_IF option, but allow interface selection for unicast packets as well
    destIE = ift->getInterfaceById(controlInfo->getInterfaceId());

    IPAddress src = controlInfo->getSrcAddr();

    // ReaSE: set the attackTag in case of attack packets
    if (dynamic_cast<IPControlInfo_hacked*> (controlInfo))
        datagram->setAttackTag(((IPControlInfo_hacked *) controlInfo)->getAttackTag());

    // when source address was given, use it; otherwise it'll get the address
    // of the outgoing interface after routing
    if (!src.isUnspecified())
    {
        //if interface parameter does not match existing interface, do not send datagram
        if (rt->getInterfaceByAddress(src) == NULL)
        {
            // ReaSE: now we can apply spoofing
            if (spoofingAllowed)
                EV<< "Spoofing Sourceaddress\n";
                else
                opp_error("Wrong source address %s in (%s)%s: no interface with such address",
                        src.str().c_str(), transportPacket->getClassName(), transportPacket->getFullName());
            }
            datagram->setSrcAddress(src);
        }

        // set other fields
        datagram->setDiffServCodePoint(controlInfo->getDiffServCodePoint());

        datagram->setIdentification(curFragmentId++);
        datagram->setMoreFragments(false);
        datagram->setDontFragment (controlInfo->getDontFragment());
        datagram->setFragmentOffset(0);

        datagram->setTimeToLive(
                controlInfo->getTimeToLive()> 0 ?
                controlInfo->getTimeToLive() :
                (datagram->getDestAddress().isMulticast() ? defaultMCTimeToLive : defaultTimeToLive)
        );

        datagram->setTransportProtocol(controlInfo->getProtocol());
        delete controlInfo;

        // setting IP options is currently not supported

        return datagram;
    }

*/
IPv4Datagram *IPv4::encapsulate(cPacket *transportPacket, IPv4ControlInfo *controlInfo)
{
    IPv4Datagram *datagram = createIPv4Datagram(transportPacket->getName());
    datagram->setByteLength(IP_HEADER_BYTES);
    datagram->encapsulate(transportPacket);

    // set source and destination address
    IPv4Address dest = controlInfo->getDestAddr();
    datagram->setDestAddress(dest);

    IPv4Address src = controlInfo->getSrcAddr();

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
