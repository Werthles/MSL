//ASSASSINATEEnd.sqf
//pvs
private ["_mg", "_nt", "_missionFileName", "_theGroup", "_NPC", "_missionNumber", "_newTask", "_groupArray", "_missionObjectList", "_startTime", "_win", "_exit"];

_mg = _this select 0;
_nt = _this select 1;
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
while {((time < (_startTime + MissionTimeLimit)) and !_exit)} do
{
	sleep 15;
	if ((!canMove _mg) and (!canFire _mg)) then
	{
		_exit = true;
		_win = true;
		[_newTask,"SUCCEEDED"] call BIS_fnc_taskSetState;
AAA = 1;
		[_missionFileName,_theGroup,_NPC,_missionNumber,_newTask,_groupArray,_missionObjectList,"SUCCEEDED"] execVM "JobFinished.sqf";
	};
};
if !(_win) then
{
	[_nt,"FAILED"] call BIS_fnc_taskSetState;
AAA = 2;
	[_missionFileName,_theGroup,_NPC,_missionNumber,_newTask,_groupArray,_missionObjectList,"FAILED"] execVM "JobFinished.sqf";
};
sleep 15;
//after time is up
deleteVehicle _mg;