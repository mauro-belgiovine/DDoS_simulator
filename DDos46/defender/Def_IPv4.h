#ifndef __DEFENDERIPV4_H
#define __DEFENDERIPV4_H

#include "IPv4.h"

//using namespace

class Def_IPv4 : public IPv4 {

    protected:
            virtual void handleMessage(cMessage *msg);
};

#endif
