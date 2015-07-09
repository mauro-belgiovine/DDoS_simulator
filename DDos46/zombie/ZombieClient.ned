package ddos46.zombie;

import inet.nodes.inet.StandardHost;
import ddos46.ddos.TribeFloodNetwork;

// Zombie host --- infected pc
module ZombieClient extends StandardHost
{
    parameters:
    	numTcpApps = 0; // nessuna richiesta normale
    submodules:
        
        tribeFloodNetwork: TribeFloodNetwork {
            parameters:
                @display("p=582,289;i=old/telnet");
                
        }             
}
