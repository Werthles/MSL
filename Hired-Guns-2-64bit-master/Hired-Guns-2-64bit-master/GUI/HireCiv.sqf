//HireCiv.sqf
//Runs on player
//Called from player interaction with Civ

//pvs
private ["_hasTask", "_targetHasTask", "_type", "_rank"];

if ((leader group player) == player) then
{
	_hasTask = (count CurrentMission) > 0;
	_targetHasTask = ((leader group GUITargetObject) != GUITargetObject);
	
	//if player has a current task
	if (_hasTask) then
	{
		//if target has a task
		if (_targetHasTask) then
		{
			//if target is in the same group
			if (group GUITargetObject == group player) then
			{
				[4,GUITarget] call Messages;
			}
			else
			{
				[5,GUITarget] call Messages;
			};
		}
		else 
		{
			_type = GUITargetObject getVariable "Type";
			_rank = GUITargetObject getVariable "Rank";
			[_type,_rank] execVM "GUI\CreateCiv.sqf";
		};
	}
	else //player has no task
	{
		//if target has a task
		if (_targetHasTask) then
		{
			[6,name player] remoteExec ["Messages",leader group GUITargetObject];
			[7,name (leader group GUITargetObject)] call Messages;
		}
		else
		{
			//neither has a task
			//[GUITargetObject] join (group player);
			_type = GUITargetObject getVariable "Type";
			_rank = GUITargetObject getVariable "Rank";
			[_type,_rank] execVM "GUI\CreateCiv.sqf";
		};
	};
}
else
{
	[9,nil] call Messages;
};