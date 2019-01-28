//JobIntros.sqf
//Runs on players
//Called from players or server
//Called from ShareTask.sqf, LoadTask.sqf or LoadPersonalTask.sqf
//Short camera views of newly joined mission

//pvs
private ["_camPos1", "_camTarget1", "_camPos2", "_camTarget2", "_camPos3", "_camTarget3", "_title", "_missionFileName", "_NPC", "_PM", "_NPCNumber", "_camera"];

if (hasInterface) then
{
	_camPos1 = _this select 0;
	_camTarget1 = _this select 1;
	_camPos2 = _this select 2;
	_camTarget2 = _this select 3;
	_camPos3 = _this select 4;
	_camTarget3 = _this select 5;
	_title = _this select 6;
	_missionFileName = _this select 7;
	_NPC = _this select 8; //NPC object
	
	CurrentIntro = [_camPos1,_camTarget1,_camPos2,_camTarget2,_camPos3,_camTarget3,_title,_missionFileName,_NPC];

	0.01 fadeMusic 0;

	_PM = false;
	/*
	switch (_NPC) do
	{
		case NPC0:{playMusic "LeadTrack02_F_EPC";};//The Landlord
		case NPC1:{playMusic "AmbientTrack04_F";};//The Drimean
		case NPC2:{playMusic "BackgroundTrack01_F";};//The Banker
		case NPC3:{playMusic "BackgroundTrack03_F_EPC";};//The Priest
		case NPC4:{playMusic "LeadTrack03_F_EPA";};//The Pirate
		case NPC5:{playMusic "BackgroundTrack04_F_EPC";};//The Oreokastron Guerrilla
		case NPC6:{playMusic "LeadTrack03_F_EPC";};//The CSAT Officer
		case NPC7:{playMusic "LeadTrack02_F_EPC";};//The FIA Officer
		case NPC8:{playMusic "LeadTrack06_F_EPC";};//The FIA Armourer
		case NPC9:{playMusic "BackgroundTrack01_F_EPC";};//The FIA Pilot
		default {playMusic "LeadTrack02_F_Bootcamp"; _PM = true;};
	}; */
	
	if (isPlayer _NPC) then
	{
	    playMusic PMMusic;
	    _PM = true;
	}
	else
	{
	    _NPCNumber = parseNumber ((str _NPC) select [3,1]);
	    playMusic [(NPCMusicArray select _NPCNumber),(NPCMusicStarts select _NPCNumber)];
	};

	0 fadeMusic 0.5;
	
	titlecut [" ","BLACK OUT",1];
	sleep 1;
	enableradio false;
	camUseNVG true;
	
	if (daytime >=5) then { camUseNVG false;};
	[0, 0] call BIS_fnc_cinemaBorder;

	//Camera setup

	_camera = "camera" camCreate (getPos player);
	_camera cameraEffect ["internal", "back"];
	_camera camPrepareTarget _camTarget1;
	_camera camPreparePos _camPos1;
	_camera camPrepareFOV 0.700;
	_camera camCommitPrepared 0;
	cutText [" ","BLACK IN",1];

	sleep 4;

	if not (_PM) then
	{
		//playSound ("\sound\" + _missionFileName + ".ogg");
		playSound (_missionFileName select [3,3]);
	};

	sleep 1;

	titlecut [" ","BLACK OUT",1];

	sleep 1;

	_camera camPrepareTarget _camTarget2;
	_camera camPreparePos _camPos2;
	_camera camPrepareFOV 0.700;
	_camera camCommitPrepared 0;

	cutText [" ","BLACK IN",1];

	sleep 5;
	
	titlecut [" ","BLACK OUT",1];

	sleep 1;

	_camera camPrepareTarget _camTarget3;
	_camera camPreparePos _camPos3;
	_camera camPrepareFOV 0.700;
	_camera camCommitPrepared 0;

	cutText [" ","BLACK IN",1];

	sleep 5;
	
	titlecut [" ","BLACK OUT",1];

	sleep 1;

	enableradio true;
	disableUserInput false;
	_camera cameraEffect ["terminate","back"];
	camdestroy _camera;
	titlecut [" ","BLACK IN",1];
	
	closeDialog 0;
	closeDialog 0;
	
	sleep 1;
	
	[1, 2] call BIS_fnc_cinemaBorder;
	10 fadeMusic 0;
	sleep 15;
	enableSaving [false,false];
	playMusic "";
};