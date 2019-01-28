//PMAddAction2.sqf
//Runs on player
//Called from player
//Called from PM addAction on Loot

//pvs
private ["_object", "_caller", "_args", "_missionType", "_missionLevel", "_starter", "_theGroup", "_boxLetter", "_box","_ID"];

//var init
_object = _this select 0;
_caller = _this select 1;
_ID = _this select 2;
_args = _this select 3;
_missionType = _args select 0;
_missionLevel = _args select 1;
_starter = _args select 2;
_theGroup = group player;

//if boxed loot
if ((_object != _caller) and (_missionType < 6)) then
{
	if (str _starter == str player) then
	{//leader taking loot from team or their own corpse
		_object removeAction _ID;
		PMLootAction2 = _caller addAction ["Loot - Distribute","PMAddAction2.sqf",[_missionType,_missionLevel,_starter],200];
		[36,nil] call Messages;
	}
	else
	{
		if (alive _object) then
		{//leader is carrying loot
			[37,nil] call Messages;
		}
		else
		{//protect for leader
			[38,nil] call Messages;
		};
	};
}
else //if vehicle loot
{
	//if leader
	if (str _starter == str _caller) then
	{
		//Get the local box
		_boxLetter = "";
		switch (_missionLevel) do
		{
			case 0: {_boxLetter = "X";};
			case 1: {_boxLetter = "Y";};
			case 2: {_boxLetter = "Z";};
		};
		_box = missionNamespace getVariable (_boxLetter + str _missionType);
	
		//success
		if ((_caller distance _box) < 15) then
		{
			[_missionType,_missionLevel,_box,_theGroup,_starter,clientOwner] remoteExec ["PMRewardSplit",units _theGroup];
			_object removeAction _ID;
			sleep 10;
			PMEnd = [format["PM%1b%2",_missionType,_missionLevel],_theGroup,"Succeeded"];
			publicVariableServer "PMEnd";
		}
		else
		{//too far
			[39,nil] call Messages;
		};
	}
	else
	{
		[40,nil] call Messages;
	};
};