cplusplus {{
#include "IPv4ControlInfo.h"
#include "ReaSEDefs.h"
}}

class noncobject IPv4ControlInfo;

class IPv4ControlInfo_hacked extends IPv4ControlInfo
{
	// ReaSE: for attack tracing, each IP packet contains an attackTag
	short attackTag = 0;
}
