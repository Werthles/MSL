//LoadTaskEnd.sqf
//terminate everything
//[_theGroup,_missionFileName,_newTask,_NPC,_missionNumber,_groupArray,_missionObjectList,_title,_spawn2,_spawn3,_spawn4]

//private[];

_theGroup = _this select 0;
_missionFileName = _this select 1;
_newTask = _this select 2;
_NPC = _this select 3;
_missionNumber = _this select 4;
_groupArray = _this select 5;
_missionObjectList = _this select 6;
_title = _this select 7;
_spawn2 = _this select 8;
_spawn3 = _this select 9;
_spawn4 = _this select 10;

_allDone = 0;
_check1 = 0;
while {_check1<4} do
{
	_allDone = 0;
	sleep 15;
	if !(isPlayer (leader _theGroup)) then
	{
		_aiLeader = true;
		{
			if ((isPlayer _x) and _aiLeader) then
			{
				_theGroup setLeader _x;
				_aiLeader = false;
			};
		}forEach units _theGroup;
	};
	
	if (({isPlayer _x} count units _theGroup) == 0) then
	{
		_allDone = 2;
		_check1 = _check1 + 1;
AAA = 12;
	}
	else
	{
	    _check = 0;
	};
	
	//check if forcibly cancelled
	_Mission0 = ["MissionsInProgress", "MISSIONS", "Mission0", "STRING"] call iniDB_read;
	_Mission1 = ["MissionsInProgress", "MISSIONS", "Mission1", "STRING"] call iniDB_read;
	_Mission2 = ["MissionsInProgress", "MISSIONS", "Mission2", "STRING"] call iniDB_read;
	_Mission3 = ["MissionsInProgress", "MISSIONS", "Mission3", "STRING"] call iniDB_read;
	_Mission4 = ["MissionsInProgress", "MISSIONS", "Mission4", "STRING"] call iniDB_read;
	_Mission5 = ["MissionsInProgress", "MISSIONS", "Mission5", "STRING"] call iniDB_read;
	_Mission6 = ["MissionsInProgress", "MISSIONS", "Mission6", "STRING"] call iniDB_read;
	
	//forced ending by deleting MIP ID
	if not (_Mission0 == _missionFileName or _Mission1 == _missionFileName or _Mission2 == _missionFileName or _Mission3 == _missionFileName or _Mission4 == _missionFileName or _Mission5 == _missionFileName or _Mission6 == _missionFileName) then
	{
		_allDone = 2;
		_check1 = 100;
AAA = 9;
	};
	
	_taskState = [_missionFileName] call BIS_fnc_taskState;
	if (_taskState == "Succeeded" or _taskState == "Failed") then
	{
		_allDone == 1;
		_check1 = 100;
AAA = 10;
	};
};

if (_allDone == 2) then
{
	[_newTask,"Canceled"] call BIS_fnc_taskSetState;
AAAAA = 8;
	[_missionFileName,_theGroup,_NPC,_missionNumber,_newTask,_groupArray,_missionObjectList,"Canceled"] execVM "JobFinished.sqf";
};

deleteMarker _title;
terminate _spawn2;
terminate _spawn3;
terminate _spawn4;