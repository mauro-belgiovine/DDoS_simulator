//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with this program.  If not, see http://www.gnu.org/licenses/.
// 



// *************** TODO: ***************
// - capire se i client normali riescono a inviare tutti i dati o no
// - il lavoro dei client normali è interrotto dall'attacco?
// - gli zombie riescono a saturare la bandwidth del canale in ingresso alla vittima?
// - visualizzare a video la bandwidth in uso e verificare che la bandwidth in 
// ingresso della vittima sia saturata (canale C_less), trovare datarate ideale


package ddos46;

import inet.nodes.inet.Router;
import ned.DatarateChannel;
import inet.util.NetAnimTrace;
import inet.nodes.inet.StandardHost;
import inet.networklayer.autorouting.ipv4.IPv4NetworkConfigurator;

import ddos46.zombie.ZombieClient;


network ClientServer
{
    parameters:
        double per = default(0); // per = Packet Error Rate [0,1]
        double ber = default(0); // ber = Bit Error Rate [0,1]
        @display("bgb=783,538");
    types:
        channel C extends DatarateChannel
        {
            datarate = 10Mbps;
            delay = 0.1us;
            per = per;
        }
        channel C_less extends DatarateChannel
        {
            datarate = 1Mbps;
            delay = 0.1us;
            per = per;
        }

    submodules:
        configurator: IPv4NetworkConfigurator {
            parameters:
                @display("p=49,24");
        }
        netAnimTrace: NetAnimTrace {
            @display("p=144,24");
        }
        server: StandardHost {
            parameters:
                @display("p=577,111;i=device/pc2");
        }
        client1: StandardHost {
            parameters:
                @display("p=76,158;i=device/pc3");
                
        }
        client2: StandardHost {
            parameters:
                @display("p=64,241;i=device/pc3");
        }
        client_zombie: ZombieClient {
            parameters:
                @display("p=354,421;i=device/pc4");
        }
        router: Router {
            @display("p=372,218");
        }
        client_zombie1: ZombieClient {
            parameters:
                @display("p=437,397;i=device/pc4");
        }
        client_zombie2: ZombieClient {
            parameters:
                @display("p=508,358;i=device/pc4");
        }
        client3: StandardHost {
            parameters:
                @display("p=95,319;i=device/pc3");
        }
        client_zombie3: ZombieClient {
            parameters:
                @display("p=520,428;i=device/pc4");
        }
        client_zombie4: ZombieClient {
            parameters:
                @display("p=603,404;i=device/pc4");
        }
        client_zombie5: ZombieClient {
            parameters:
                @display("p=674,365;i=device/pc4");
        }
    connections:
        client2.pppg++ <--> C <--> router.pppg++;
        client1.pppg++ <--> C <--> router.pppg++;
        router.pppg++ <--> C_less <--> server.pppg++;
        client_zombie.pppg++ <--> C <--> router.pppg++;
        client3.pppg++ <--> C <--> router.pppg++;
        client_zombie1.pppg++ <--> C <--> router.pppg++;
        client_zombie2.pppg++ <--> C <--> router.pppg++;
        client_zombie5.pppg++ <--> C <--> router.pppg++;
        client_zombie4.pppg++ <--> C <--> router.pppg++;
        client_zombie3.pppg++ <--> C <--> router.pppg++;
}

