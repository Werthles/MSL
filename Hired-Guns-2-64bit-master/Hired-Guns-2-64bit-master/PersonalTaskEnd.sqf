//pvs
private ["_newTrig", "_newTask", "_newTrig2", "_missionFileName", "_theGroup", "_NPC", "_missionNumber", "_groupArray", "_missionObjectList", "_startTime", "_win", "_exit", "_state", "_state2"];

_newTrig = _this select 0;
_newTask = _this select 1;
_newTrig2 = _this select 2;
_missionFileName = _this select 3;
_theGroup = _this select 4;
_NPC = _this select 5;
_missionNumber = _this select 6;
_groupArray = _this select 8;
_missionObjectList = _this select 9;
_startTime = _this select 10;
_win = false;
_exit = false;
while {(time < (_startTime + MissionTimeLimit)) and !_exit} do
{
	sleep 15;
	_state = triggerActivated _newTrig;
	_state2 = triggerActivated _newTrig2;
	if (_state and _state2) then
	{
		_exit = true;
		_win = true;
		[_newTask,"SUCCEEDED"] call BIS_fnc_taskSetState;
	
		PMEnd = ["PM9b0",_theGroup,"Succeeded"];
		publicVariableServer "PMEnd";					
	};
};
if !(_win) then
{
	[_newTask,"FAILED"] call BIS_fnc_taskSetState;
	PMEnd = ["PM9b0",_theGroup,"Failed"];
	publicVariableServer "PMEnd";	
}
else
{//victory video
	//play video
	//[] remoteExec ["Credits",_theGroup];
};