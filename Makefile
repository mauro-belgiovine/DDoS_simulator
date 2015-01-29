#
# OMNeT++/OMNEST Makefile for DDoS_simulator
#
# This file was generated with the command:
#  opp_makemake -f --deep -O out -I../inet/src/linklayer/ieee80211/radio -I../inet/src/networklayer/routing/aodv -I../inet/src/networklayer/common -I../inet/src -I../inet/src/networklayer/icmpv6 -I../inet/src/world/obstacles -I../inet/src/networklayer/xmipv6 -I../inet/src/networklayer/contract -I../inet/src/networklayer/autorouting/ipv4 -I../inet/src/util -I../inet/src/linklayer/common -I../inet/src/transport/contract -I../inet/src/status -I../inet/src/linklayer/radio/propagation -I../inet/src/linklayer/ieee80211/radio/errormodel -I../inet/src/linklayer/radio -I../inet/src/util/headerserializers/tcp -I../inet/src/networklayer/ipv4 -I../inet/src/mobility/contract -I../inet/src/util/headerserializers/ipv4 -I../inet/src/base -I../inet/src/util/headerserializers -I../inet/src/world/radio -I../inet/src/linklayer/ieee80211/mac -I../inet/src/networklayer/ipv6 -I../inet/src/transport/sctp -I../inet/src/util/headerserializers/udp -I../inet/src/networklayer/ipv6tunneling -I../inet/src/applications/pingapp -I../inet/src/battery/models -I../inet/src/util/headerserializers/ipv6 -I../inet/src/util/headerserializers/sctp -I../inet/src/linklayer/contract -I../inet/src/networklayer/arp -I../inet/src/transport/tcp_common -I../inet/src/transport/udp -L../inet/out/$$\(CONFIGNAME\)/src -linet -DINET_IMPORT -KINET_PROJ=../inet
#

# Name of target to be created (-o option)
TARGET = DDoS_simulator$(EXE_SUFFIX)

# User interface (uncomment one) (-u option)
USERIF_LIBS = $(ALL_ENV_LIBS) # that is, $(TKENV_LIBS) $(CMDENV_LIBS)
#USERIF_LIBS = $(CMDENV_LIBS)
#USERIF_LIBS = $(TKENV_LIBS)

# C++ include paths (with -I)
INCLUDE_PATH = \
    -I../inet/src/linklayer/ieee80211/radio \
    -I../inet/src/networklayer/routing/aodv \
    -I../inet/src/networklayer/common \
    -I../inet/src \
    -I../inet/src/networklayer/icmpv6 \
    -I../inet/src/world/obstacles \
    -I../inet/src/networklayer/xmipv6 \
    -I../inet/src/networklayer/contract \
    -I../inet/src/networklayer/autorouting/ipv4 \
    -I../inet/src/util \
    -I../inet/src/linklayer/common \
    -I../inet/src/transport/contract \
    -I../inet/src/status \
    -I../inet/src/linklayer/radio/propagation \
    -I../inet/src/linklayer/ieee80211/radio/errormodel \
    -I../inet/src/linklayer/radio \
    -I../inet/src/util/headerserializers/tcp \
    -I../inet/src/networklayer/ipv4 \
    -I../inet/src/mobility/contract \
    -I../inet/src/util/headerserializers/ipv4 \
    -I../inet/src/base \
    -I../inet/src/util/headerserializers \
    -I../inet/src/world/radio \
    -I../inet/src/linklayer/ieee80211/mac \
    -I../inet/src/networklayer/ipv6 \
    -I../inet/src/transport/sctp \
    -I../inet/src/util/headerserializers/udp \
    -I../inet/src/networklayer/ipv6tunneling \
    -I../inet/src/applications/pingapp \
    -I../inet/src/battery/models \
    -I../inet/src/util/headerserializers/ipv6 \
    -I../inet/src/util/headerserializers/sctp \
    -I../inet/src/linklayer/contract \
    -I../inet/src/networklayer/arp \
    -I../inet/src/transport/tcp_common \
    -I../inet/src/transport/udp \
    -I. \
    -Isrc \
    -Isrc/applications \
    -Isrc/applications/ddos \
    -Isrc/applications/generic \
    -Isrc/applications/pingApp \
    -Isrc/applications/tcpApp \
    -Isrc/base \
    -Isrc/networklayer \
    -Isrc/networklayer/contract \
    -Isrc/networklayer/ipv4 \
    -Isrc/nodes \
    -Isrc/nodes/inet

# Additional object and library files to link with
EXTRA_OBJS =

# Additional libraries (-L, -l options)
LIBS = -L../inet/out/$(CONFIGNAME)/src  -linet
LIBS += -Wl,-rpath,`abspath ../inet/out/$(CONFIGNAME)/src`

# Output directory
PROJECT_OUTPUT_DIR = out
PROJECTRELATIVE_PATH =
O = $(PROJECT_OUTPUT_DIR)/$(CONFIGNAME)/$(PROJECTRELATIVE_PATH)

# Object files for local .cc and .msg files
OBJS = \
    $O/src/applications/ddos/TribeFloodNetwork.o \
    $O/src/applications/generic/InetUser.o \
    $O/src/applications/generic/GenericApplication.o \
    $O/src/applications/pingApp/GenericICMPPingApplication.o \
    $O/src/applications/tcpApp/GenericTCPApplicationClientThread.o \
    $O/src/applications/tcpApp/GenericTCPApplicationServerThread.o \
    $O/src/applications/tcpApp/GenericTCPApplication.o \
    $O/src/base/TrafficProfileManager.o \
    $O/src/base/ConnectionManager.o \
    $O/src/networklayer/ipv4/IPv4_hack.o \
    $O/src/applications/generic/GenericApplicationMessage_m.o \
    $O/src/networklayer/contract/IPv4ControlInfo_hacked_m.o \
    $O/src/networklayer/contract/IPv6ControlInfo_hacked_m.o \
    $O/src/networklayer/ipv4/IPv4Datagram_hacked_m.o

# Message files
MSGFILES = \
    src/applications/generic/GenericApplicationMessage.msg \
    src/networklayer/contract/IPv4ControlInfo_hacked.msg \
    src/networklayer/contract/IPv6ControlInfo_hacked.msg \
    src/networklayer/ipv4/IPv4Datagram_hacked.msg

# Other makefile variables (-K)
INET_PROJ=../inet

#------------------------------------------------------------------------------

# Pull in OMNeT++ configuration (Makefile.inc or configuser.vc)

ifneq ("$(OMNETPP_CONFIGFILE)","")
CONFIGFILE = $(OMNETPP_CONFIGFILE)
else
ifneq ("$(OMNETPP_ROOT)","")
CONFIGFILE = $(OMNETPP_ROOT)/Makefile.inc
else
CONFIGFILE = $(shell opp_configfilepath)
endif
endif

ifeq ("$(wildcard $(CONFIGFILE))","")
$(error Config file '$(CONFIGFILE)' does not exist -- add the OMNeT++ bin directory to the path so that opp_configfilepath can be found, or set the OMNETPP_CONFIGFILE variable to point to Makefile.inc)
endif

include $(CONFIGFILE)

# Simulation kernel and user interface libraries
OMNETPP_LIB_SUBDIR = $(OMNETPP_LIB_DIR)/$(TOOLCHAIN_NAME)
OMNETPP_LIBS = -L"$(OMNETPP_LIB_SUBDIR)" -L"$(OMNETPP_LIB_DIR)" -loppmain$D $(USERIF_LIBS) $(KERNEL_LIBS) $(SYS_LIBS)

COPTS = $(CFLAGS) -DINET_IMPORT $(INCLUDE_PATH) -I$(OMNETPP_INCL_DIR)
MSGCOPTS = $(INCLUDE_PATH)

# we want to recompile everything if COPTS changes,
# so we store COPTS into $COPTS_FILE and have object
# files depend on it (except when "make depend" was called)
COPTS_FILE = $O/.last-copts
ifneq ($(MAKECMDGOALS),depend)
ifneq ("$(COPTS)","$(shell cat $(COPTS_FILE) 2>/dev/null || echo '')")
$(shell $(MKPATH) "$O" && echo "$(COPTS)" >$(COPTS_FILE))
endif
endif

#------------------------------------------------------------------------------
# User-supplied makefile fragment(s)
# >>>
# <<<
#------------------------------------------------------------------------------

# Main target
all: $O/$(TARGET)
	$(Q)$(LN) $O/$(TARGET) .

$O/$(TARGET): $(OBJS)  $(wildcard $(EXTRA_OBJS)) Makefile
	@$(MKPATH) $O
	@echo Creating executable: $@
	$(Q)$(CXX) $(LDFLAGS) -o $O/$(TARGET)  $(OBJS) $(EXTRA_OBJS) $(AS_NEEDED_OFF) $(WHOLE_ARCHIVE_ON) $(LIBS) $(WHOLE_ARCHIVE_OFF) $(OMNETPP_LIBS)

.PHONY: all clean cleanall depend msgheaders

.SUFFIXES: .cc

$O/%.o: %.cc $(COPTS_FILE)
	@$(MKPATH) $(dir $@)
	$(qecho) "$<"
	$(Q)$(CXX) -c $(CXXFLAGS) $(COPTS) -o $@ $<

%_m.cc %_m.h: %.msg
	$(qecho) MSGC: $<
	$(Q)$(MSGC) -s _m.cc $(MSGCOPTS) $?

msgheaders: $(MSGFILES:.msg=_m.h)

clean:
	$(qecho) Cleaning...
	$(Q)-rm -rf $O
	$(Q)-rm -f DDoS_simulator DDoS_simulator.exe libDDoS_simulator.so libDDoS_simulator.a libDDoS_simulator.dll libDDoS_simulator.dylib
	$(Q)-rm -f ./*_m.cc ./*_m.h
	$(Q)-rm -f src/*_m.cc src/*_m.h
	$(Q)-rm -f src/applications/*_m.cc src/applications/*_m.h
	$(Q)-rm -f src/applications/ddos/*_m.cc src/applications/ddos/*_m.h
	$(Q)-rm -f src/applications/generic/*_m.cc src/applications/generic/*_m.h
	$(Q)-rm -f src/applications/pingApp/*_m.cc src/applications/pingApp/*_m.h
	$(Q)-rm -f src/applications/tcpApp/*_m.cc src/applications/tcpApp/*_m.h
	$(Q)-rm -f src/base/*_m.cc src/base/*_m.h
	$(Q)-rm -f src/networklayer/*_m.cc src/networklayer/*_m.h
	$(Q)-rm -f src/networklayer/contract/*_m.cc src/networklayer/contract/*_m.h
	$(Q)-rm -f src/networklayer/ipv4/*_m.cc src/networklayer/ipv4/*_m.h
	$(Q)-rm -f src/nodes/*_m.cc src/nodes/*_m.h
	$(Q)-rm -f src/nodes/inet/*_m.cc src/nodes/inet/*_m.h

cleanall: clean
	$(Q)-rm -rf $(PROJECT_OUTPUT_DIR)

depend:
	$(qecho) Creating dependencies...
	$(Q)$(MAKEDEPEND) $(INCLUDE_PATH) -f Makefile -P\$$O/ -- $(MSG_CC_FILES)  ./*.cc src/*.cc src/applications/*.cc src/applications/ddos/*.cc src/applications/generic/*.cc src/applications/pingApp/*.cc src/applications/tcpApp/*.cc src/base/*.cc src/networklayer/*.cc src/networklayer/contract/*.cc src/networklayer/ipv4/*.cc src/nodes/*.cc src/nodes/inet/*.cc

# DO NOT DELETE THIS LINE -- make depend depends on it.
$O/src/applications/ddos/TribeFloodNetwork.o: src/applications/ddos/TribeFloodNetwork.cc \
	src/applications/ddos/TribeFloodNetwork.h \
	src/base/ReaSEDefs.h \
	src/networklayer/contract/IPv4ControlInfo_hacked_m.h \
	src/networklayer/contract/IPv6ControlInfo_hacked_m.h \
	$(INET_PROJ)/src/applications/pingapp/PingPayload_m.h \
	$(INET_PROJ)/src/base/ByteArray.h \
	$(INET_PROJ)/src/base/ByteArray_m.h \
	$(INET_PROJ)/src/base/Compat.h \
	$(INET_PROJ)/src/base/ILifecycle.h \
	$(INET_PROJ)/src/base/INETDefs.h \
	$(INET_PROJ)/src/base/INotifiable.h \
	$(INET_PROJ)/src/base/ModuleAccess.h \
	$(INET_PROJ)/src/base/NotificationBoard.h \
	$(INET_PROJ)/src/base/NotifierConsts.h \
	$(INET_PROJ)/src/linklayer/contract/MACAddress.h \
	$(INET_PROJ)/src/networklayer/arp/ARP.h \
	$(INET_PROJ)/src/networklayer/arp/IARPCache.h \
	$(INET_PROJ)/src/networklayer/contract/IPProtocolId_m.h \
	$(INET_PROJ)/src/networklayer/contract/IPv4Address.h \
	$(INET_PROJ)/src/networklayer/contract/IPv4ControlInfo.h \
	$(INET_PROJ)/src/networklayer/contract/IPv4ControlInfo_m.h \
	$(INET_PROJ)/src/networklayer/contract/IPv6Address.h \
	$(INET_PROJ)/src/networklayer/contract/IPv6ControlInfo.h \
	$(INET_PROJ)/src/networklayer/contract/IPv6ControlInfo_m.h \
	$(INET_PROJ)/src/networklayer/contract/IPvXAddress.h \
	$(INET_PROJ)/src/networklayer/contract/IPvXAddressResolver.h \
	$(INET_PROJ)/src/networklayer/ipv4/ICMP.h \
	$(INET_PROJ)/src/networklayer/ipv4/ICMPMessage.h \
	$(INET_PROJ)/src/networklayer/ipv4/ICMPMessage_m.h \
	$(INET_PROJ)/src/networklayer/ipv4/IPv4Route.h \
	$(INET_PROJ)/src/networklayer/ipv4/IRoutingTable.h \
	$(INET_PROJ)/src/networklayer/ipv4/RoutingTableAccess.h \
	$(INET_PROJ)/src/transport/contract/UDPControlInfo_m.h \
	$(INET_PROJ)/src/transport/tcp_common/TCPSegment.h \
	$(INET_PROJ)/src/transport/tcp_common/TCPSegment_m.h \
	$(INET_PROJ)/src/transport/udp/UDPPacket.h \
	$(INET_PROJ)/src/transport/udp/UDPPacket_m.h
$O/src/applications/generic/GenericApplication.o: src/applications/generic/GenericApplication.cc \
	src/applications/generic/GenericApplication.h \
	src/applications/generic/InetUser.h \
	src/applications/generic/TransmissionConfig.h \
	src/base/ConnectionManager.h \
	src/base/ReaSEDefs.h \
	src/base/TrafficProfileManager.h \
	$(INET_PROJ)/src/base/Compat.h \
	$(INET_PROJ)/src/base/INETDefs.h \
	$(INET_PROJ)/src/base/ModuleAccess.h \
	$(INET_PROJ)/src/networklayer/contract/IPv4Address.h \
	$(INET_PROJ)/src/networklayer/contract/IPv6Address.h \
	$(INET_PROJ)/src/networklayer/contract/IPvXAddress.h \
	$(INET_PROJ)/src/networklayer/contract/IPvXAddressResolver.h
$O/src/applications/generic/GenericApplicationMessage_m.o: src/applications/generic/GenericApplicationMessage_m.cc \
	src/applications/generic/GenericApplicationMessage_m.h \
	src/base/ReaSEDefs.h \
	$(INET_PROJ)/src/base/Compat.h \
	$(INET_PROJ)/src/base/INETDefs.h
$O/src/applications/generic/InetUser.o: src/applications/generic/InetUser.cc \
	src/applications/generic/GenericApplication.h \
	src/applications/generic/InetUser.h \
	src/applications/generic/TransmissionConfig.h \
	src/applications/pingApp/GenericICMPPingApplication.h \
	src/applications/tcpApp/GenericTCPApplication.h \
	src/base/ConnectionManager.h \
	src/base/ReaSEDefs.h \
	src/base/TrafficProfileManager.h \
	$(INET_PROJ)/src/base/Compat.h \
	$(INET_PROJ)/src/base/INETDefs.h \
	$(INET_PROJ)/src/base/ModuleAccess.h \
	$(INET_PROJ)/src/networklayer/contract/IPv4Address.h \
	$(INET_PROJ)/src/networklayer/contract/IPv6Address.h \
	$(INET_PROJ)/src/networklayer/contract/IPvXAddress.h \
	$(INET_PROJ)/src/transport/contract/TCPCommand_m.h \
	$(INET_PROJ)/src/transport/contract/TCPSocket.h \
	$(INET_PROJ)/src/transport/contract/TCPSocketMap.h
$O/src/applications/pingApp/GenericICMPPingApplication.o: src/applications/pingApp/GenericICMPPingApplication.cc \
	src/applications/generic/GenericApplication.h \
	src/applications/generic/InetUser.h \
	src/applications/generic/TransmissionConfig.h \
	src/applications/pingApp/GenericICMPPingApplication.h \
	src/base/ConnectionManager.h \
	src/base/ReaSEDefs.h \
	src/base/TrafficProfileManager.h \
	$(INET_PROJ)/src/applications/pingapp/PingPayload_m.h \
	$(INET_PROJ)/src/base/Compat.h \
	$(INET_PROJ)/src/base/INETDefs.h \
	$(INET_PROJ)/src/base/ModuleAccess.h \
	$(INET_PROJ)/src/linklayer/contract/MACAddress.h \
	$(INET_PROJ)/src/networklayer/contract/IPProtocolId_m.h \
	$(INET_PROJ)/src/networklayer/contract/IPv4Address.h \
	$(INET_PROJ)/src/networklayer/contract/IPv4ControlInfo.h \
	$(INET_PROJ)/src/networklayer/contract/IPv4ControlInfo_m.h \
	$(INET_PROJ)/src/networklayer/contract/IPv6Address.h \
	$(INET_PROJ)/src/networklayer/contract/IPv6ControlInfo.h \
	$(INET_PROJ)/src/networklayer/contract/IPv6ControlInfo_m.h \
	$(INET_PROJ)/src/networklayer/contract/IPvXAddress.h \
	$(INET_PROJ)/src/networklayer/contract/IPvXAddressResolver.h
$O/src/applications/tcpApp/GenericTCPApplication.o: src/applications/tcpApp/GenericTCPApplication.cc \
	src/applications/generic/GenericApplication.h \
	src/applications/generic/InetUser.h \
	src/applications/generic/TransmissionConfig.h \
	src/applications/tcpApp/GenericTCPApplication.h \
	src/applications/tcpApp/GenericTCPApplicationClientThread.h \
	src/applications/tcpApp/GenericTCPApplicationServerThread.h \
	src/base/ConnectionManager.h \
	src/base/ReaSEDefs.h \
	src/base/TrafficProfileManager.h \
	$(INET_PROJ)/src/base/Compat.h \
	$(INET_PROJ)/src/base/INETDefs.h \
	$(INET_PROJ)/src/base/ModuleAccess.h \
	$(INET_PROJ)/src/networklayer/contract/IPv4Address.h \
	$(INET_PROJ)/src/networklayer/contract/IPv6Address.h \
	$(INET_PROJ)/src/networklayer/contract/IPvXAddress.h \
	$(INET_PROJ)/src/transport/contract/TCPCommand_m.h \
	$(INET_PROJ)/src/transport/contract/TCPSocket.h \
	$(INET_PROJ)/src/transport/contract/TCPSocketMap.h
$O/src/applications/tcpApp/GenericTCPApplicationClientThread.o: src/applications/tcpApp/GenericTCPApplicationClientThread.cc \
	src/applications/generic/GenericApplication.h \
	src/applications/generic/GenericApplicationMessage_m.h \
	src/applications/generic/InetUser.h \
	src/applications/generic/TransmissionConfig.h \
	src/applications/tcpApp/GenericTCPApplication.h \
	src/applications/tcpApp/GenericTCPApplicationClientThread.h \
	src/base/ConnectionManager.h \
	src/base/ReaSEDefs.h \
	src/base/TrafficProfileManager.h \
	$(INET_PROJ)/src/base/Compat.h \
	$(INET_PROJ)/src/base/INETDefs.h \
	$(INET_PROJ)/src/base/ModuleAccess.h \
	$(INET_PROJ)/src/networklayer/contract/IPv4Address.h \
	$(INET_PROJ)/src/networklayer/contract/IPv6Address.h \
	$(INET_PROJ)/src/networklayer/contract/IPvXAddress.h \
	$(INET_PROJ)/src/transport/contract/TCPCommand_m.h \
	$(INET_PROJ)/src/transport/contract/TCPSocket.h \
	$(INET_PROJ)/src/transport/contract/TCPSocketMap.h
$O/src/applications/tcpApp/GenericTCPApplicationServerThread.o: src/applications/tcpApp/GenericTCPApplicationServerThread.cc \
	src/applications/generic/GenericApplication.h \
	src/applications/generic/GenericApplicationMessage_m.h \
	src/applications/generic/InetUser.h \
	src/applications/generic/TransmissionConfig.h \
	src/applications/tcpApp/GenericTCPApplication.h \
	src/applications/tcpApp/GenericTCPApplicationServerThread.h \
	src/base/ConnectionManager.h \
	src/base/ReaSEDefs.h \
	src/base/TrafficProfileManager.h \
	$(INET_PROJ)/src/base/Compat.h \
	$(INET_PROJ)/src/base/INETDefs.h \
	$(INET_PROJ)/src/base/ModuleAccess.h \
	$(INET_PROJ)/src/networklayer/contract/IPv4Address.h \
	$(INET_PROJ)/src/networklayer/contract/IPv6Address.h \
	$(INET_PROJ)/src/networklayer/contract/IPvXAddress.h \
	$(INET_PROJ)/src/transport/contract/TCPCommand_m.h \
	$(INET_PROJ)/src/transport/contract/TCPSocket.h \
	$(INET_PROJ)/src/transport/contract/TCPSocketMap.h
$O/src/base/ConnectionManager.o: src/base/ConnectionManager.cc \
	src/applications/generic/TransmissionConfig.h \
	src/base/ConnectionManager.h \
	src/base/ReaSEDefs.h \
	src/base/TrafficProfileManager.h \
	$(INET_PROJ)/src/base/Compat.h \
	$(INET_PROJ)/src/base/INETDefs.h \
	$(INET_PROJ)/src/base/ModuleAccess.h \
	$(INET_PROJ)/src/networklayer/contract/IPv4Address.h \
	$(INET_PROJ)/src/networklayer/contract/IPv6Address.h \
	$(INET_PROJ)/src/networklayer/contract/IPvXAddress.h
$O/src/base/TrafficProfileManager.o: src/base/TrafficProfileManager.cc \
	src/applications/generic/TransmissionConfig.h \
	src/base/ReaSEDefs.h \
	src/base/TrafficProfileManager.h \
	$(INET_PROJ)/src/base/Compat.h \
	$(INET_PROJ)/src/base/INETDefs.h \
	$(INET_PROJ)/src/base/ModuleAccess.h \
	$(INET_PROJ)/src/networklayer/contract/IPv4Address.h \
	$(INET_PROJ)/src/networklayer/contract/IPv6Address.h \
	$(INET_PROJ)/src/networklayer/contract/IPvXAddress.h
$O/src/networklayer/contract/IPv4ControlInfo_hacked_m.o: src/networklayer/contract/IPv4ControlInfo_hacked_m.cc \
	src/networklayer/contract/IPv4ControlInfo_hacked_m.h \
	$(INET_PROJ)/src/base/Compat.h \
	$(INET_PROJ)/src/base/INETDefs.h \
	$(INET_PROJ)/src/linklayer/contract/MACAddress.h \
	$(INET_PROJ)/src/networklayer/contract/IPProtocolId_m.h \
	$(INET_PROJ)/src/networklayer/contract/IPv4Address.h \
	$(INET_PROJ)/src/networklayer/contract/IPv4ControlInfo.h \
	$(INET_PROJ)/src/networklayer/contract/IPv4ControlInfo_m.h
$O/src/networklayer/contract/IPv6ControlInfo_hacked_m.o: src/networklayer/contract/IPv6ControlInfo_hacked_m.cc \
	src/base/ReaSEDefs.h \
	src/networklayer/contract/IPv6ControlInfo_hacked_m.h \
	$(INET_PROJ)/src/base/Compat.h \
	$(INET_PROJ)/src/base/INETDefs.h \
	$(INET_PROJ)/src/networklayer/contract/IPProtocolId_m.h \
	$(INET_PROJ)/src/networklayer/contract/IPv6Address.h \
	$(INET_PROJ)/src/networklayer/contract/IPv6ControlInfo.h \
	$(INET_PROJ)/src/networklayer/contract/IPv6ControlInfo_m.h
$O/src/networklayer/ipv4/IPv4Datagram_hacked_m.o: src/networklayer/ipv4/IPv4Datagram_hacked_m.cc \
	src/networklayer/ipv4/IPv4Datagram_hacked_m.h \
	$(INET_PROJ)/src/base/Compat.h \
	$(INET_PROJ)/src/base/INETDefs.h \
	$(INET_PROJ)/src/networklayer/contract/IPProtocolId_m.h \
	$(INET_PROJ)/src/networklayer/contract/IPv4Address.h \
	$(INET_PROJ)/src/networklayer/ipv4/IPv4Datagram.h \
	$(INET_PROJ)/src/networklayer/ipv4/IPv4Datagram_m.h
$O/src/networklayer/ipv4/IPv4_hack.o: src/networklayer/ipv4/IPv4_hack.cc \
	src/networklayer/contract/IPv4ControlInfo_hacked_m.h \
	src/networklayer/ipv4/IPv4Datagram_hacked_m.h \
	src/networklayer/ipv4/IPv4_hack.h \
	$(INET_PROJ)/src/base/AbstractQueue.h \
	$(INET_PROJ)/src/base/Compat.h \
	$(INET_PROJ)/src/base/ILifecycle.h \
	$(INET_PROJ)/src/base/INETDefs.h \
	$(INET_PROJ)/src/base/ModuleAccess.h \
	$(INET_PROJ)/src/base/NotifierConsts.h \
	$(INET_PROJ)/src/base/ProtocolMap.h \
	$(INET_PROJ)/src/base/QueueBase.h \
	$(INET_PROJ)/src/base/ReassemblyBuffer.h \
	$(INET_PROJ)/src/linklayer/contract/MACAddress.h \
	$(INET_PROJ)/src/networklayer/arp/ARPPacket_m.h \
	$(INET_PROJ)/src/networklayer/arp/IARPCache.h \
	$(INET_PROJ)/src/networklayer/common/INetfilter.h \
	$(INET_PROJ)/src/networklayer/common/InterfaceEntry.h \
	$(INET_PROJ)/src/networklayer/common/InterfaceToken.h \
	$(INET_PROJ)/src/networklayer/contract/IPProtocolId_m.h \
	$(INET_PROJ)/src/networklayer/contract/IPv4Address.h \
	$(INET_PROJ)/src/networklayer/contract/IPv4ControlInfo.h \
	$(INET_PROJ)/src/networklayer/contract/IPv4ControlInfo_m.h \
	$(INET_PROJ)/src/networklayer/ipv4/ICMP.h \
	$(INET_PROJ)/src/networklayer/ipv4/ICMPAccess.h \
	$(INET_PROJ)/src/networklayer/ipv4/ICMPMessage.h \
	$(INET_PROJ)/src/networklayer/ipv4/ICMPMessage_m.h \
	$(INET_PROJ)/src/networklayer/ipv4/IPv4.h \
	$(INET_PROJ)/src/networklayer/ipv4/IPv4Datagram.h \
	$(INET_PROJ)/src/networklayer/ipv4/IPv4Datagram_m.h \
	$(INET_PROJ)/src/networklayer/ipv4/IPv4FragBuf.h \
	$(INET_PROJ)/src/networklayer/ipv4/IPv4Route.h \
	$(INET_PROJ)/src/networklayer/ipv4/IRoutingTable.h \
	$(INET_PROJ)/src/networklayer/ipv4/RoutingTableAccess.h

