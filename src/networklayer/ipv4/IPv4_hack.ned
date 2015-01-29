package ddos_simulator.src.networklayer.ipv4;

import inet.networklayer.ipv4.IPv4;

//
// An extension of inet.networklayer.ipv4.IPv4
// This module additionally allows for address spoofing and
// packet tracing
//

simple IPv4_hack extends IPv4
{
    parameters:
        @class(IPv4_hack);
        bool tracingOn;
        double tracingInterval @unit(s);
        double traceStartTime @unit(s);
        bool spoofingOn; // allow IP-Address Spoofing
}

