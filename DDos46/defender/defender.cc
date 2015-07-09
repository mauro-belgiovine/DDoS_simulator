#include "defender.h"

Define_Module(Defender);

simsignal_t Defender::inThroughputPerSample = registerSignal("inThroughputPerSample");
simsignal_t Defender::outThroughputPerSample = registerSignal("outThroughputPerSample");


void Defender::initialize()
{
    learning_time = par("learning_time");
    sample_time = par("sample_time");
    susp_w_limit = par("susp_w_limit");
    defense_mode = par("defense_mode");
    updateBlackList = new cMessage ("updateBlackList");
}

void Defender::handleMessage(cMessage *msg)
{

    if (msg->isSelfMessage()) {
        Update_black_list();
        if (black_list.size() == 0) startUpdateBL = true;
        else scheduleAt(simTime()+sample_time, updateBlackList);

    }

    else {
            IPv4Datagram *datagram = check_and_cast<IPv4Datagram *> (msg);

            //stats
            IPv4Address *local = new IPv4Address("192.168.1.1"); // indirizzo del server
            if( datagram->getDestAddress() == *local){  // conta pacchetti SOLO verso il server
                inBitPerSample += datagram->getBitLength();
                if ( (simTime()-in_elapsed_time) >= sample_time) {
                    emit(inThroughputPerSample,inBitPerSample);
                    inBitPerSample = 0;
                    in_elapsed_time = simTime();
                }
            }

            // DIFESA ATTIVA
            if (defense_mode == true) {

                IPv4Address src = datagram->getSrcAddress();

                //controlla che il mittente non sia nella black list
                if(black_list.find(src) != black_list.end() ){

                    if((src == *client1) || (src == *client2) || (src == *client3) || (src == *client4) || (src == *client5) || (src == *client6) || (src == *client7))
                        drop_pkt_client++;
                    else
                        drop_pkt_zombie++;

                    delete msg; //DROPPA PKT
                }else{
                    IncomingTrafficMonitor(datagram);
                    msg->setKind(1);
                    send(msg, "out");
                }
            }

            // DIFESA DISATTIVA
            else{   msg->setKind(1);
                    send(msg, "out");
            }
    }

}

void Defender::IncomingTrafficMonitor(IPv4Datagram *datagram){

    IPv4Address *local = new IPv4Address("192.168.1.1"); // indirizzo del server

    if( datagram->getDestAddress() == *local){  // conta pacchetti SOLO verso il server

                                                   //packetCount++;
        bitPerSample += datagram->getBitLength();  // aggiorna il conteggio del traffico


        if(simTime() < learning_time ){ // TEMPO DI LEARNING

            if ( (simTime()-elapsed_time) >= sample_time) { // se è passato un sample_time
                //if(packetCount>max_pkt) max_pkt = packetCount;
                if(bitPerSample > max_bps) max_bps = bitPerSample; // controlla se deve aggiornare il massimo
                elapsed_time = simTime();
                std::cout << "bpsample " << bitPerSample << " max "<< max_bps << " t" << elapsed_time << std::endl;
                //packetCount = 0;
                bitPerSample = 0;
            }

        }else {                        // FINE LEARNING, INIZIO MONITOR

            if(susp_time_w > 0){
                Update_ip_table(datagram, __DEF_PKT_COUNT); //se siamo in allerta, tracciamo gli ip delle richieste
                calm_time_w = 0;

            }

            if ( (simTime()-elapsed_time) >= sample_time) {

                if(bitPerSample > max_bps){
                    if (susp_time_w < susp_w_limit) susp_time_w++; //incrementa finestra di allarme
                }else{
                    if(susp_time_w > 0) susp_time_w--; //decrementa finestra di allarme
                }

                if (susp_time_w == susp_w_limit){
                    std::cout << "ALLARME!!! bps " << bitPerSample << " max "<< max_bps << " t" << elapsed_time << " susp_time_w=" << susp_time_w << std::endl;

                    for(auto elem : ip_table)
                    {
                       if(elem.second > threshold) insertBlackList(elem.first);
                    }

                    std::cout << "BLACK_LIST" << std::endl;
                    for(auto elem : black_list)
                    {
                        std::cout << elem.first << " " << elem.second << std::endl;
                    }
                    //DEBUG
                    std::cout << "IP_TABLE" << std::endl;
                    for(auto elem : ip_table)
                    {
                        std::cout << elem.first << " " << elem.second << std::endl;
                    }
                    std::cout << "threshold " << threshold << " min " << min << " avg " << avg << std::endl;
                }
                else std::cout << "bps " << bitPerSample << " max "<< max_bps << " t" << elapsed_time << " susp_time_w=" << susp_time_w << std::endl;

                //stats
                emit(outThroughputPerSample, bitPerSample);


                elapsed_time = simTime();
                bitPerSample = 0;

                if(susp_time_w == 0){
                    calm_time_w++;
                    if (calm_time_w == 500) {
                        Reset_ip_table();
                        calm_time_w = 0;
                    }
                }
            }


        }
    }

}

void Defender::Update_ip_table(IPv4Datagram *datagram, int def_type)
{
    IPv4Address client = datagram->getSrcAddress();

    if(def_type == __DEF_BIT_COUNT){
        long int nbit = datagram->getBitLength();

        if(ip_table.find(client) != ip_table.end() ){

            ip_table[client] += nbit; //aggiorniamo valore

        }else{

            ip_table[client] = nbit; //inseriamo ip e valore
        }

        sum += nbit;
    }else if(def_type == __DEF_PKT_COUNT){

        if(ip_table.find(client) != ip_table.end() ){

            ip_table[client] += 1; //aggiorniamo valore

        }else{

            ip_table[client] = 1; //inseriamo ip e valore
        }

        sum += 1;
    }

    min = 0; // picco minimo, da mediare con avg, la media generale
    for(auto elem : ip_table)
    {
        if(min == 0) min = elem.second;
        else if(elem.second < min) min = elem.second;
    }

    avg = sum/ip_table.size();

    threshold = ((avg - min)/2)+min;
}

void Defender::insertBlackList(IPv4Address ip){

    black_list[ip] = simTime() + 0.015 * (ip_table[ip] - threshold); //il valore sarà il tempo in cui l'ip viene rimosso dalla blacklist
    if (startUpdateBL) {
        startUpdateBL = false;
        scheduleAt(simTime()+sample_time, updateBlackList);
    }
}

void Defender::Reset_ip_table(){
    ip_table.clear();
    sum = avg = min = threshold = 0;
}

void Defender::Update_black_list(){  // controlla ed elimina dalla blacklist eventuali ip che hanno già atteso abbastanza

    for (auto it = black_list.cbegin(); it != black_list.cend() /* not hoisted */; /* no increment */)
    {
        if (simTime() >= it->second)
        {
            std::cout << "eliminiamo da blacklist " << it->first << " t " << it->second << "e T = "<< simTime() << std::endl;
            black_list.erase(it++);
        }
        else
        {
            ++it;
        }
    }
}

void Defender::finish(){
    recordScalar("#drop_client", drop_pkt_client );
    recordScalar("#drop_zombie", drop_pkt_zombie );

}

// router.ppp[5] -> pacchetti droppati = 151455
// *.router.pppg$o[5].channel

// client: 5,9,18,53,73,89,101

// GRAFICI:
// intervalli confidenza della percentuale drop zombie, su diverse configurazioni (intensità e coda router)
