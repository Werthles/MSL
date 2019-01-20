hint "Serversave";
params [["_clientID",-2,[0]]];
private ["_inidbi","_dateTime"];
[] remoteExec ["Werthles_fnc_MSLSavePlayer",_clientID];

_dateTime = parseSimpleArray ("real_date" callExtension "+");
_inidbi = ["new", worldName + "_" + missionName + "_(" +
str(_dateTime select 2) + "." + str (_dateTime select 1) + "." + str (_dateTime select 0) + "_" + str(_dateTime select 3) +"." + str(_dateTime select 4) + "." + str(_dateTime select 5) + ")" 
	] call OO_INIDBI;
{
	["write", ["ALLUNITS", _forEachIndex, typeOf _x]] call _inidbi;	//className
} forEach allUnits;