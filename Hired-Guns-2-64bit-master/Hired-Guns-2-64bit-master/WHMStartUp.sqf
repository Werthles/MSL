//WHMStartUp.sqf
//Runs on all machines with WHM mod if WHM turned on
//Called once at start
//Called from init.sqf

private["_unit"];
if !(isServer) then
{//give server time to setup before clients start to communicate
	waitUntil{time>60};
};
_unit = NPC0;
//If the WHM is loaded on the machine and WHM is desired
if (isClass(configFile >> "CfgPatches" >> "Werthles_WHK") and (WHMActivate)==1) then
{
	_unit setVariable ["Repeating",True];
	_unit setVariable ["Wait",30];
	_unit setVariable ["Debug",True];
	_unit setVariable ["Advanced",True];
	_unit setVariable ["Delay",5];
	_unit setVariable ["Pause",3];
	_unit setVariable ["Report",True];
	_unit setVariable ["Ignores","NPC"];
	[_unit] spawn Werthles_fnc_moduleWHM;
};