//loadMission.sqf
//Runs on player
//Called by player when accepting a job
//Starts/joins job or not

//pvs
private ["_NPC", "_num", "_missionName", "_missionNumber", "_OK","_uid"];

closeDialog 0;
sleep 0.05;
closeDialog 0;

//not default for params
_NPC = _this select 0;
_num = _this select 1;
_missionName = (missionNamespace getVariable((MissionsInfo select 0) select 0));

_missionNumber = (MyOptions select _num) select 1;
_OK = 0;
_uid = getPlayerUID player;

if not ((leader group player) == player) then
{//not leader
	_OK = 1;
	[20,nil] call Messages;
}
else
{
	if (count CurrentMission > 0) then
	{//has job already
		_OK = 1;
		[21,nil] call Messages;
	}
	else
	{
		if ((time - missionStartTime) < 60) then
		{
			_OK = 1;
			[58,nil] call Messages;
		}
		else
		{
			if ((time - MissionEndTime) < 60) then
			{
				_OK = 1;
				[59,nil] call Messages;
			};
		};
	};
};

if (_OK == 0) then
{//enter mission
	if (isPlayer _NPC) then
	{//join another player
		[player] join _NPC;
		[player,clientOwner] remoteExec ["ShareTask",_NPC];
	}
	else
	{//if starting a mission from an NPC
		[22,nil] call Messages;
		CurrentMission = MyOptions select _num;
		if (isServer) then
		{
			[_NPC,_missionNumber,player] execVM "LoadTask.sqf";
		}
		else
		{
			LoadTask = [_NPC,_missionNumber,player];
			publicVariableServer "LoadTask";
		};
		missionStartTime = time;
	};
};