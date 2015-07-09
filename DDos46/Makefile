#
# OMNeT++/OMNEST Makefile for DDos46
#
# This file was generated with the command:
#  opp_makemake -f --deep -O out -I../inet/src/transport/tcp_common -I../inet/src/base -I../inet/src/util -I../inet/src/linklayer/ieee80211/mac -I../inet/src/transport/udp -I../inet/src/linklayer/ieee80211/radio/errormodel -I../inet/src/util/headerserializers -I../inet/src/linklayer/ieee80211/radio -I../inet/src/status -I../inet/src/transport/sctp -I../inet/src/networklayer/icmpv6 -I../inet/src/linklayer/radio/propagation -I../inet/src/transport/contract -I../inet/src/networklayer/ipv6tunneling -I../inet/src/world/radio -I../inet/src/linklayer/contract -I../inet/src/util/headerserializers/udp -I../inet/src/util/headerserializers/tcp -I../inet/src/linklayer/radio -I../inet/src/world/obstacles -I../inet/src/networklayer/common -I../inet/src/networklayer/ipv6 -I../inet/src/networklayer/arp -I../inet/src/networklayer/routing/aodv -I../inet/src/networklayer/contract -I../inet/src -I../inet/src/networklayer/xmipv6 -I../inet/src/util/headerserializers/sctp -I../inet/src/util/headerserializers/ipv6 -I../inet/src/battery/models -I../inet/src/networklayer/autorouting/ipv4 -I../inet/src/networklayer/ipv4 -I../inet/src/mobility/contract -I../inet/src/applications/pingapp -I../inet/src/linklayer/common -I../inet/src/util/headerserializers/ipv4 -L../inet/out/$$\(CONFIGNAME\)/src -linet -DINET_IMPORT -KINET_PROJ=../inet
#

# Name of target to be created (-o option)
TARGET = DDos46$(EXE_SUFFIX)

# User interface (uncomment one) (-u option)
USERIF_LIBS = $(ALL_ENV_LIBS) # that is, $(TKENV_LIBS) $(CMDENV_LIBS)
#USERIF_LIBS = $(CMDENV_LIBS)
#USERIF_LIBS = $(TKENV_LIBS)

# C++ include paths (with -I)
INCLUDE_PATH = \
    -I../inet/src/transport/tcp_common \
    -I../inet/src/base \
    -I../inet/src/util \
    -I../inet/src/linklayer/ieee80211/mac \
    -I../inet/src/transport/udp \
    -I../inet/src/linklayer/ieee80211/radio/errormodel \
    -I../inet/src/util/headerserializers \
    -I../inet/src/linklayer/ieee80211/radio \
    -I../inet/src/status \
    -I../inet/src/transport/sctp \
    -I../inet/src/networklayer/icmpv6 \
    -I../inet/src/linklayer/radio/propagation \
    -I../inet/src/transport/contract \
    -I../inet/src/networklayer/ipv6tunneling \
    -I../inet/src/world/radio \
    -I../inet/src/linklayer/contract \
    -I../inet/src/util/headerserializers/udp \
    -I../inet/src/util/headerserializers/tcp \
    -I../inet/src/linklayer/radio \
    -I../inet/src/world/obstacles \
    -I../inet/src/networklayer/common \
    -I../inet/src/networklayer/ipv6 \
    -I../inet/src/networklayer/arp \
    -I../inet/src/networklayer/routing/aodv \
    -I../inet/src/networklayer/contract \
    -I../inet/src \
    -I../inet/src/networklayer/xmipv6 \
    -I../inet/src/util/headerserializers/sctp \
    -I../inet/src/util/headerserializers/ipv6 \
    -I../inet/src/battery/models \
    -I../inet/src/networklayer/autorouting/ipv4 \
    -I../inet/src/networklayer/ipv4 \
    -I../inet/src/mobility/contract \
    -I../inet/src/applications/pingapp \
    -I../inet/src/linklayer/common \
    -I../inet/src/util/headerserializers/ipv4 \
    -I. \
    -Iddos \
    -Idefender \
    -Iresults \
    -Izombie

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
OBJS = $O/ddos/TribeFloodNetwork.o $O/defender/defender.o $O/defender/Def_IPv4.o $O/zombie/ZombieClient.o

# Message files
MSGFILES =

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
	$(Q)-rm -f DDos46 DDos46.exe libDDos46.so libDDos46.a libDDos46.dll libDDos46.dylib
	$(Q)-rm -f ./*_m.cc ./*_m.h
	$(Q)-rm -f ddos/*_m.cc ddos/*_m.h
	$(Q)-rm -f defender/*_m.cc defender/*_m.h
	$(Q)-rm -f results/*_m.cc results/*_m.h
	$(Q)-rm -f zombie/*_m.cc zombie/*_m.h

cleanall: clean
	$(Q)-rm -rf $(PROJECT_OUTPUT_DIR)

depend:
	$(qecho) Creating dependencies...
	$(Q)$(MAKEDEPEND) $(INCLUDE_PATH) -f Makefile -P\$$O/ -- $(MSG_CC_FILES)  ./*.cc ddos/*.cc defender/*.cc results/*.cc zombie/*.cc

# DO NOT DELETE THIS LINE -- make depend depends on it.
$O/ddos/TribeFloodNetwork.o: ddos/TribeFloodNetwork.cc \
	ddos/TribeFloodNetwork.h
$O/defender/Def_IPv4.o: defender/Def_IPv4.cc \
	defender/Def_IPv4.h \
	$(INET_PROJ)/src/base/AbstractQueue.h \
	$(INET_PROJ)/src/base/Compat.h \
	$(INET_PROJ)/src/base/ILifecycle.h \
	$(INET_PROJ)/src/base/INETDefs.h \
	$(INET_PROJ)/src/base/INotifiable.h \
	$(INET_PROJ)/src/base/ModuleAccess.h \
	$(INET_PROJ)/src/base/NotificationBoard.h \
	$(INET_PROJ)/src/base/NotifierConsts.h \
	$(INET_PROJ)/src/base/ProtocolMap.h \
	$(INET_PROJ)/src/base/QueueBase.h \
	$(INET_PROJ)/src/base/ReassemblyBuffer.h \
	$(INET_PROJ)/src/linklayer/contract/MACAddress.h \
	$(INET_PROJ)/src/networklayer/arp/IARPCache.h \
	$(INET_PROJ)/src/networklayer/common/INetfilter.h \
	$(INET_PROJ)/src/networklayer/common/InterfaceEntry.h \
	$(INET_PROJ)/src/networklayer/common/InterfaceToken.h \
	$(INET_PROJ)/src/networklayer/contract/IPProtocolId_m.h \
	$(INET_PROJ)/src/networklayer/contract/IPSocket.h \
	$(INET_PROJ)/src/networklayer/contract/IPv4Address.h \
	$(INET_PROJ)/src/networklayer/ipv4/ICMP.h \
	$(INET_PROJ)/src/networklayer/ipv4/ICMPAccess.h \
	$(INET_PROJ)/src/networklayer/ipv4/ICMPMessage.h \
	$(INET_PROJ)/src/networklayer/ipv4/ICMPMessage_m.h \
	$(INET_PROJ)/src/networklayer/ipv4/IPv4.h \
	$(INET_PROJ)/src/networklayer/ipv4/IPv4Datagram.h \
	$(INET_PROJ)/src/networklayer/ipv4/IPv4Datagram_m.h \
	$(INET_PROJ)/src/networklayer/ipv4/IPv4FragBuf.h \
	$(INET_PROJ)/src/networklayer/ipv4/IPv4InterfaceData.h \
	$(INET_PROJ)/src/networklayer/ipv4/IPv4Route.h \
	$(INET_PROJ)/src/networklayer/ipv4/IRoutingTable.h \
	$(INET_PROJ)/src/networklayer/ipv4/RoutingTableAccess.h
$O/defender/defender.o: defender/defender.cc \
	defender/defender.h \
	$(INET_PROJ)/src/base/Compat.h \
	$(INET_PROJ)/src/base/INETDefs.h \
	$(INET_PROJ)/src/networklayer/contract/IPProtocolId_m.h \
	$(INET_PROJ)/src/networklayer/contract/IPv4Address.h \
	$(INET_PROJ)/src/networklayer/ipv4/IPv4Datagram.h \
	$(INET_PROJ)/src/networklayer/ipv4/IPv4Datagram_m.h
$O/zombie/ZombieClient.o: zombie/ZombieClient.cc

