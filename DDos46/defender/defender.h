#ifndef  __DEFENDER_H
#define __DEFENDER_H

#include "IPv4Datagram.h"
#include <map>

#define __DEF_PKT_COUNT 0
#define __DEF_BIT_COUNT 1

class Defender  : public cSimpleModule {

        private:
            long int bitPerSample = 0;
            long int max_bps = 0;   // picco massimo di attività in fase learning
            simtime_t elapsed_time = 0;
            simtime_t in_elapsed_time = 0;
            simtime_t learning_time = 0;
            simtime_t sample_time = 0.05;
            int susp_time_w = 0;
            int susp_w_limit = 5;
            bool defense_mode = true;
            cMessage *updateBlackList;
            bool startUpdateBL = true;
            int calm_time_w = 0;

            std::map <IPv4Address, long int> ip_table;
            std::map <IPv4Address, simtime_t> black_list;
            long int sum = 0;
            long int min = 0;
            long int avg = 0;
            long int threshold = 0;

            long int drop_pkt_client = 0;
            long int drop_pkt_zombie = 0;

            static simsignal_t inThroughputPerSample;
            static simsignal_t outThroughputPerSample;
            long int inBitPerSample = 0;

            IPv4Address *client1 = new IPv4Address("192.168.1.5");
            IPv4Address *client2 = new IPv4Address("192.168.1.9");
            IPv4Address *client3 = new IPv4Address("192.168.1.18");

            IPv4Address *client4 = new IPv4Address("192.168.1.53");
            IPv4Address *client5 = new IPv4Address("192.168.1.73");
            IPv4Address *client6 = new IPv4Address("192.168.1.101");
            IPv4Address *client7 = new IPv4Address("192.168.1.89");



        protected:
                virtual void initialize();
                virtual void handleMessage(cMessage *msg);
                virtual void finish();
                virtual void IncomingTrafficMonitor(IPv4Datagram *datagram);
                virtual void Update_ip_table(IPv4Datagram *datagram, int def_type);
                virtual void insertBlackList(IPv4Address ip);
                virtual void Reset_ip_table();
                virtual void Update_black_list();
};

#endif
