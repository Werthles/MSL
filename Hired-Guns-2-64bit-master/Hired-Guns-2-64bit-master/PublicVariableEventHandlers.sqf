//PublicVariableEventHandlers.sqf
//Runs on server
//Called from server
//Called from initServer.sqf
//Sets up all events for server to process

//send total cash
"LoadMoney" addPublicVariableEventHandler{
    //pvs
	private ["_PVEHName", "_caller", "_owner","_uid"];
	
	_PVEHName = _this select 0;
	_caller = _this select 1;
	_uid = getPlayerUID _caller;
	_owner = owner _caller;
	Cash = [_uid, "MONEY", "Money", "SCALAR"] call iniDB_read;
	_owner publicVariableClient "Cash";
};

//save money
"SaveMoney" addPublicVariableEventHandler{
    //pvs
    private ["_args", "_caller", "_cash", "_owner", "_ret","_uid"];
    
	_args = _this select 1;
	_caller = _args select 0;
	_cash = _args select 1;
	_uid = getPlayerUID _caller;
	_owner = owner _caller;
	_ret = [_uid, "MONEY", "Money", _cash] call iniDB_write;
	
	//send success message
	[48,nil] remoteExec ["Messages",_caller];
};

//send total cash
"LoadTask" addPublicVariableEventHandler{
	//LoadTask = [_NPC,_missionNumber,player];
	//pvs
	private ["_args", "_NPC", "_missionNumber", "_caller"];
	
	_args = _this select 1;
	_NPC = _args select 0;
	_missionNumber = _args select 1;
	_caller = _args select 2;
	[_NPC,_missionNumber,_caller] execVM "LoadTask.sqf";
};

//send progess of all npcs
"SendProgress" addPublicVariableEventHandler
{
    //pvs
	private ["_PVEHName", "_args", "_player", "_NPC", "_NPCName", "_callerID", "_progress", "_p0", "_p1", "_p2", "_p3", "_p4", "_p5", "_p6", "_p7", "_p8", "_p9", "_Progress", "_firstUncompleted", "_speechName2", "_lastCompleted", "_speechName1","_uid","_speakToString"];

	_PVEHName = _this select 0;
	_args = _this select 1;
	_player = _args select 0;
	_NPC = _args select 1;
	_NPCName = str _NPC;
	_callerID = owner _player;

	_uid = getPlayerUID _player;
	_progress = nil;

	if (_player==_NPC) then
	{//if all data requested
		_p0 = [_uid, "QUESTDATA", "NPC0", "ARRAY"] call iniDB_read;
		_p1 = [_uid, "QUESTDATA", "NPC1", "ARRAY"] call iniDB_read;
		_p2 = [_uid, "QUESTDATA", "NPC2", "ARRAY"] call iniDB_read;
		_p3 = [_uid, "QUESTDATA", "NPC3", "ARRAY"] call iniDB_read;
		_p4 = [_uid, "QUESTDATA", "NPC4", "ARRAY"] call iniDB_read;
		_p5 = [_uid, "QUESTDATA", "NPC5", "ARRAY"] call iniDB_read;
		_p6 = [_uid, "QUESTDATA", "NPC6", "ARRAY"] call iniDB_read;
		_p7 = [_uid, "QUESTDATA", "NPC7", "ARRAY"] call iniDB_read;
		_p8 = [_uid, "QUESTDATA", "NPC8", "ARRAY"] call iniDB_read;
		_p9 = [_uid, "QUESTDATA", "NPC9", "ARRAY"] call iniDB_read;
		_Progress = [_p0,_p1,_p2,_p3,_p4,_p5,_p6,_p7,_p8,_p9];
		
		Progress = _progress;
		_callerID PublicVariableClient "Progress";
	}
	else
	{
		//if specific NPC requested
		_Progress = [_uid, "QUESTDATA", _NPCName, "ARRAY"] call iniDB_read;
			
		//_player KbAddTopic ["SpeakTo" + str _NPC,"SpeakTo" + str _NPC + ".bikb",""];		//Add the topics, refer back to the file above
		//_NPC KbAddTopic ["SpeakTo" + str _NPC,"SpeakTo" + str _NPC + ".bikb",""];
		
		_speakToString = ("SpeakTo" + (str _NPC));
		
		//commend about next mission
		_firstUncompleted = (_Progress find 0);
		if (_firstUncompleted == -1) then
		{
		    _firstUncompleted = 10;
		};
		_speechName2 = format["offer%1b%2",_NPC,_firstUncompleted];

		//most advanced completed mission thanks
		reverse _Progress;
		_lastCompleted = 10 - (_Progress find 1);
		if (_lastCompleted == 11) then
		{
		    _lastCompleted = 0;
		};
		_speechName1 = format["greet%1b%2",_NPC,_lastCompleted];
		reverse _Progress;
		
		Progress = _progress;
		_callerID PublicVariableClient "Progress";

		//comment about previous mission
		_NPC kbTell [_player, _speakToString, _speechName1];
		
		//pause
		_NPC kbTell [_player, _speakToString, "pause"];
		
		//comment about next mission
		_NPC kbTell [_player, _speakToString, _speechName2];
		
		//hint (_speechName1 + _speechName2 + str _NPC + str _player);
	
		//remove link to convos
		/* 
		[_player,_NPC,_speakToString,_speechName2] spawn {
			//pvs
			private ["_player", "_NPC","_speakToString","_speechName2"];
			
			_player = _this select 0;
			_NPC = _this select 1;
			_speakToString = _this select 2;
			_speechName2 = _this select 3;
			sleep 10;
			_player kbRemoveTopic ("SpeakTo" + str _NPC);
			_NPC kbRemoveTopic ("SpeakTo" + str _NPC);
			
			waitUntil {_NPC kbWasSaid [_player, _speakToString, _speechName2, 3]};
			
			_player kbRemoveTopic _speakToString;
			_NPC kbRemoveTopic _speakToString;
		}; */
	};
};

"SendMissions" addPublicVariableEventHandler{
    //pvs
	private ["_args", "_caller", "_NPC", "_owner", "_NPCName", "_p0", "_mission1", "_mission2", "_firstUncompleted", "_missionFile", "_title", "_number", "_difficulty", "_type", "_shortDesc", "_leaderCash", "_squadCash", "_squadSize", "_location", "_targetType", "_targetStrength", "_secondUncompleted", "_title2", "_number2", "_difficulty2", "_type2", "_shortDesc2", "_leaderCash2", "_squadCash2", "_squadSize2", "_location2", "_target2", "_targetType2", "_targetStrength2","_uid","_target"];
	
	_args = _this select 1;
	//SendMissions = [player,NPC];
	_caller = _args select 0;
	_NPC = _args select 1;
	_owner = owner _caller;
	_uid = getPlayerUID _caller;

	//get NPC quest info
	_NPCName = str _NPC;
	_p0 = [_uid, "QUESTDATA", _NPCName, "ARRAY"] call iniDB_read;
	
	
	_mission1 = [];
	_mission2 = [];
	
	//available mission decider
	_firstUncompleted = _p0 find 0;
	if (_firstUncompleted > -1) then
	{
		//_missionFile = _NPC + "b" + _firstUncompleted;
		_missionFile = format["%1b%2",_NPCName,_firstUncompleted];
		
		//Mission 1 info
		_title = [_missionFile, "Info", "Title", "STRING"] call iniDB_read;
		_number = [_missionFile, "Info", "Number", "SCALAR"] call iniDB_read;
		_difficulty = [_missionFile, "Info", "Difficulty", "STRING"] call iniDB_read;
		_type = [_missionFile, "Info", "Type", "STRING"] call iniDB_read;
		_shortDesc = [_missionFile, "Info", "ShortDesc", "STRING"] call iniDB_read;
		_leaderCash = [_missionFile, "Info", "LeaderCash", "SCALAR"] call iniDB_read;
		_squadCash = [_missionFile, "Info", "SquadCash", "SCALAR"] call iniDB_read;
		_squadSize = [_missionFile, "Info", "SquadSize", "SCALAR"] call iniDB_read;
		_location = [_missionFile, "Info", "Location", "ARRAY"] call iniDB_read;
		_target = [_missionFile, "Info", "Target", "STRING"] call iniDB_read;
		_targetType = [_missionFile, "Info", "TargetType", "STRING"] call iniDB_read;
		_targetStrength = [_missionFile, "Info", "TargetStrength", "STRING"] call iniDB_read;
		
		_number = _firstUncompleted + 1;
		_leaderCash = round((1.2^(_firstUncompleted + 1)) * 100);
		_squadCash = round((1.2^_firstUncompleted) * 100);
		_squadSize = (8 max (_number+6));
		_location = getMarkerPos ("ZX" + _NPCName + "_" + str _firstUncompleted);
		
		_mission1 = [_title,_number,_difficulty,_type,_shortDesc,_leaderCash,_squadCash,_squadSize,_location,_target,_targetType,_targetStrength,_missionFile];

		_p0 deleteAt _firstUncompleted;
		_secondUncompleted = (_p0 find 0);
		
		if (_secondUncompleted > -1) then
		{
			_secondUncompleted = _secondUncompleted +1;
			
			//_missionFile = _NPC + "b" + _firstUncompleted;
			_missionFile = format["%1b%2",_NPC,_secondUncompleted];

			//Mission 2 info
			_title2 = [_missionFile, "Info", "Title", "STRING"] call iniDB_read;
			//_number2 = [_missionFile, "Info", "Number", "SCALAR"] call iniDB_read;
			_difficulty2 = [_missionFile, "Info", "Difficulty", "STRING"] call iniDB_read;
			_type2 = [_missionFile, "Info", "Type", "STRING"] call iniDB_read;
			_shortDesc2 = [_missionFile, "Info", "ShortDesc", "STRING"] call iniDB_read;
			//_leaderCash2 = [_missionFile, "Info", "LeaderCash", "SCALAR"] call iniDB_read;
			//_squadCash2 = [_missionFile, "Info", "SquadCash", "SCALAR"] call iniDB_read;
			//_squadSize2 = [_missionFile, "Info", "SquadSize", "SCALAR"] call iniDB_read;
			//_location2 = [_missionFile, "Info", "Location", "ARRAY"] call iniDB_read;
			_target2 = [_missionFile, "Info", "Target", "STRING"] call iniDB_read;
			_targetType2 = [_missionFile, "Info", "TargetType", "STRING"] call iniDB_read;
			_targetStrength2 = [_missionFile, "Info", "TargetStrength", "STRING"] call iniDB_read;
		
			_number2 = _secondUncompleted + 1;
			_leaderCash2 = round((1.2^(_secondUncompleted + 1)) * 100);
			_squadCash2 = round((1.2^_secondUncompleted) * 100);
			_squadSize2 = (8 max (_number2+6));
			_location2 = getMarkerPos ("ZX" + _NPCName + "_" + str _secondUncompleted);

			_mission2 = [_title2,_number2,_difficulty2,_type2,_shortDesc2,_leaderCash2,_squadCash2,_squadSize2,_location2,_target2,_targetType2,_targetStrength2,_missionFile];
		};
	};
	
	//send mission info
	MissionsInfo = [_mission1,_mission2];
	_owner publicVariableClient "MissionsInfo";
};


"GarageStore" addPublicVariableEventHandler{
	//GarageStore =[_caller,_uid,_garage,_car,_weaponsItemsCargo,_itemCargo,_magazineCargo,_backpackCargo];	
	private ["_aPVEHName", "_args", "_caller", "_garage", "_car", "_weaponsItemsCargo", "_itemCargo", "_magazineCargo", "_backpackCargo", "_colour", "_ret", "_owner","_uid"];
	_aPVEHName = _this select 0;
	_args = _this select 1;
	_caller = _args select 0;
	_uid = _args select 1;
	_garage = _args select 2;
	_car = _args select 3;
	_weaponsItemsCargo = _args select 4;
	_itemCargo = _args select 5;
	_magazineCargo = _args select 6;
	_backpackCargo = _args select 7;
	_colour = _args select 8;
	
	_ret = [_uid, _garage, "car", _car] call iniDB_write;
	_ret = [_uid, _garage, "weaponsItemsCargo", _weaponsItemsCargo] call iniDB_write;
	_ret = [_uid, _garage, "itemCargo", _itemCargo] call iniDB_write;
	_ret = [_uid, _garage, "magazineCargo", _magazineCargo] call iniDB_write;
	_ret = [_uid, _garage, "backpackCargo", _backpackCargo] call iniDB_write;
	_ret = [_uid, _garage, "colour", _colour] call iniDB_write;
	
	//send success message
	[49,nil] remoteExec ["Messages",_caller];
	
};

"GarageAccess" addPublicVariableEventHandler{
	//GarageAccess = [_caller,_uid,_garage];
	//pvs
	private ["_aPVEHName", "_args", "_caller", "_garage", "_car", "_owner", "_weaponsItemsCargo", "_itemCargo", "_magazineCargo", "_backpackCargo", "_colour", "_ret", "_myCar","_uid"];

	_aPVEHName = _this select 0;
	_args = _this select 1;
	_caller = _args select 0;
	_uid = _args select 1;
	_garage = _args select 2;
	
	_car = [_uid, _garage, "car", "STRING"] call iniDB_read;

	
	if (_car=="") then
	{//no car
		[50,nil] remoteExec ["Messages",_caller];
	}
	else
	{
		_weaponsItemsCargo = [_uid, _garage, "weaponsItemsCargo", "ARRAY"] call iniDB_read;
		_itemCargo = [_uid, _garage, "itemCargo", "ARRAY"] call iniDB_read;
		_magazineCargo = [_uid, _garage, "magazineCargo", "ARRAY"] call iniDB_read;
		_backpackCargo = [_uid, _garage, "backpackCargo", "ARRAY"] call iniDB_read;
		_colour = [_uid, _garage, "colour", "STRING"] call iniDB_read;
		
		//wipe memory
		_ret = [_uid, _garage, "car", ""] call iniDB_write;
		_ret = [_uid, _garage, "weaponsItemsCargo", ""] call iniDB_write;
		_ret = [_uid, _garage, "itemCargo", ""] call iniDB_write;
		_ret = [_uid, _garage, "magazineCargo", ""] call iniDB_write;
		_ret = [_uid, _garage, "backpackCargo", ""] call iniDB_write;
		_ret = [_uid, _garage, "colour", ""] call iniDB_write;
		
		//hint str [_car,_weaponsItemsCargo,_itemCargo,_magazineCargo,_backpackCargo];
		
		_myCar = objNull;
		_myCar setVariable ["BIS_enableRandomization",false];
		_myCar setVariable ["color",1];
		_myCar setObjectTextureGlobal [0,_colour];
		_myCar = _car createVehicle position _caller;
		_myCar setObjectTextureGlobal [0,_colour];
		_caller action ["getInDriver",_myCar];
		[_caller,_myCar] spawn {
		    //pvs
		    private ["_caller", "_myCar"];
		    
			sleep 5;
			_caller = _this select 0;
			_myCar = _this select 1;
			_caller action ["getInDriver",_myCar];
		};
		
		
		clearWeaponCargoGlobal _myCar;
		clearItemCargoGlobal _myCar;
		clearBackpackCargoGlobal _myCar;
		clearMagazineCargoGlobal _myCar;
		{
			_myCar addweaponCargoGlobal [(_x select 0),1];
			_myCar addItemCargoGlobal [(_x select 1),1];
			_myCar addItemCargoGlobal [(_x select 2),1];
			_myCar addItemCargoGlobal [(_x select 3),1];
			_myCar addMagazineCargoGlobal [(_x select 4) select 0,1];
			_myCar addItemCargoGlobal [(_x select 5),1];
		}forEach _weaponsItemsCargo;
		
		{
			_myCar addItemCargoGlobal [_x,1];
		}forEach _itemCargo;
		
		{
			_myCar addMagazineCargoGlobal [_x,1];
		}forEach _magazineCargo;
		
		{
			_myCar addBackpackCargoGlobal [_x,1];
		}forEach _backpackCargo;
		
		//send success message
		[51,nil] remoteExec ["Messages",_caller];
	};
};

//save gear
"SaveGear" addPublicVariableEventHandler{
	//SaveGear = [[_caller,_uid],[_playerUniform,_playerVest,_playerBackpack,_playerWeaponsItems,_playerUniformItems,_playerVestItems,_playerBackpackItems,_playerMapItems,_playerHelmet,_playerGlasses],[_weaponsItemsCargo,_itemCargo,_magazineCargo,_backpackCargo]];
	//pvs
	private ["_aPVEHName", "_args", "_playerInfo", "_playerGear", "_crateGear", "_onlyLoadout", "_caller", "_owner", "_playerUniform", "_playerVest", "_playerBackpack", "_playerWeaponsItems", "_playerUniformItems", "_playerVestItems", "_playerBackpackItems", "_playerMapItems", "_playerHelmet", "_playerGlasses", "_weaponsItemsCargo", "_itemCargo", "_magazineCargo", "_backpackCargo", "_ret","_uid"];
	
	_aPVEHName = _this select 0;
	_args = _this select 1;
	
	_playerInfo = _args select 0;
	_playerGear = _args select 1;
	_crateGear = _args select 2;
	if (count _args < 4) then
	{
		_onlyLoadout = false;
	}
	else
	{
		_onlyLoadout = _args select 3;
	};
	
	_caller = _playerInfo select 0;
	_uid = _playerInfo select 1;
	_owner = owner _caller;
	
	_playerUniform = _playerGear select 0;
	_playerVest = _playerGear select 1;
	_playerBackpack = _playerGear select 2;
	_playerWeaponsItems = _playerGear select 3;
	_playerUniformItems = _playerGear select 4;
	_playerVestItems = _playerGear select 5;
	_playerBackpackItems = _playerGear select 6;
	_playerMapItems = _playerGear select 7;
	_playerHelmet = _playerGear select 8;
	_playerGlasses = _playerGear select 9;
	
	_weaponsItemsCargo = _crateGear select 0;
	_itemCargo = _crateGear select 1;
	_magazineCargo = _crateGear select 2;
	_backpackCargo = _crateGear select 3;
	
	_ret = [_uid, "Gear", "playerUniform", _playerUniform] call iniDB_write;
	_ret = [_uid, "Gear", "playerVest", _playerVest] call iniDB_write;
	_ret = [_uid, "Gear", "playerBackpack", _playerBackpack] call iniDB_write;
	_ret = [_uid, "Gear", "playerWeaponsItems", _playerWeaponsItems] call iniDB_write;
	_ret = [_uid, "Gear", "playerUniformItems", _playerUniformItems] call iniDB_write;
	_ret = [_uid, "Gear", "playerVestItems", _playerVestItems] call iniDB_write;
	_ret = [_uid, "Gear", "playerBackpackItems", _playerBackpackItems] call iniDB_write;
	_ret = [_uid, "Gear", "playerMapItems", _playerMapItems] call iniDB_write;
	_ret = [_uid, "Gear", "playerHelmet", _playerHelmet] call iniDB_write;
	_ret = [_uid, "Gear", "playerGlasses", _playerGlasses] call iniDB_write;
	
	if !(_onlyLoadout) then
	{/* 
		_ret = [_uid, "Gear", "weaponsItemsCargo", _weaponsItemsCargo] call iniDB_write;
		_ret = [_uid, "Gear", "itemCargo", _itemCargo] call iniDB_write;
		_ret = [_uid, "Gear", "magazineCargo", _magazineCargo] call iniDB_write;
		_ret = [_uid, "Gear", "backpackCargo", _backpackCargo] call iniDB_write;
		 */
		{
			_ret = [_uid, "Gear", _x + "weaponsItemsCargo", _weaponsItemsCargo select _forEachIndex] call iniDB_write;
			_ret = [_uid, "Gear", _x + "itemCargo", _itemCargo select _forEachIndex] call iniDB_write;
			_ret = [_uid, "Gear", _x + "magazineCargo", _magazineCargo select _forEachIndex] call iniDB_write;
			_ret = [_uid, "Gear", _x + "backpackCargo", _backpackCargo select _forEachIndex] call iniDB_write;
		}forEach ServerBoxes;
	};
	//send success message
	[52,nil] remoteExec ["Messages",_caller];
};

//load gear
"LoadGear" addPublicVariableEventHandler{
	//LoadGear = player
	//pvs
	private ["_aPVEHName", "_player", "_owner", "_playerUniform", "_playerVest", "_playerBackpack", "_playerWeaponsItems", "_playerUniformItems", "_playerVestItems", "_playerBackpackItems", "_playerMapItems", "_playerHelmet", "_playerGlasses", "_weaponsItemsCargo", "_itemCargo", "_magazineCargo", "_backpackCargo", "_a", "_b", "_c", "_d", "_wIC", "_iC", "_mC", "_bC", "_intro", "_ret","_uid"];
	
	_aPVEHName = _this select 0;
	_player = _this select 1;
	
	_uid = getPlayerUID _player;
	_owner = owner _player;
	
	_playerUniform = [_uid, "Gear", "playerUniform", "STRING"] call iniDB_read;
	_playerVest = [_uid, "Gear", "playerVest", "STRING"] call iniDB_read;
	_playerBackpack = [_uid, "Gear", "playerBackpack", "STRING"] call iniDB_read;
	_playerWeaponsItems = [_uid, "Gear", "playerWeaponsItems", "ARRAY"] call iniDB_read;
	_playerUniformItems = [_uid, "Gear", "playerUniformItems", "ARRAY"] call iniDB_read;
	_playerVestItems = [_uid, "Gear", "playerVestItems", "ARRAY"] call iniDB_read;
	_playerBackpackItems = [_uid, "Gear", "playerBackpackItems", "ARRAY"] call iniDB_read;
	_playerMapItems = [_uid, "Gear", "playerMapItems", "ARRAY"] call iniDB_read;
	_playerHelmet = [_uid, "Gear", "playerHelmet", "STRING"] call iniDB_read;
	_playerGlasses = [_uid, "Gear", "playerGlasses", "STRING"] call iniDB_read;
/* 	_weaponsItemsCargo = [_uid, "Gear", "weaponsItemsCargo", "ARRAY"] call iniDB_read;
	_itemCargo = [_uid, "Gear", "itemCargo", "ARRAY"] call iniDB_read;
	_magazineCargo = [_uid, "Gear", "magazineCargo", "ARRAY"] call iniDB_read;
	_backpackCargo = [_uid, "Gear", "backpackCargo", "ARRAY"] call iniDB_read; */
	
	
	_weaponsItemsCargo = [];
	_itemCargo = [];
	_magazineCargo = [];
	_backpackCargo = [];
		
	{
		_a = (_x + "weaponsItemsCargo");
		_b = (_x + "itemCargo");
		_c = (_x + "magazineCargo");
		_d = (_x + "backpackCargo");
		_wIC = [_uid, "Gear", _a, "ARRAY"] call iniDB_read;
		_iC = [_uid, "Gear", _b, "ARRAY"] call iniDB_read;
		_mC = [_uid, "Gear", _c, "ARRAY"] call iniDB_read;
		_bC = [_uid, "Gear", _d, "ARRAY"] call iniDB_read;
		_weaponsItemsCargo append [_wIC];
		_itemCargo append [_iC];
		_magazineCargo append [_mC];
		_backpackCargo append [_bC];
	}forEach ServerBoxes;
		
		
	
	_intro = [_uid, "Intro", "Intro", "SCALAR"] call iniDB_read;
	
	//save intro info
	_ret = [_uid, "Intro", "Intro", 1] call iniDB_write;
	
	//send gear and intro info
	Gear = [[_playerUniform,_playerVest,_playerBackpack,_playerWeaponsItems,_playerUniformItems,_playerVestItems,_playerBackpackItems,_playerMapItems,_playerHelmet,_playerGlasses],
		[_weaponsItemsCargo,_itemCargo,_magazineCargo,_backpackCargo],
		_intro];
	_owner publicVariableClient "Gear";
};


//Save and Load position
//SaveLocation = [_caller,_uid,_location,_direction];
"SaveLocation" addPublicVariableEventHandler{
    //pvs
	private ["_aPVEHName", "_args", "_caller", "_location", "_direction", "_NPC", "_NPCString", "_NPCNumber", "_respawns", "_ret","_uid"];
	
	_aPVEHName = _this select 0;
	_args = _this select 1;
	
	//var init
	_caller = _args select 0;
	_uid = _args select 1;
	_location = _args select 2;
	_direction = _args select 3;
	_NPC = _args select 4;
	
	//if called from an NPC, update respawn possibilities
	if not (_NPC == _caller) then
	{
		//get NPC number
		_NPCString = str _NPC;
		_NPCNumber = parseNumber(_NPCString select [3,1]);
		
		//Update NPC respawn array
		_respawns = [_uid, "Respawns", "Respawns", "ARRAY"] call iniDB_read;
		_respawns set [_NPCNumber,1];
		_ret = [_uid, "Respawns", "Respawns", _respawns] call iniDB_write;
	};	

	//save exact location and direction
	_ret = [_uid, "Location", "Location", _location] call iniDB_write;
	_ret = [_uid, "Location", "Direction", _direction] call iniDB_write;
	
	//tell caller that location is saved
	[45,nil] remoteExec ["Messages",_caller];
	
};

//get and send start location
"LoadLocation" addPublicVariableEventHandler{
	//LoadLocation = [player,_uid];
	//pvs
	private ["_aPVEHName", "_args", "_caller", "_steamName", "_ret", "_owner", "_respawns", "_intro", "_location", "_direction", "_PMArray", "_garage", "_onList", "_strCount", "_count","_uid","_name"];
	
	_aPVEHName = _this select 0;
	_args = _this select 1;
	
	_caller = _args select 0;
	_uid = _args select 1;
	_steamName = _args select 2;
	
	//write steam name to file
	_ret = [_uid, "SteamName", "SteamName", _steamName] call iniDB_write;
	
	_owner = owner _caller;
	
	//respawn loactions
	//read intro info
	_respawns = [_uid, "Respawns", "Respawns", "ARRAY"] call iniDB_read;
	_intro = [_uid, "Intro", "Intro", "SCALAR"] call iniDB_read;
	_location = [_uid, "Location", "Location", "ARRAY"] call iniDB_read;
	_direction = [_uid, "Location", "Direction", "SCALAR"] call iniDB_read;
	
	//create new respawns array if needed
	if (_intro!=1) then
	{
		//kill counts
		_ret = [_uid, "KillCounts", "Enemy", 0] call iniDB_write;
		_ret = [_uid, "KillCounts", "Friendly", 0] call iniDB_write;
		_ret = [_uid, "KillCounts", "Players", 0] call iniDB_write;
		_ret = [_uid, "KillCounts", "Suicides", 0] call iniDB_write;
		_ret = [_uid, "KillCounts", "Civilian", 0] call iniDB_write;
		_ret = [_uid, "KillCounts", "Animal", 0] call iniDB_write;
		_ret = [_uid, "KillCounts", "Car", 0] call iniDB_write;
		_ret = [_uid, "KillCounts", "Plane", 0] call iniDB_write;
		
		//respawn locations
		_ret = [_uid, "Respawns", "Respawns", [0,0,0,0,0,0,0,0,0,0]] call iniDB_write;
		
		//job progress info
		_ret = [_uid, "QUESTDATA", "NPC0", [0,0,0,0,0,0,0,0,0,0]] call iniDB_write;
		_ret = [_uid, "QUESTDATA", "NPC1", [0,0,0,0,0,0,0,0,0,0]] call iniDB_write;
		_ret = [_uid, "QUESTDATA", "NPC2", [0,0,0,0,0,0,0,0,0,0]] call iniDB_write;
		_ret = [_uid, "QUESTDATA", "NPC3", [0,0,0,0,0,0,0,0,0,0]] call iniDB_write;
		_ret = [_uid, "QUESTDATA", "NPC4", [0,0,0,0,0,0,0,0,0,0]] call iniDB_write;
		_ret = [_uid, "QUESTDATA", "NPC5", [0,0,0,0,0,0,0,0,0,0]] call iniDB_write;
		_ret = [_uid, "QUESTDATA", "NPC6", [0,0,0,0,0,0,0,0,0,0]] call iniDB_write;
		_ret = [_uid, "QUESTDATA", "NPC7", [0,0,0,0,0,0,0,0,0,0]] call iniDB_write;
		_ret = [_uid, "QUESTDATA", "NPC8", [0,0,0,0,0,0,0,0,0,0]] call iniDB_write;
		_ret = [_uid, "QUESTDATA", "NPC9", [0,0,0,0,0,0,0,0,0,0]] call iniDB_write;
		
		_PMArray = [[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0]];
		_ret = [_uid, "QUESTDATA", "PM", _PMArray] call iniDB_write;
		
		{
			_garage = format["Garage%1",_x];
			_ret = [_uid, _garage, "car", ""] call iniDB_write;
			_ret = [_uid, _garage, "weaponsItemsCargo", ""] call iniDB_write;
			_ret = [_uid, _garage, "itemCargo", ""] call iniDB_write;
			_ret = [_uid, _garage, "magazineCargo", ""] call iniDB_write;
			_ret = [_uid, _garage, "backpackCargo", ""] call iniDB_write;
			_ret = [_uid, _garage, "colour", ""] call iniDB_write;
		}forEach[1,2,3,4,5,6,7,8,9,10];
			
		//Starting money
		_ret = [_uid, "MONEY", "Money", StartingMoney] call iniDB_write;
		
		//player before?
		_name = name _caller;
		_onList = moneyNames find _name;
		_strCount = "";
		
		if (_onList == -1) then
		{
			_count = count moneyNames;
			_strCount = str _count;
		}
		else
		{
			_count = _onList;
			_strCount =str _count;
		};
		
		//save player id
		_ret = ["MoneyList", "UIDs", _strCount, _uid] call iniDB_write;
		moneyUIDS set [_count,_uid];
		//save player name
		_name = name _caller;
		_ret = ["MoneyList", "Names", _strCount, _name] call iniDB_write;
		moneyNames set [_count,_name];
		//save player money
		_ret = ["MoneyList", "Money", _strCount, StartingMoney] call iniDB_write;
		moneyMoney set [_count,StartingMoney];
		//save player steam name
		_ret = ["MoneyList", "SteamNames", _strCount, _steamName] call iniDB_write;
		moneySteamNames set [_count,_steamName];
	};
	
	//send load location
	Location = [_location,_direction,_respawns,_intro];
	_owner publicVariableClient "Location";
};

//PersonalMission
"PersonalMission" addPublicVariableEventHandler{
	//PersonalMission = _i, _j, player
	//pvs
	private ["_aPVEHName", "_args", "_missionType", "_missionLevel", "_caller", "_startTime"];
	_aPVEHName = _this select 0;
	_args = _this select 1;
	
	_missionType = _args select 0;
	_missionLevel = _args select 1;
	_caller = _args select 2;
	_startTime = _args select 3;
	
	[_missionType,_missionLevel,_caller,_startTime] execVM "LoadPersonalTask.sqf";
};

//Server ends player mission either by deleting mission or leaving group
"PMEnd" addPublicVariableEventHandler {
	//[_taskString,_theGroup]
	//	PMEnd = [_job, group player,"Canceled"];
	//pvs
	private ["_args", "_taskString", "_theGroup", "_taskState", "_missionType", "_missionLevel", "_hireCost", "_leader", "_leaderUID", "_task", "_earnings", "_i", "_mission", "_check", "_ret", "_memberMoney", "_leaderMoney", "_PMArray", "_PMArrayType", "_PMArrayMission", "_members","_uid"];
	
	_args = _this select 1;
	_taskString = _args select 0;
	_theGroup = _args select 1;
	_taskState = _args select 2;
	_missionType = parseNumber(_taskString select [2,1]);
	_missionLevel = parseNumber(_taskString select [4,1]);
	_hireCost = PMMoneyArray select _missionLevel;
	_leader = leader _theGroup;
	_leaderUID = getPlayerUID _leader;
	_task = _taskString call BIS_fnc_taskReal;
	_earnings = 0;
	
	//delete from MIP file
	for [{_i=0}, {_i<7}, {_i=_i+1}] do
	{
		_mission = format["Mission%1",_i];
		_check = ["MissionsInProgress", "MISSIONS", _mission, "STRING"] call iniDB_read;
		if (_check == _taskString) then
		{
			_ret = ["MissionsInProgress", "MISSIONS", _mission, ""] call iniDB_write;
		};
	};
	
	//task complete
	[_taskString,_taskState] call BIS_fnc_taskSetState;
	if (_taskState == "Succeeded") then
	{
		//give/remove player moneys
		{
			if (isPlayer _x) then
			{
				_uid = getPlayerUID _x;
				if !(_leader == _x) then
				{
					_memberMoney = [_uid, "MONEY", "Money", "SCALAR"] call iniDB_read;
					_memberMoney = _memberMoney + _hireCost;
					_ret = [_uid, "MONEY", "Money", _memberMoney] call iniDB_write;
					_leaderMoney = [_leaderUID, "MONEY", "Money", "SCALAR"] call iniDB_read;
					_leaderMoney = _leaderMoney - _hireCost;
					_ret = [_leaderUID, "MONEY", "Money", _leaderMoney] call iniDB_write;
					[30,[_memberMoney,_hireCost]] remoteExec ["Messages",_x];
				}
				else
				{
					if (_missionType == 0) then
					{
						_earnings = PMCashArray select _missionLevel;
						_leaderMoney = [_leaderUID, "MONEY", "Money", "SCALAR"] call iniDB_read;
						_leaderMoney = _leaderMoney + _earnings;
						_ret = [_leaderUID, "MONEY", "Money", _leaderMoney] call iniDB_write;
					};
					if (_missionType == 9) then
					{
						_earnings = PMCashArray select 0;
						_leaderMoney = [_leaderUID, "MONEY", "Money", "SCALAR"] call iniDB_read;
						_leaderMoney = _leaderMoney + _earnings;
						_ret = [_leaderUID, "MONEY", "Money", _leaderMoney] call iniDB_write;
					};
				};
				
				_PMArray = [_uid, "QUESTDATA", "PM", "ARRAY"] call iniDB_read;
				_PMArrayType = _PMArray select _missionType;
				_PMArrayMission = (_PMArrayType select _missionLevel) + 1;
				_PMArrayType set [_missionLevel,(_PMArrayType select _missionLevel) + 1];
				_PMArray set [_missionType,_PMArrayType];
				_ret = [_uid, "QUESTDATA", "PM", _PMArray] call iniDB_write;
			};
		}forEach units _theGroup;
		
		//update leader on their cash
		_leaderMoney = [_leaderUID, "MONEY", "Money", "SCALAR"] call iniDB_read;
		
		_members = (count (units _theGroup)) - 1;
		_leaderMoney = _leaderMoney - (_members * _hireCost);
		_ret = [_leaderUID, "MONEY", "Money", _leaderMoney] call iniDB_write;
		
		[30,[_leaderMoney,_earnings - (_members*_hireCost)]] remoteExec ["Messages",_leader];
	};
	
	[_taskString,_theGroup] spawn {
	    //pvs
	    private ["_taskString", "_theGroup"];
	    
		_taskString = _this select 0;
		_theGroup = _this select 1;
		sleep 15;
		[_taskString,true] call BIS_fnc_deleteTask;
		{
			[_x] join grpNull;
		}forEach units _theGroup;
	};
};

//Server ends player mission either by deleting mission or leaving group
"QuitMission" addPublicVariableEventHandler {
    //pvs
	private ["_args", "_caller", "_missionID", "_i", "_mission", "_check", "_ret"];
	
	_args = _this select 1;
	_caller = _args select 0;
	_missionID = _args select 1;
	
	if ((leader (group _caller))==_caller) then
	{
		[_missionID,true] call BIS_fnc_deleteTask;
		
		//delete from MIP file
		for [{_i=0}, {_i<7}, {_i=_i+1}] do
		{
			_mission = format["Mission%1",_i];
			_check = ["MissionsInProgress", "MISSIONS", _mission, "STRING"] call iniDB_read;
			if (_check == _missionID) then
			{
				_ret = ["MissionsInProgress", "MISSIONS", _mission, ""] call iniDB_write;
			};
		};
	
		{
			if not (isPlayer _x) then
			{
				[_x] execVM "DismissCiv.sqf";
			}
			else
			{
				[_x] joinSilent grpNull;
				[] remoteExec ["ReceiveCurrentMission",_x];
				[54,nil] remoteExec ["Messages",_x];
			};
		}forEach units group _caller;
	}
	else
	{
		[_caller] join grpNull;
		[_missionID,_caller] call BIS_fnc_deleteTask;
		
		[] remoteExec ["ReceiveCurrentMission",_caller];
		[55,nil] remoteExec ["Messages",_caller];
	};
};

"GetIntel" addPublicVariableEventHandler {
	//GetIntel = [player,GUITargetObject];
	//pvs
	private ["_args", "_caller", "_owner", "_info", "_steamName", "_jobs", "_PMArray", "_money", "_k0", "_k1", "_k2", "_k3", "_k4", "_k5", "_k6", "_k7", "_k8", "_p0", "_p1", "_p2", "_p3", "_p4", "_p5", "_p6", "_p7", "_p8", "_p9", "_jobsNo", "_PMNo","_target","_name","_uid"];

	_args = _this select 1;
	_caller = _args select 0;
	_target = _args select 1;
	_owner = owner _caller;
	Intel = [];
	//_info = [_x,_name,_steamName,_jobs,_PMArray,_money,_k0,_k1,_k2,_k3,_k4,_k5,_k6,_k7,_k8];
	_info = [];
	if (isPlayer _target) then
	{
		_uid = getPlayerUID _target;
		
		_name = name _target;
		_steamName = [_uid, "SteamName", "SteamName", "STRING"] call iniDB_read;
		_p0 = [_uid, "QUESTDATA", "NPC0", "ARRAY"] call iniDB_read;
		_p1 = [_uid, "QUESTDATA", "NPC1", "ARRAY"] call iniDB_read;
		_p2 = [_uid, "QUESTDATA", "NPC2", "ARRAY"] call iniDB_read;
		_p3 = [_uid, "QUESTDATA", "NPC3", "ARRAY"] call iniDB_read;
		_p4 = [_uid, "QUESTDATA", "NPC4", "ARRAY"] call iniDB_read;
		_p5 = [_uid, "QUESTDATA", "NPC5", "ARRAY"] call iniDB_read;
		_p6 = [_uid, "QUESTDATA", "NPC6", "ARRAY"] call iniDB_read;
		_p7 = [_uid, "QUESTDATA", "NPC7", "ARRAY"] call iniDB_read;
		_p8 = [_uid, "QUESTDATA", "NPC8", "ARRAY"] call iniDB_read;
		_p9 = [_uid, "QUESTDATA", "NPC9", "ARRAY"] call iniDB_read;
		
		_jobs = [_p0,_p1,_p2,_p3,_p4,_p5,_p6,_p7,_p8,_p9];
		_jobsNo = _jobs call DeepSum;
		
		_PMArray = [_uid, "QUESTDATA", "PM", "ARRAY"] call iniDB_read;
		_PMNo = _PMArray call DeepSum;
		
		_k0 = [_uid, "KillCounts", "Enemy", "SCALAR"] call iniDB_read;
		_k1 = [_uid, "KillCounts", "Friendly", "SCALAR"] call iniDB_read;
		_k2 = [_uid, "KillCounts", "Players", "SCALAR"] call iniDB_read;
		_k3 = [_uid, "KillCounts", "Suicides", "SCALAR"] call iniDB_read;
		_k4 = [_uid, "KillCounts", "Civilian", "SCALAR"] call iniDB_read;
		_k5 = [_uid, "KillCounts", "Animal", "SCALAR"] call iniDB_read;
		_k6 = [_uid, "KillCounts", "Car", "SCALAR"] call iniDB_read;
		_k7 = [_uid, "KillCounts", "Plane", "SCALAR"] call iniDB_read;
		_money = [_uid, "MONEY", "Money", "SCALAR"] call iniDB_read;
		
		_info = [_target,_name,_steamName,_jobsNo,_PMNo,_money,_k0,_k1,_k2,_k3,_k4,_k5,_k6,_k7];
	}
	else
	{
		_info = [_target];
	};
	
	Intel = _info;
	
	_owner publicVariableClient "Intel";
};

"GetGarageIntel" addPublicVariableEventHandler{
	//GarageAccess = [player];
	//pvs
	private ["_aPVEHName", "_args", "_caller", "_GarageIntel", "_garage", "_car", "_owner","_uid"];
	
	_aPVEHName = _this select 0;
	_args = _this select 1;
	_caller = _args select 0;
	_uid = getPlayerUID _caller;
	
	_GarageIntel = [];
	{
	    _garage = format["Garage%1",_x];
    	_car = [_uid, _garage, "car", "STRING"] call iniDB_read;
    	_GarageIntel pushBack _car;
	}forEach [1,2,3,4,5,6,7,8,9,10];
	
	GarageIntel = _GarageIntel;
	_owner = owner _caller;
	_owner publicVariableClient "GarageIntel";
};


//send total cash
"DonateVar" addPublicVariableEventHandler{
    //pvs
	private ["_PVEHName", "_caller", "_owner","_uid"];
	//Donate = [player,GUITargetObject];
	
	_PVEHName = _this select 0;
	_args = _this select 1;
	_player = _args select 0;
	_target = _args select 1;

	_uid = getPlayerUID _player;
	
	_cash = [_uid, "MONEY", "Money", "SCALAR"] call iniDB_read;
	
	if (_cash>9) then
	{
		_cash = _cash - 10;
		_ret = [_uid, "MONEY", "Money", _cash] call iniDB_write;
		[30,[_cash,-10]] remoteExec ["Messages",_player];
		
		
		_uid = getPlayerUID _target;
		
		_cash = [_uid, "MONEY", "Money", "SCALAR"] call iniDB_read;
		_cash = _cash + 10;
		_ret = [_uid, "MONEY", "Money", _cash] call iniDB_write;
		[30,[_cash,10]] remoteExec ["Messages",_target];
	};
};