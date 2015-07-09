package ddos46.defender;

import ddos46.defender.Defender;
import ddos46.defender.Def_NodeBase;

module Def_Sniffer extends Def_NodeBase
{
		    
    submodules:
        defender: Defender {
            @display("p=329,177");
        }

    connections:

        networkLayer.transportOut++ --> defender.in;
        defender.out --> networkLayer.transportIn++;
}
