//initServer.sqf
//Runs on server
//Called by server on mission load
//Sets up all things only required by the server

//init.sqf
//Runs on all machines
//Called on mission loading

titleText ["", "BLACK OUT",0.0001];

//Money List Globals
moneyMoney = [];
moneyNames = [];
moneyUIDS = [];
moneySteamNames = [];
newMoneyMoney = [];
newMoneyUIDS = [];
newMoneyNames = [];
newMoneySteamNames = [];
MoneyListDelay = paramsArray select 11;
ServerBoxes = ["W0","W1","W2","W3","W4","W5","W6","W7","W8","W9","X0","X1","X2","X3","X4","X5","X6","X7","X8","X9","Y0","Y1","Y2","Y3","Y4","Y5","Y6","Y7","Y8","Y9","Z0","Z1","Z2","Z3","Z4","Z5","Z6","Z7","Z8","Z9"];
AddedDifficulty = 0.15;
MarkerUpdateDelay = 60 * (paramsArray select 18);
StartingMoney = 100;

//load database functions
call compile preProcessFile "\inidbi\init.sqf";

//load server PVEHs
execVM "PublicVariableEventHandlers.sqf";

NPC0Crate = "";
NPC1Crate = "";
NPC2Crate = "";
NPC3Crate = "";
NPC4Crate = "";
NPC5Crate = "";
NPC6Crate = "";
NPC7Crate = "";
NPC8Crate = "";
NPC9Crate = "";

////////////////////

//old init
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

/* WHMActivate = paramsArray select 14;
WHMActivate = paramsArray select 15;
WHMActivate = paramsArray select 16;
WHMActivate = paramsArray select 17;
WHMActivate = paramsArray select 18;
WHMActivate = paramsArray select 19; */

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
////////////////////

//populate civilian towns
execVM "SpawnCiv.sqf";

//create sides
SideHQEAST = createCenter EAST;
SideHQWEST = createCenter WEST;


//disable TI
{
	_x disableTIEquipment true;
}foreach allUnits;

//clear MIPs
["MissionsInProgress", "MISSIONS", "Mission0", ""] call iniDB_write;
["MissionsInProgress", "MISSIONS", "Mission1", ""] call iniDB_write;
["MissionsInProgress", "MISSIONS", "Mission2", ""] call iniDB_write;
["MissionsInProgress", "MISSIONS", "Mission3", ""] call iniDB_write;
["MissionsInProgress", "MISSIONS", "Mission4", ""] call iniDB_write;
["MissionsInProgress", "MISSIONS", "Mission5", ""] call iniDB_write;
["MissionsInProgress", "MISSIONS", "Mission6", ""] call iniDB_write;

//load moneylist
execVM "GetMoneyList.sqf";

//taxis
execVM "TaxiSetup.sqf";

descriptionArray = [
	//NPC 0
	[
		(["NPC0b0", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 1
		(["NPC0b1", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 2
		(["NPC0b2", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 3
		(["NPC0b3", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 4
		(["NPC0b4", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 5
		(["NPC0b5", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 6
		(["NPC0b6", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 7
		(["NPC0b7", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 8
		(["NPC0b8", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 9
		(["NPC0b9", "Info", "shortDesc", "STRING"] call iniDB_read)  //mission 10
	],
	//NPC 1
	[
		(["NPC1b0", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 1
		(["NPC1b1", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 2
		(["NPC1b2", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 3
		(["NPC1b3", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 4
		(["NPC1b4", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 5
		(["NPC1b5", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 6
		(["NPC1b6", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 7
		(["NPC1b7", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 8
		(["NPC1b8", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 9
		(["NPC1b9", "Info", "shortDesc", "STRING"] call iniDB_read)  //mission 10
	],
	//NPC 2
	[
		(["NPC2b0", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 1
		(["NPC2b1", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 2
		(["NPC2b2", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 3
		(["NPC2b3", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 4
		(["NPC2b4", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 5
		(["NPC2b5", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 6
		(["NPC2b6", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 7
		(["NPC2b7", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 8
		(["NPC2b8", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 9
		(["NPC2b9", "Info", "shortDesc", "STRING"] call iniDB_read)  //mission 10
	],
	//NPC 3
	[
		(["NPC3b0", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 1
		(["NPC3b1", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 2
		(["NPC3b2", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 3
		(["NPC3b3", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 4
		(["NPC3b4", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 5
		(["NPC3b5", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 6
		(["NPC3b6", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 7
		(["NPC3b7", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 8
		(["NPC3b8", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 9
		(["NPC3b9", "Info", "shortDesc", "STRING"] call iniDB_read)  //mission 10
	],
	//NPC 4
	[
		(["NPC4b0", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 1
		(["NPC4b1", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 2
		(["NPC4b2", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 3
		(["NPC4b3", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 4
		(["NPC4b4", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 5
		(["NPC4b5", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 6
		(["NPC4b6", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 7
		(["NPC4b7", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 8
		(["NPC4b8", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 9
		(["NPC4b9", "Info", "shortDesc", "STRING"] call iniDB_read)  //mission 10
	],
	//NPC 5
	[
		(["NPC5b0", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 1
		(["NPC5b1", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 2
		(["NPC5b2", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 3
		(["NPC5b3", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 4
		(["NPC5b4", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 5
		(["NPC5b5", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 6
		(["NPC5b6", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 7
		(["NPC5b7", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 8
		(["NPC5b8", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 9
		(["NPC5b9", "Info", "shortDesc", "STRING"] call iniDB_read)  //mission 10
	],
	//NPC 6
	[
		(["NPC6b0", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 1
		(["NPC6b1", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 2
		(["NPC6b2", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 3
		(["NPC6b3", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 4
		(["NPC6b4", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 5
		(["NPC6b5", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 6
		(["NPC6b6", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 7
		(["NPC6b7", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 8
		(["NPC6b8", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 9
		(["NPC6b9", "Info", "shortDesc", "STRING"] call iniDB_read)  //mission 10
	],
	//NPC 7
	[
		(["NPC7b0", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 1
		(["NPC7b1", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 2
		(["NPC7b2", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 3
		(["NPC7b3", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 4
		(["NPC7b4", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 5
		(["NPC7b5", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 6
		(["NPC7b6", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 7
		(["NPC7b7", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 8
		(["NPC7b8", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 9
		(["NPC7b9", "Info", "shortDesc", "STRING"] call iniDB_read)  //mission 10
	],
	//NPC 8
	[
		(["NPC8b0", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 1
		(["NPC8b1", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 2
		(["NPC8b2", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 3
		(["NPC8b3", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 4
		(["NPC8b4", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 5
		(["NPC8b5", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 6
		(["NPC8b6", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 7
		(["NPC8b7", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 8
		(["NPC8b8", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 9
		(["NPC8b9", "Info", "shortDesc", "STRING"] call iniDB_read)  //mission 10
	],
	//NPC 9
	[
		(["NPC9b0", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 1
		(["NPC9b1", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 2
		(["NPC9b2", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 3
		(["NPC9b3", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 4
		(["NPC9b4", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 5
		(["NPC9b5", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 6
		(["NPC9b6", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 7
		(["NPC9b7", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 8
		(["NPC9b8", "Info", "shortDesc", "STRING"] call iniDB_read), //mission 9
		(["NPC9b9", "Info", "shortDesc", "STRING"] call iniDB_read)  //mission 10
	]
];
publicVariable "descriptionArray";

//function setup
DismissCiv = compile preprocessFile "DismissCiv.sqf";
Sum = compile preprocessFile "Sum.sqf";

//WHM
execVM "WHMStartUp.sqf";

execVM "PlayerMarkers.sqf";

NPC0 KbAddTopic ["SpeakToNPC0","SpeakToNPC0.bikb",""];
NPC1 KbAddTopic ["SpeakToNPC1","SpeakToNPC1.bikb",""];
NPC2 KbAddTopic ["SpeakToNPC2","SpeakToNPC2.bikb",""];
NPC3 KbAddTopic ["SpeakToNPC3","SpeakToNPC3.bikb",""];
NPC4 KbAddTopic ["SpeakToNPC4","SpeakToNPC4.bikb",""];
NPC5 KbAddTopic ["SpeakToNPC5","SpeakToNPC5.bikb",""];
NPC6 KbAddTopic ["SpeakToNPC6","SpeakToNPC6.bikb",""];
NPC7 KbAddTopic ["SpeakToNPC7","SpeakToNPC7.bikb",""];
NPC8 KbAddTopic ["SpeakToNPC8","SpeakToNPC8.bikb",""];
NPC9 KbAddTopic ["SpeakToNPC9","SpeakToNPC9.bikb",""];