//initPlayerLocal.sqf
//Runs on player
//Called when a player JIPs or on mission start
//Sets up all things only required by players

//pvs
private ["_tasks"];

titleText ["", "BLACK OUT",0.0001];

//loop menu music
addMusicEventHandler ["MusicStop", {playMusic HGMusic}];

//WHM
if not (isServer) then
{
	execVM "WHMStartUp.sqf";
};

//heal on bed
Bed addAction ["Patch Yourself Up","BedHeal.sqf",[],10];

missionStartTime = -60;

///////////////////////////
//old init
if not (isServer) then
{
	//cutText ["", "BLACK OUT", 0.001];

	DeepSum = compile preprocessFile "DeepSum.sqf";

	WHMActivate = paramsArray select 0;
	MissionTimeLimit = paramsArray select 1;
	maxCivTownCount = paramsArray select 2;
	BlueType1 = paramsArray select 3;
	BlueType2 = paramsArray select 4;
	BlueType3 = paramsArray select 15;
	RedType1 = paramsArray select 5;
	RedType2 = paramsArray select 6;
	RedType3 = paramsArray select 14;
	GreenType1 = paramsArray select 7;
	GreenType2 = paramsArray select 8;
	GreenType3 = paramsArray select 16;
	CivType1 = paramsArray select 9;
	CivType2 = paramsArray select 10;
	MoneyListDelay = paramsArray select 11;
	KickTimeLimit = paramsArray select 12;
	TaxisOn = paramsArray select 13;
	HGDifficulty = paramsArray select 17;

	//Weather
	execVM "randomWeather.sqf";

	//Character Clothing
	execVM "NPCSetup.sqf";

	//Set Up Variables For Personal Missions
	execVM "PMSetup.sqf";

	//Mark As Finished On Steam
	markAsFinishedOnSteam;

	//Mission Event Handlers
	execVM "MissionEventHandlers.sqf";
};

SaveGearTime = -60;
WHMActivate = paramsArray select 0;
MissionTimeLimit = paramsArray select 1;
maxCivTownCount = paramsArray select 2;
BlueType1 = paramsArray select 3;
BlueType2 = paramsArray select 4;
BlueType3 = paramsArray select 15;
RedType1 = paramsArray select 5;
RedType2 = paramsArray select 6;
RedType3 = paramsArray select 14;
GreenType1 = paramsArray select 7;
GreenType2 = paramsArray select 8;
GreenType3 = paramsArray select 16;
CivType1 = paramsArray select 9;
CivType2 = paramsArray select 10;
MoneyListDelay = paramsArray select 11;
KickTimeLimit = paramsArray select 12;
TaxisOn = paramsArray select 13;
HGDifficulty = paramsArray select 17;

CloseGUI = compile preprocessFile "GUI\CloseGUI.sqf";
GetPlayerMission = compile preprocessFile "GUI\GetPlayerMission.sqf";
OfferMission = compile preprocessFile "GUI\OfferMission.sqf";
PMLocalSetup1 = compile preprocessFile "PMLocalSetup1.sqf";
PMLocalSetup2 = compile preprocessFile "PMLocalSetup2.sqf";
PMRewardSplit = compile preprocessFile "PMRewardSplit.sqf";
MissionGear = compile preprocessFile "MissionGear.sqf";
ReceiveCurrentMission = compile preprocessFile "ReceiveCurrentMission.sqf";
Messages = compile preprocessFile "Messages.sqf";
JobIntros = compile preprocessFile "JobIntros.sqf";
ShareTask = compile preprocessFile "GUI\ShareTask.sqf";
AddBreifings = compile preprocessFile "AddBreifings.sqf";
Credits = compile preprocessFile "Credits.sqf";
Donate = compile preprocessFile "Donate.sqf";

MissionEndTime = -60;
HGRequests = true;
GUITargetObject = objNull;
QuitMission = [];
CurrentMission = [];
MissionsInfo = [[],[]];
MyOptions = [[],[]];
LoadMoney = player;
PauseMusicTime = 0;
HGMusic = "LeadTrack02_F_EXP";
PMMusic = "LeadTrack02_F_EXP";
NPCMusicArray = [
    "BackgroundTrack04_F_EPC",
    "BackgroundTrack01_F_EPC",
    "LeadTrack03_F_EXP",
    "LeadTrack01a_F_EXP",
    "LeadTrack01c_F_EXP",
    "LeadTrack02_F_EPC",
    "AmbientTrack02d_F_EXP",
    "BackgroundTrack02_F_EPC",
    "LeadTrack04_F_EXP",
    "LeadTrack01b_F_EXP"
];
NPCMusicStarts = [9,0,8,0,1,0,0,56,22,30];

//AmbientTrack01_F_EXP
//AmbientTrack01a_F_EXP
//AmbientTrack01b_F_EXP // 14
//AmbientTrack02_F_EXP
//AmbientTrack02a_F_EXP
//AmbientTrack02b_F_EXP
//AmbientTrack02c_F_EXP
//AmbientTrack02d_F_EXP //market 0
//LeadTrack01_F_EXP
//LeadTrack01a_F_EXP //driver 0
//LeadTrack01b_F_EXP //pilot 30
//LeadTrack01c_F_EXP //slave 1
//LeadTrack02_F_EXP //pm
//LeadTrack03_F_EXP //invest 8
//LeadTrack04_F_EXP //captain 22
//BackgroundTrack01_F_EPC 0 cult
//mine LeadTrack02_F_EPC 0
//old BackgroundTrack04_F_EPC 9
//rich BackgroundTrack02_F_EPC 56
//BackgroundTrack03_F_EPC 74
respawn0 = getMarkerPos "r0";
respawn1 = getMarkerPos "r1";
respawn2 = getMarkerPos "r2";
respawn3 = getMarkerPos "r3";
respawn4 = getMarkerPos "r4";
respawn5 = getMarkerPos "r5";
respawn6 = getMarkerPos "r6";
respawn7 = getMarkerPos "r7";
respawn8 = getMarkerPos "r8";
respawn9 = getMarkerPos "r9";

KickTimeLimit = (paramsArray select 12) * 60;

mountainPeak = [10264.6,12142,500];

StartLocation = [6891.97,7393.06,0];
StartDirection = 350;

StartingMoney = 100;

GarageLocations = [
	getMarkerPos "Garage1",
	getMarkerPos "Garage2",
	getMarkerPos "Garage3",
	getMarkerPos "Garage4",
	getMarkerPos "Garage5",
	getMarkerPos "Garage6",
	getMarkerPos "Garage7",
	getMarkerPos "Garage8"
];
GarageSize = [15, 15, 0, false];

player setPos StartLocation;
player setDir StartDirection;

["Mediterranean",0,true] call bis_fnc_setppeffecttemplate;

//reset unit group and tasks
[player] join grpNull;
_tasks = player call BIS_fnc_tasksUnit;

{
	if ((_x find "PM" > -1) or (_x find "NPC" > -1)) then
	{
		[_x,player] call BIS_fnc_deleteTask;
	};
}forEach _tasks;
if ((not (_tasks find "TAXI" > -1)) and TaxisOn == 1) then
{
	execVM "TaxiSetup.sqf";
};

removeAllActions player;

//stops Arma3 saving when exiting mission
enableSaving [false,false];

//No unit switching
enableTeamSwitch false;

//add safe spawn zone
execVM "safezone.sqf";

//GUI
player addAction ["<t color='#FF0000'>Options (Shortcut ""U"")</t>",{createdialog "HG_GUIMain";},[],-9999,false,true,"buldTerrainRaise10cm"];

execVM "GearSetup.sqf";

execVM "GarageSetup.sqf";

execVM "DiarySetup.sqf";

execVM "PlayerPrep.sqf";