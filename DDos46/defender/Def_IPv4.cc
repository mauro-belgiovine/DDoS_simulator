#include "Def_IPv4.h"

#include "IPSocket.h"
#include "IPv4InterfaceData.h"

Define_Module(Def_IPv4);

void Def_IPv4::handleMessage(cMessage *msg)
{
        if (msg->getKind() == IP_C_REGISTER_PROTOCOL) {
            IPRegisterProtocolCommand * command = check_and_cast<IPRegisterProtocolCommand *>(msg->getControlInfo());
            mapping.addProtocolMapping(command->getProtocol(), msg->getArrivalGate()->getIndex());
            delete msg;
        }
        else if (!msg->isSelfMessage() && msg->getArrivalGate()->isName("arpIn"))
            endService(PK(msg));
        else {

            if(msg->getKind() == 0) send(msg, "transportOut", 0);
            else QueueBase::handleMessage(msg);
        }
}
