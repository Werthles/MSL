//DEMOLITIONEnd.sqf

//pvs
private ["_mg", "_nt", "_missionFileName", "_theGroup", "_NPC", "_missionNumber", "_newTask", "_groupArray", "_missionObjectList", "_startTime", "_win", "_exit", "_location2", "_building"];

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

_location2 = getMarkerPos ("ZX" + str _NPC + "_" + str _missionNumber);
_building = nearestTerrainObjects [_location2, ["BUILDING","HOUSE"], 30, true] select 0;

while {((time < (_startTime + MissionTimeLimit)) and !_exit)} do
{
	sleep 15;
	if (!alive _building) then
	{
		//exit loops
		_exit = true;
		_win = true;
AAA = 1;
		//rebuild buiding
		[_building] spawn {
			//pvs
			private ["_building"];
			
			_building = _this select 0;
			sleep 60;
			_building setDamage 0;
		};
		
		//complete mission as success
		[_newTask,"SUCCEEDED"] call BIS_fnc_taskSetState;
		[_missionFileName,_theGroup,_NPC,_missionNumber,_newTask,_groupArray,_missionObjectList,"SUCCEEDED"] execVM "JobFinished.sqf";
	};
};
if !(_win) then
{
	[_nt,"FAILED"] call BIS_fnc_taskSetState;
AAA = 2;
	[_missionFileName,_theGroup,_NPC,_missionNumber,_newTask,_groupArray,_missionObjectList,"FAILED"] execVM "JobFinished.sqf";
};