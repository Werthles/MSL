//HirePlayer.sqf
//Runs on player
//Called if interacting with player
//Get/offer task

//pvs
private ["_hasTask", "_targetHasTask","_id","_cash"];

if ((leader group player) == player) then
{
	SendCurrent = [];
	[clientOwner] remoteExec ["GetPlayerMission",GUITargetObject];
	
	sleep 5;
	
	_hasTask = (count CurrentMission) > 0;
	_targetHasTask = (count SendCurrent) > 0;

	//if player has a current task
	if (_hasTask) then
	{
		//if target has a task
		if (_targetHasTask) then
		{
			//if target is in the same group
			if (group GUITargetObject == group player) then
			{
				[10,GUITarget] call Messages;
			}
			else
			{
				[11,GUITarget] call Messages;
			};
		}
		else
		{
		    _id = moneyUIDS find (getPlayerUID player);
		    
		    if (((CurrentMission select 12) find "NPC")==-1) then
		    {
		        _cash = moneyMoney select _id;
    		    if (_cash>0) then
    		    {
    			    //offer task
    			    [CurrentMission,player] remoteExec ["OfferMission",GUITargetObject];
    			}
    			else
    			{
    			    //not enough money
    				[67,_cash] call Messages;
    			};
    		}
    		else
    		{
    	        //offer task
    		    [CurrentMission,player] remoteExec ["OfferMission",GUITargetObject];
    		};
		};
	}
	else //player has no task
	{
		//if target has a task
		if (_targetHasTask) then
		{
			//request task info
			[12,name player] remoteExec ["Messages",[leader group GUITargetObject, GUITargetObject]];
			[13,name (leader group GUITargetObject)] call Messages;
		}
		else
		{
			//neither has a task
			//Offer squad membership
			[player] remoteExec ["JoinTeam",GUITargetObject];
		};
	};
}
else
{
	//not squad leader
	[15,nil] call Messages;
};