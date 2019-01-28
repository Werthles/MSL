//CurrentMission.sqf
//Runs on player
//Called from player's GUI
//Shows details of the currently playing mission

//no pvs

//close GUI
closeDialog 0;
sleep 0.05;
closeDialog 0;

if (count CurrentMission > 0) then
{
	//display dialog
	createDialog "HG_MissionInProgress";
}
else
{
	[3,nil] call Messages;
};