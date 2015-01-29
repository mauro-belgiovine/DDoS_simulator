package ddos_simulator.src.nodes.inet;

import inet.nodes.inet.StandardHost;
import ddos_simulator.src.applications.ddos.TribeFloodNetwork;

module DDoSZombieHost extends StandardHost
{
    submodules:
        tribeFloodNetwork: TribeFloodNetwork {
            @display("p=566,287");
        }
    connections:
        tribeFloodNetwork.to_ip_tcp --> networkLayer.transportIn++;
        networkLayer.transportOut++ --> tribeFloodNetwork.ipIn++;
        
        tribeFloodNetwork.to_ip_udp --> networkLayer.ifIn++;
        tribeFloodNetwork.ipIn++ <-- networkLayer.ifOut++;

        tribeFloodNetwork.to_ip_ping --> networkLayer.pingIn++;
        tribeFloodNetwork.ipIn++ <-- networkLayer.pingOut++;

}
