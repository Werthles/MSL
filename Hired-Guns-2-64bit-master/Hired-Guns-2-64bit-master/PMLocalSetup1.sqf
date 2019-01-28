//PMLocalSetup1.sqf
//Runs on players
//Called from server or group leader
//Called from LoadPersonalTask.sqf or ShareTask.sqf
//Sets up addActions for first part of PM

//pvs
private ["_missionType", "_missionLevel", "_starter"];

_missionType = _this select 0;
_missionLevel = _this select 1;
loot = _this select 2;
_starter = _this select 3;

//addActions for player and team
if (_missionType < 9) then
{
	if (str player == str _starter) then
	{
		PMLootAction1 = loot addAction["Loot - Pick Up","PMAddAction1.sqf",[_missionType,_missionLevel,_starter],200];

		//save mission start time
		missionStartTime = time;
		
		//tell leader mission has loaded
		[41,[_missionType,_missionLevel]] call Messages;
	}
	else
	{
		PMLootAction1 = loot addAction["Loot - Job Leader Must Collect","",200];
	};
};