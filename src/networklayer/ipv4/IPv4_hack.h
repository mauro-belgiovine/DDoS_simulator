#ifndef IPV4_HACK_H_
#define IPV4_HACK_H_

#include <omnetpp.h>
#include "IPv4.h"

/**
 * @brief Extension of the original IP protocol.
 *
 * Extends the original IP protocol of INET by address spoofing and
 * packet tracing.
 * These tasks are necessary for simulation of attacks
 */
class IPv4_hack : public IPv4
{

protected:
    // service flags
    bool tracingOn, spoofingAllowed;

    // statistics
    cOutVector output, tcpout, udpout, icmpout;

    // state
    bool startTrace;
    int totalTrace, udpTrace, tcpTrace, icmpTrace;
    int totalPackets, udpPackets, tcpPackets, icmpPackets;
    double traceInterval;
    cMessage *traceMsg;

public:
    IPv4_hack();
    virtual ~IPv4_hack();
    /// Dispatch received message to correct handler
    virtual void endService(cPacket *msg);
    void finish();
protected:
    virtual void initialize();
    /// Includes new feature: Address spoofing
    IPv4Datagram *encapsulate(cPacket *transportPacket, InterfaceEntry *&destIE);
    /// Outputs packet counts into vector file
    virtual void handleMessage(cMessage *msg);
    /// Handle messages from higher layers
    virtual void handleMessageFromHL(cPacket *msg);
    /// Handle messages from lower layers
    virtual void handlePacketFromNetwork(IPv4Datagram *datagram);
    /// Processing of IP options
    virtual void processPacket(IPv4Datagram *datagram, InterfaceEntry *destIE, bool fromHL, bool checkOpts);

};

#endif //IPV4_HACK_H
