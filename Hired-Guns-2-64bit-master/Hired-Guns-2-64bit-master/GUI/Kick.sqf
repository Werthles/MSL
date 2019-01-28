//Kick.sqf
//Runs on player
//Called from player GUI
//Kicks player or civ from team

//pvs
private ["_targetName","_target"];

//var init
_target = GUITargetObject;
_targetName = GUITarget;

//closes GUI
closeDialog 0;
sleep 0.01;
closeDialog 0;

//decide action to be taken
if (player == leader group player) then
{//only leader can kick
	if (count CurrentMission > 0) then
	{//if has a job
		if (group _target == group player) then
		{//can only kick if is a team member
			if (time < (missionStartTime + KickTimeLimit)) then
			{//can only kick if before time limit
				if (isPlayer _target) then
				{
			    	[_target] joinSilent grpNull;
					[CurrentMission select 12,_target] call BIS_fnc_deleteTask;
					[] remoteExec ["ReceiveCurrentMission",_target];
					[CurrentMission select 12,_target] remoteExec ["BIS_fnc_deleteTask",_target];
				}
				else
				{
					if (isServer) then
					{
						[_target] execVM "DismissCiv.sqf";
					}
					else
					{
						[_target] remoteExec ["DismissCiv",2];
					};
				};
			}
			else
			{
				//out of time to kick
				[16,_targetName] call Messages;
			};
		}
		else
		{//_targetName + " is not in your squad!"
			[17,_targetName] call Messages;
		};
	}
	else
	{
		//"You are not currently on a job."
		if (isPlayer _target) then
		{
			[_target] joinSilent grpNull;
		}
		else
		{
			if (isServer) then
			{
				[_target] execVM "DismissCiv.sqf";
			}
			else
			{
				[_target] remoteExec ["DismissCiv",2];
			};
		};
	};
}
else
{//"Only squad leaders can kick squadmates."
	[19,nil] call Messages;
};