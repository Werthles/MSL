//executes on human clients
//produces diary info when the WHM is activated
//WHM setup parameters, changelog and WHM intro

//private variables
private ["_unitsString", "_paramString"];

//params
params [["_units",[],[[]]],["_recurrent",true,[true]],["_timeBetween",30,[30]],["_debug",false,[false]],["_advanced",false,[false]],["_startDelay",30,[30]],["_pause",3,[3]],["_report",true,[true]],["_badNames",[],[[]]],["_debugOnly",false,[false]],["_noDebug",false,[false]],["_useServer",false,[false]]];

_unitsString = "";

//briefing descriptions
if (count _units > 0) then {_unitsString = str _units;} else {_unitsString = "All HCs";};
_paramString = format["
	WHM HCs:             %1<br/><br/>
	Repeated AI Check:    %2<br/><br/>
	Time Between Checks: %3<br/><br/>
	Debug For All:         %4<br/><br/>
	Advanced Algorithm:   %5<br/><br/>
	WHM Start Delay:     %6<br/><br/>
	WHM Syncing Pause:   %7<br/><br/>
	Show Setup Reports:   %8<br/><br/>
	Ignore Checklist:       %9<br/><br/>
	Debug Only:           %10<br/><br/>
	Disable Debug:         %11<br/><br/>
	Use Server for AI:    %12",
	_unitsString,_recurrent,_timeBetween,_debug,_advanced,_startDelay,_pause,_report,_badNames,_debugOnly,_noDebug,_useServer
];

player createDiarySubject ["WHK","WH Module"];
player createDiaryRecord ["WHK",["Updates","<font face='PuristaBold' size=20>v2.0</font><br/><font face='PuristaBold' size=12>New Features/Improvements
<br/>- Option to split AI among HCs AND the server,
<br/>- Option to not load any debug functionality for a small performance improvement,
<br/>- Option to only use WHM for the debug option,
<br/>- Explanation how to allow vanilla players to connect to WHM missions,
<br/>
<br/>- Memory leak fixes,
<br/>- Empty group cleanup now on HCs as well as server,
<br/>- Various algorithm efficiencies,
</font>"]];
player createDiaryRecord ["WHK",["Parameters","<font face='PuristaBold' size=16>Module Parameters</font><br/><br/><font face='PuristaBold' size=12>" + _paramString + "</font>"]];
player createDiaryRecord ["WHK",["Overview","<img image='\Werthles_WHK\data\iconWHMColour_ca.paa'/><br/><font face='PuristaBold' size=14 color='#2199c7'>Werthles' Headless Module</font><br/><font face='PuristaBold' size=12><br/>
The easy way to use headless clients to control AI.<br/><br/>
1) Place a WH Module and named, playable headless clients.<br/>
2) Connect Headless Clients to your server.<br/>
3) Play your mission!<br/><br/>
Please leave feedback wherever you downloaded this, and I'll check it out!</font>"]];
