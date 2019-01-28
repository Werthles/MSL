//TRANSPORTEnd.sqf

//pvs
private ["_newTrig", "_newTask", "_missionObject", "_missionFileName", "_theGroup", "_NPC", "_missionNumber", "_groupArray", "_missionObjectList", "_startTime", "_win", "_exit", "_state"];

_newTrig = _this select 0;
_newTask = _this select 1;
_missionObject = _this select 2;
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
	_state = triggerActivated _newTrig;
	if (_state) then
	{
		_exit = true;
		_win = true;
		[_newTask,"SUCCEEDED"] call BIS_fnc_taskSetState;
AAA = 5;
		[_missionFileName,_theGroup,_NPC,_missionNumber,_newTask,_groupArray,_missionObjectList,"SUCCEEDED"] execVM "JobFinished.sqf";
	};
	if (!canMove _missionObject) then
	{
		_exit = true;
	};
};
if !(_win) then
{
	[_newTask,"FAILED"] call BIS_fnc_taskSetState;
AAA = 6;
	[_missionFileName,_theGroup,_NPC,_missionNumber,_newTask,_groupArray,_missionObjectList,"FAILED"] execVM "JobFinished.sqf";
};
deleteMarker ("DropOff"+_missionFileName);
deleteMarker ("DropOffWords"+_missionFileName);