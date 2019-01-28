//Intel.sqf
//Runs on player
//Called by player's GUI
//Creates Intel dialog on target

//close GUI
closeDialog 0;
sleep 0.05;
closeDialog 0;

Intel = [];

//get info
if (isNull GUITargetObject) then
{
	GUITargetObject = player;
};
GetIntel = [player,GUITargetObject];
publicVariableServer "GetIntel";

//wait for response
waitUntil{(count Intel) > 0};

//create dialog
createDialog "HG_Intel";