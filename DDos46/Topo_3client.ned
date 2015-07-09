// *************** TODO: ***************
// [OK] - capire se i client normali riescono a inviare tutti i dati o no
// - il lavoro dei client normali � interrotto dall'attacco?
// [OK] - gli zombie riescono a saturare la bandwidth del canale in ingresso alla vittima?
// - visualizzare a video la bandwidth in uso e verificare che la bandwidth in 
// ingresso della vittima sia saturata (canale C_less), trovare datarate ideale
// - INTERVALLI DI CONFIDENZA
// - calcolare throughput vittima: numero di bit ricevuti (relativi all´attacco) al secondo
// - calcolare packet drop count (su vittima e su server)

//NOTE: 
//1) per ottenere statistiche:
//	- lanciare simulazione
//	- da Omnet, aprire il file *.sca/*.vec corrispondente alla run interessata
//	- generare il file *.anf nella cartella del progetto
// 	- aprire file anf, spostarsi su scheda "Browse data" (in basso)
//	- PER LINK UTILIZATION: selezionare i dati busy:vector relativi al channel del server,
//	  plottare il grafico e APPLICARE time average su dati


package ddos46;

import ddos46.defender.Def_Sniffer;
import inet.linklayer.queue.DropTailQueue;
import inet.nodes.inet.Router;
import ned.DatarateChannel;
import inet.util.NetAnimTrace;
import inet.nodes.inet.StandardHost;
import inet.networklayer.autorouting.ipv4.IPv4NetworkConfigurator;

import ddos46.zombie.ZombieClient;


network ClientServer2
{
    parameters:
        double per = default(0); // per = Packet Error Rate [0,1]
        double ber = default(0); // ber = Bit Error Rate [0,1]
        @display("bgb=808,845");
    types:
        channel C extends DatarateChannel
        {
            datarate = 10Mbps;
            delay = 0.1us;
            per = per;
        }
        channel C_7 extends DatarateChannel
        {
            datarate = 7Mbps;
            delay = 0.1us;
            per = per;
        }

        channel C_5 extends DatarateChannel
        {
            datarate = 5Mbps;
            delay = 0.1us;
            per = per;
        }

        channel C_2 extends DatarateChannel
        {
            datarate = 2Mbps;
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
                @display("p=706,440;i=device/pc2");
        }
        client1: StandardHost {
            parameters:
                @display("p=76,379;i=device/pc3");

        }
        client2: StandardHost {
            parameters:
                @display("p=76,440;i=device/pc3");
        }
        client_zombie: ZombieClient {
            parameters:
                @display("p=95,673;i=device/pc4");
        }
        router: Router {
            @display("p=386,440");
        }
        client_zombie1: ZombieClient {
            parameters:
                @display("p=203,673;i=device/pc4");
        }
        client_zombie2: ZombieClient {
            parameters:
                @display("p=95,742;i=device/pc4");
        }
        client3: StandardHost {
            parameters:
                @display("p=76,505;i=device/pc3");
        }
        client_zombie3: ZombieClient {
            parameters:
                @display("p=203,742;i=device/pc4");
        }
        client_zombie4: ZombieClient {
            parameters:
                @display("p=309,673;i=device/pc4");
        }
        client_zombie5: ZombieClient {
            parameters:
                @display("p=309,742;i=device/pc4");
        }
        router1: Router {
            @display("p=242,588");
        }
        client_zombie6: ZombieClient {
            parameters:
                @display("p=469,673;i=device/pc4");
        }
        client_zombie7: ZombieClient {
            parameters:
                @display("p=576,673;i=device/pc4");
        }
        client_zombie8: ZombieClient {
            parameters:
                @display("p=469,742;i=device/pc4");
        }
        client_zombie9: ZombieClient {
            parameters:
                @display("p=577,742;i=device/pc4");
        }
        client_zombie10: ZombieClient {
            parameters:
                @display("p=683,673;i=device/pc4");
        }
        client_zombie11: ZombieClient {
            parameters:
                @display("p=683,742;i=device/pc4");
        }
        router2: Router {
            @display("p=538,588");
        }

        defender: Def_Sniffer {
            @display("p=631,440");
        }
        client_zombie12: ZombieClient {
            parameters:
                @display("p=110,95;i=device/pc4");
        }
        client_zombie13: ZombieClient {
            parameters:
                @display("p=218,95;i=device/pc4");
        }
        client_zombie14: ZombieClient {
            parameters:
                @display("p=110,164;i=device/pc4");
        }
        client_zombie15: ZombieClient {
            parameters:
                @display("p=218,164;i=device/pc4");
        }
        client_zombie16: ZombieClient {
            parameters:
                @display("p=324,95;i=device/pc4");
        }
        client_zombie17: ZombieClient {
            parameters:
                @display("p=324,164;i=device/pc4");
        }
        client_zombie18: ZombieClient {
            parameters:
                @display("p=484,95;i=device/pc4");
        }
        client_zombie19: ZombieClient {
            parameters:
                @display("p=591,95;i=device/pc4");
        }
        client_zombie20: ZombieClient {
            parameters:
                @display("p=484,164;i=device/pc4");
        }
        client_zombie21: ZombieClient {
            parameters:
                @display("p=592,164;i=device/pc4");
        }
        client_zombie22: ZombieClient {
            parameters:
                @display("p=698,95;i=device/pc4");
        }
        client_zombie23: ZombieClient {
            parameters:
                @display("p=698,164;i=device/pc4");
        }
        router3: Router {
            @display("p=242,298");
        }
        router4: Router {
            @display("p=538,298");
        }

    connections:

        // gruppo client normali:
        client2.pppg++ <--> C_7 <--> router.pppg++;
        client1.pppg++ <--> C_5 <--> router.pppg++;
        client3.pppg++ <--> C_2 <--> router.pppg++;

        // primo gruppo zombie:
        client_zombie.pppg++ <--> C <--> router1.pppg++;
        client_zombie1.pppg++ <--> C <--> router1.pppg++;
        client_zombie2.pppg++ <--> C <--> router1.pppg++;
        client_zombie5.pppg++ <--> C <--> router1.pppg++;
        client_zombie4.pppg++ <--> C <--> router1.pppg++;
        client_zombie3.pppg++ <--> C <--> router1.pppg++;

        // secondo gruppo zombie:
        client_zombie9.pppg++ <--> C <--> router2.pppg++;
        client_zombie11.pppg++ <--> C <--> router2.pppg++;
        client_zombie7.pppg++ <--> C <--> router2.pppg++;
        client_zombie10.pppg++ <--> C <--> router2.pppg++;
        client_zombie8.pppg++ <--> C <--> router2.pppg++;
        client_zombie6.pppg++ <--> C <--> router2.pppg++;

        router1.pppg++ <--> C <--> router.pppg++;
        router2.pppg++ <--> C <--> router.pppg++;

        router.pppg++ <--> C <--> defender.pppg++;
        defender.pppg++ <--> C <--> server.pppg++;
        router3.pppg++ <--> C <--> router.pppg++;
        router4.pppg++ <--> C <--> router.pppg++;
        router4.pppg++ <--> C <--> client_zombie20.pppg++;
        router4.pppg++ <--> C <--> client_zombie21.pppg++;
        router4.pppg++ <--> C <--> client_zombie23.pppg++;
        router4.pppg++ <--> C <--> client_zombie18.pppg++;
        router4.pppg++ <--> C <--> client_zombie19.pppg++;
        router4.pppg++ <--> C <--> client_zombie22.pppg++;
        router3.pppg++ <--> C <--> client_zombie17.pppg++;
        router3.pppg++ <--> C <--> client_zombie15.pppg++;
        router3.pppg++ <--> C <--> client_zombie14.pppg++;
        router3.pppg++ <--> C <--> client_zombie12.pppg++;
        router3.pppg++ <--> C <--> client_zombie13.pppg++;
        router3.pppg++ <--> C <--> client_zombie16.pppg++;
}

