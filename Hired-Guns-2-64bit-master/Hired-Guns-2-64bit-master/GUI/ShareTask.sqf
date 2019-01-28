//ShareTask.sqf
//Runs on player
//Called from another player
//Called if player accepts a mission offer dialog from another player
//Called from GUI\LoadMission.sqf

//pvs
private ["_joiner", "_owner", "_taskID", "_currentTask", "_taskDescription", "_taskDestination", "_taskState", "_missionType", "_missionLevel"];

if (count CurrentMission > 0) then
{
	_joiner = _this select 0;
	_owner = _this select 1;
	_taskID = CurrentMission select 12;
	_currentTask = _taskID call BIS_fnc_taskReal;

	_taskDescription = taskDescription _currentTask;
	_taskDestination = taskDestination _currentTask;
	_taskState = taskState _currentTask;

	[[_taskID,group player,_taskDescription,_taskDestination,_taskState,1],"BIS_fnc_setTask"] remoteExec ["call",2];


	_owner publicVariableClient "missionStartTime";
	_owner publicVariableClient "CurrentMission";

	sleep 1;

	[_taskID,_taskDestination] call BIS_fnc_taskSetDestination;
	//[[_taskID,_taskDestination],"BIS_fnc_taskSetDestination"] remoteExec ["call",group player];

	if (_taskID find "PM" > -1) then
	{
		_missionType = parseNumber(_taskID select [2,1]);
		_missionLevel = parseNumber(_taskID select [4,1]);
		[_missionType,_missionLevel,loot,leader group player] remoteExec ["PMLocalSetup1", _joiner];
	};
	CurrentIntro remoteExec ["JobIntros",_joiner];
};