//EndMission.sqf
//Runs on player
//Called from player GUI
//Sends message to server to quit mission

//pvs
private ["_job"];

//close GUI
closeDialog 0;
sleep 0.05;
closeDialog 0;

if (count CurrentMission > 0) then
{//job
	_job = CurrentMission select 12;
	if (_job find "PM" > -1) then
	{
		PMEnd = [_job,player,"Canceled"];
		publicVariableServer "PMEnd";
	}
	else
	{
		QuitMission = [player,_job];
		publicVariableServer "QuitMission";
	};
	CurrentMission = [];
	missionStartTime = time;
}
else
{//no job
	[player] join grpNull;
};