//PMLocalSetup.sqf
//Runs on players
//Called by players
//Called from PMAddAction1
//Loads addActions for second part of PM

//pvs
private ["_missionType", "_missionLevel", "_object", "_starter","_pos"];

_missionType = _this select 0;
_missionLevel = _this select 1;
_object = _this select 2;
_starter = _this select 3;

if (!(isNil "PMLootAction1") and !(str _starter == str player)) then
{
	_object removeAction PMLootAction1;
};

//set drop off point as task destination
_pos = PMLootDropOffs select _missionType select _missionLevel;
[format["PM%1b%2",_missionType,_missionLevel],_pos] call BIS_fnc_taskSetDestination;

_object lock false;

if (str player == str _starter) then
{
	PMLootAction2 = _object addAction ["Loot - Distribute","PMAddAction2.sqf",[_missionType,_missionLevel,_starter],200];
	[57,nil] call Messages;
}
else
{
	PMLootAction2 = _object addAction ["Loot - Defend","",[],200];
};