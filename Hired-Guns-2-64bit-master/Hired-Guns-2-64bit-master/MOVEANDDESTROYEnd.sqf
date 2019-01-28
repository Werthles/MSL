//pvs
private ["_mg", "_nt", "_van", "_missionFileName", "_theGroup", "_NPC", "_missionNumber", "_newTask", "_groupArray", "_missionObjectList", "_startTime", "_win", "_exit", "_dist"];

_mg = _this select 0;
_nt = _this select 1;
_van = _this select 2;
_missionFileName = _this select 3;
_theGroup = _this select 4;
_NPC = _this select 5;
_missionNumber = _this select 6;
_newTask = _this select 7;
_groupArray = _this select 8;
_missionObjectList = _this select 9;
_startTime = _this select 10;
_win = false;
_exit = false;
while {(time < (_startTime + MissionTimeLimit)) and !_exit} do
{
	sleep 15;
	if (!canMove _van) then
	{
		_dist = _van distance _mg;
		if (alive _van and _dist>=30) then
		{
			_exit = true;
		};
		
		if (!alive _van and _dist<30) then
		{
			_exit = true;
			_win = true;
			[_newTask,"SUCCEEDED"] call BIS_fnc_taskSetState;
AAA = 7;
			[_missionFileName,_theGroup,_NPC,_missionNumber,_newTask,_groupArray,_missionObjectList,"SUCCEEDED"] execVM "JobFinished.sqf";
		};
		
		if (!alive _van and _dist>=30) then
		{
			_exit = true;
		};
	};
};
if !(_win) then
{
	[_nt,"FAILED"] call BIS_fnc_taskSetState;
	deleteVehicle (vehicle _van);
	deleteVehicle _van;
};
sleep 15;
deleteVehicle _mg;
deleteVehicle (vehicle _van);
deleteVehicle _van;