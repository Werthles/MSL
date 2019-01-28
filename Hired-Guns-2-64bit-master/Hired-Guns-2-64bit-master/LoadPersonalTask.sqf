//LoadPersonalTask.sqf
//Runs on server
//Called from server on player request from PM map
//Called from PersonalMission PVEH
//Builds PMs from PersonalMissionArray and PM data

//pvs
private ["_missionType", "_missionLevel", "_caller", "_startTime", "_missionFileName", "_groupArray", "_newTask", "_mission1", "_title", "_number", "_difficulty", "_type", "_shortDesc", "_leaderCash", "_squadCash", "_squadSize", "_location", "_targetType", "_targetStrength", "_theGroup", "_Mission0", "_Mission1", "_Mission2", "_Mission3", "_Mission4", "_Mission5", "_Mission6", "_isInProgress", "_MIPWritten", "_MIPNumber", "_ret", "_MIPUIP", "_starter", "_getUID", "_missionNumber", "_CM", "_taskName", "_description", "_marker", "_destination", "_camTarget1", "_camPos1", "_camTarget2", "_camPos2", "_camTarget3", "_camPos3", "_CI", "_radius", "_Xpos", "_Ypos", "_markerstr", "_missionObjectList", "_NPCID", "_progress", "_sum", "_jj", "_groupName", "_Type", "_ii", "_unitArray", "_Position", "_Side", "_Azimuth", "_relativeArray", "_unit", "_iniType", "_Coord", "_newGroup", "_skill", "_waypoint", "_waypointType", "_kk", "_WaypointType", "_trg", "_wp", "_iniWP", "_iniWPType", "_jobCompleteCount", "_p", "_enemyIs", "_newTrig", "_newTrig2", "_spawn3", "_NPC", "_win", "_exit", "_state", "_state2", "_rankArray", "_unitNumber", "_ammo", "_side", "_loop", "_i", "_xPos", "_yPos", "_wayPos", "_notLand", "_wp1", "_wp2", "_wp3", "_wp4", "_boxLetter", "_lootType", "_loot", "_allDone","_target","_uid","_name"];

_missionType = _this select 0;
_missionLevel = _this select 1;
_caller = _this select 2;
_startTime = _this select 3;
_missionFileName = format["PM%1b%2",_missionType,_missionLevel];
_groupArray = [];
_newTask = taskNull;

//_mission1 = [_title,_number,_difficulty,_type,_shortDesc,_leaderCash,_squadCash,_squadSize,_location,_target,_targetType,_targetStrength];

//other inits
_theGroup = group _caller;
_uid = getPlayerUID _caller;
_name = name _caller;

//read missions in progress
_Mission0 = ["MissionsInProgress", "MISSIONS", "Mission0", "STRING"] call iniDB_read;
_Mission1 = ["MissionsInProgress", "MISSIONS", "Mission1", "STRING"] call iniDB_read;
_Mission2 = ["MissionsInProgress", "MISSIONS", "Mission2", "STRING"] call iniDB_read;
_Mission3 = ["MissionsInProgress", "MISSIONS", "Mission3", "STRING"] call iniDB_read;
_Mission4 = ["MissionsInProgress", "MISSIONS", "Mission4", "STRING"] call iniDB_read;
_Mission5 = ["MissionsInProgress", "MISSIONS", "Mission5", "STRING"] call iniDB_read;
_Mission6 = ["MissionsInProgress", "MISSIONS", "Mission6", "STRING"] call iniDB_read;

_isInProgress = false;
_MIPWritten = false;
{//check if in progress
	if (_x==_missionFileName) then
	{
		_isInProgress = true;
	};
}forEach [_Mission0,_Mission1,_Mission2,_Mission3,_Mission4,_Mission5,_Mission6];

if not (_isInProgress) then
{
	{//write mission in MIP list
		if (_x=="" and not _MIPWritten) then
		{
			_MIPNumber = format["Mission%1",_forEachIndex];
			_ret = ["MissionsInProgress", "MISSIONS", _MIPNumber, _missionFileName] call iniDB_write;
			_MIPWritten = true;
		};
	}forEach [_Mission0,_Mission1,_Mission2,_Mission3,_Mission4,_Mission5,_Mission6];
};

if not (_MIPWritten) then
{
	if (_isInProgress) then
	{
		_MIPUIP = ["MissionsInProgress", "UID", _missionFileName, "STRING"] call iniDB_read;
		_starter = "";
		{
			_getUID = getPlayerUID _x;
			if (_getUID == _MIPUIP) then
			{
				_starter = name _x;
			};
		}forEach playableUnits;

		if (_starter == "") then
		{//MIP
			[31,nil] remoteExec ["Messages",_caller];
		}
		else
		{//MIP + leader
			[32,_starter] remoteExec ["Messages",_caller];
		};
	}
	else
	{//server maxed
		[33,nil] remoteExec ["Messages",_caller];
	};
}
else // MAIN TASK LOADING CODE
{
	//write player ID to MIP file
	_ret = ["MissionsInProgress", "UID", _missionFileName, _uid] call iniDB_write;

	_missionNumber = (_missionType*3 + _missionLevel);
	_CM = [
		PersonalMissionArray select _missionNumber select 2,
		_missionNumber,
		_missionLevel,
		_missionType,
		PMDescriptions select _missionType,
		PMRewardArray select _missionType,
		PMMoneyArray select _missionLevel,
		"Unlimited",
		PMLocations select _missionType select _missionLevel,
		_missionType,
		"Loot",
		_caller,
		_missionFileName
	];

	_CM remoteExec ["ReceiveCurrentMission",_caller];
	
	//get taskCreate info
	_taskName = _missionFileName;
	_missionNumber = (_missionType * (count (PMLocations select 0))) + _missionLevel;
	_description = PersonalMissionArray select _missionNumber select 3;
	_title = PersonalMissionArray select _missionNumber select 2;
	_marker = PMTypeArray select _missionType;
	_destination = PMLocations select _missionType select _missionLevel;
	
	if (_missionType == 9) then
	{//Watch TV end mission
		//intro vids custom pos required
		_camTarget1 = getPos _caller;
		_camPos1 = _camTarget1 vectorAdd [0,20,5];
		_camTarget2 = PMLocations select _missionType select _missionLevel;
		_camPos2 = _camTarget2 vectorAdd [0,50,20];
		_camTarget3 = PMLootDropOffs select _missionType select _missionLevel;
		_camPos3 = _camTarget3 vectorAdd [0,500,100];
		_CI = [_camPos1,_camTarget1,_camPos2,_camTarget2,_camPos3,_camTarget3,_title,_missionFileName,_caller];
		if (local _caller) then
		{
			_CI execVM "JobIntros.sqf";
		};
		_CI remoteExec ["JobIntros",units (group _caller)];
		
		sleep 0.2;
		
		_description = "Your favourite show is interrupted by a news broadcast, saying that a full CSAT invasion is on the way!<br/><br/>The other Tanoan leaders will have heard this too, but will they send help? Maybe if you helped them to fulfill their desires.<br/><br/>Get rid off all CSAT forces from the marked area!";
		_title = "Relaxation Interrupted";
		_marker = "";
		_destination = PMLocations select _missionType select _missionLevel;
		
		_newTask = [_theGroup,_taskName,[_description,_title,_marker],_destination,TRUE,10,true,"defend",false] call BIS_fnc_taskCreate;
		
		//create a marker
		_radius = 1150;
		_Xpos = _destination select 0;
		_Ypos = _destination select 1;
		_markerstr = createMarker [_title,[_Xpos,_Ypos]];
		_markerstr setMarkerShape "ELLIPSE";
		_markerstr setMarkerColor "ColorYELLOW";
		_markerstr setMarkerSize [_radius,_radius];
		_markerstr setMarkerBrush "FDiagonal";
		_markerstr setMarkerText "Mission in Progress";
		
		//_groupArray = [];
		_missionObjectList = [];
		/////////////////////////////////////////
		//Spawn enemies
		
		{
	        
	        _missionFileName = format["EndEnemyb%1",_x];
	        
	        //add groups
        	_jj = 1;
        	//_groupArray = [];
        	_groupName = format["GROUP%1",_jj];
        	_Type = [_missionFileName, _groupName, "Type1", "STRING"] call iniDB_read;
        
        	while {_Type!=""} do
        	{
        		_ii = 2;
        		_unitArray = [];
        		_groupName = format["GROUP%1",_jj];
        		_Position = [_missionFileName, _groupName, "Position", "ARRAY"] call iniDB_read;
        		_Side = [_missionFileName, _groupName, "Side", "STRING"] call iniDB_read;
        		_Azimuth = [_missionFileName, _groupName, "Azimuth", "SCALAR"] call iniDB_read;
        		_Type = [_missionFileName, _groupName, "Type1", "STRING"] call iniDB_read;
        		_relativeArray = [];
        		_unit = missionNamespace getVariable _Type;
        		
        		//get array of units
        		While {_Type!=""} do
        		{
        			_unit = missionNamespace getVariable _Type;
        			_unitArray = _unitArray + [_unit];
        			_iniType = format["Type%1",_ii];
        			_Type = [_missionFileName, _groupName, _iniType, "STRING"] call iniDB_read;
        			_Coord = (_ii-1)*-3;
        			_relativeArray = _relativeArray + [[_Coord,_Coord,0]];
        			_ii = _ii + 1;
        		};//end unit while
        		
        		//init. _newGroup
        		_newGroup = grpNull;
        		
        		//difficulty
        		_skill = [0.21+(HGDifficulty*AddedDifficulty),0.21+(HGDifficulty*AddedDifficulty)];
        		
        		//Side needs script	
        		switch (_Side) do
        		{
        			case "EAST":
        			{
        				_newGroup = [_Position, EAST, _unitArray, _relativeArray,[],_skill,[],[],_Azimuth] call BIS_fnc_spawnGroup;
        			};
        			case "WEST":
        			{
        				_newGroup = [_Position, WEST, _unitArray, _relativeArray,[],_skill,[],[],_Azimuth] call BIS_fnc_spawnGroup;
        			};
        			case "GUER":
        			{
        				_newGroup = [_Position, INDEPENDENT, _unitArray, _relativeArray,[],_skill,[],[],_Azimuth] call BIS_fnc_spawnGroup;
        			};
        /* 			case "":
        			{
        				_newGroup = [_Position, CIVILIAN, _unitArray, _relativeArray,[],[0.1,0.1],[],[],_Azimuth] call BIS_fnc_spawnGroup;
        				{
        					//_x forceAddUniform "U_OG_Guerilla1_1 ";
        					_x addWeaponGlobal "arifle_Mk20_ACO_pointer_F";
        					_x addMagazineGlobal "30Rnd_556x45_Stanag";
        					_x addMagazineGlobal "30Rnd_556x45_Stanag";
        				}forEach units _newGroup;
        			}; */
        			case "CIV":
        			{
        				_newGroup = [_Position, CIVILIAN, _unitArray, _relativeArray,[],[0,0],[],[],_Azimuth] call BIS_fnc_spawnGroup;
        					_x setskill ["aimingAccuracy",0];
        					_x setskill ["aimingShake",0];
        					_x setskill ["aimingSpeed",0];
        					_x setskill ["endurance",0];
        					_x setskill ["spotDistance",0];
        					_x setskill ["spotTime",0];
        					_x setskill ["courage",0];
        					_x setskill ["reloadSpeed",0];
        					_x setskill ["commanding",0];
        					_x setskill ["general",0];
        					{
        						_unit setVariable["type",floor (random 6),true];
        						_unit setVariable["rank",floor (random 10),true];
        						_unit setVariable["town","town1",true];
        					}forEach units _newGroup;
        			};
        		};
        		sleep 1;
        		//add new group to the array
        		_groupArray = _groupArray + [_newGroup];
        
        		//add waypoints
        		_waypoint = [_missionFileName, _groupName, "Waypoint1", "ARRAY"] call iniDB_read;
        		_waypointType = [_missionFileName, _groupName, "Waypoint1Type", "STRING"] call iniDB_read;
        		_kk = 2;
        		While {_waypointType!=""} do {
        			//waypoint setup
        			if (_kk>2 and _WaypointType=="AMBUSH") then
        			{
        				_trg = createTrigger ["EmptyDetector", _waypoint, true];
        				_trg setTriggerArea [100,100, 0, false];
        				_trg synchronizeTrigger [_wp];
        				_trg triggerAttachVehicle [_caller];
        				_trg setTriggerActivation ["GROUP","PRESENT",false];
        				_WaypointType = "SAD";
        			};
        			_wp = _newGroup addWaypoint[_waypoint,7];
        			if (_WaypointType=="WAIT") then
        			{
        				_WaypointType = "MOVE";
        				_wp setWaypointTimeout [300,300,300];
        			};
        			if (_WaypointType=="LIMITED") then
        			{
        				_WaypointType = "MOVE";
        				_wp setWaypointSpeed "LIMITED";
        			} else
        			{
        				_wp setWaypointSpeed "NORMAL";
        			};
        			if (_WaypointType=="HIDE") then
        			{
        				_WaypointType = "MOVE";
        				_wp setWaypointType _WaypointType;
        				_wp setWaypointTimeout [30,145,300];
        				_wp setWaypointBehaviour "STEALTH";
        				_wp setWaypointSpeed "LIMITED";
        				_wp setWaypointCombatMode "GREEN";
        				_wp setWaypointFormation "FILE";
        			}
        			else
        			{
        				_wp setWaypointBehaviour "SAFE";
        				_wp setWaypointCombatMode "YELLOW";
        				_wp setWaypointFormation "STAG COLUMN";
        				_wp setWaypointType _WaypointType;
        			};
        			//next waypoint setup
        			_iniWP = format["Waypoint%1",_kk];
        			_iniWPType = format["Waypoint%1Type",_kk];
        			_waypoint = [_missionFileName, _groupName, _iniWP, "ARRAY"] call iniDB_read;
        			_waypointType = [_missionFileName, _groupName, _iniWPType, "STRING"] call iniDB_read;
        			_kk = _kk + 1;
        			sleep 1;
        		};//end waypoint while
        		
        		//increment groups
        		_jj = _jj + 1;
        		_groupName = format["GROUP%1",_jj];
        		_Type = [_missionFileName, _groupName, "Type1", "STRING"] call iniDB_read;
        	};//end group while
		}forEach[10,0,1,2,4,5,6,7];
		/////////////////////////////////////////
		//Spawn friendlies
		
		{
		    _NPCID = format["NPC%1",_x];
		    _progress = [_uid, "QUESTDATA", _NPCID, "ARRAY"] call iniDB_read;
		    _sum = [_progress] call DeepSum;
		    if (_sum>4) then
		    {
		        //hint saying they are coming
		        [66,missionNamespace getVariable _NPCID] remoteExec ["Messages",_theGroup];
		        
		        _missionFileName = format["EndFriendlyb%1",_x];
		        
		        
		        //add groups
            	_jj = 1;
            	//_groupArray = [];
            	_groupName = format["GROUP%1",_jj];
            	_Type = [_missionFileName, _groupName, "Type1", "STRING"] call iniDB_read;
            
            	while {_Type!=""} do
            	{
            		_ii = 2;
            		_unitArray = [];
            		_groupName = format["GROUP%1",_jj];
            		_Position = [_missionFileName, _groupName, "Position", "ARRAY"] call iniDB_read;
            		_Side = [_missionFileName, _groupName, "Side", "STRING"] call iniDB_read;
            		_Azimuth = [_missionFileName, _groupName, "Azimuth", "SCALAR"] call iniDB_read;
            		_Type = [_missionFileName, _groupName, "Type1", "STRING"] call iniDB_read;
            		_relativeArray = [];
            		_unit = missionNamespace getVariable _Type;
            		
            		//get array of units
            		While {_Type!=""} do
            		{
            			_unit = missionNamespace getVariable _Type;
            			_unitArray = _unitArray + [_unit];
            			_iniType = format["Type%1",_ii];
            			_Type = [_missionFileName, _groupName, _iniType, "STRING"] call iniDB_read;
            			_Coord = (_ii-1)*-3;
            			_relativeArray = _relativeArray + [[_Coord,_Coord,0]];
            			_ii = _ii + 1;
            		};//end unit while
            		
            		//init. _newGroup
            		_newGroup = grpNull;
            		
            		//difficulty
            		_skill = [0.21+(HGDifficulty*AddedDifficulty),0.21+(HGDifficulty*AddedDifficulty)];
            		
            		//Side needs script	
            		switch (_Side) do
            		{
            			case "EAST":
            			{
            				_newGroup = [_Position, EAST, _unitArray, _relativeArray,[],_skill,[],[],_Azimuth] call BIS_fnc_spawnGroup;
            			};
            			case "WEST":
            			{
            				_newGroup = [_Position, WEST, _unitArray, _relativeArray,[],_skill,[],[],_Azimuth] call BIS_fnc_spawnGroup;
            			};
            			case "GUER":
            			{
            				_newGroup = [_Position, INDEPENDENT, _unitArray, _relativeArray,[],_skill,[],[],_Azimuth] call BIS_fnc_spawnGroup;
            			};
            /* 			case "":
            			{
            				_newGroup = [_Position, CIVILIAN, _unitArray, _relativeArray,[],[0.1,0.1],[],[],_Azimuth] call BIS_fnc_spawnGroup;
            				{
            					//_x forceAddUniform "U_OG_Guerilla1_1 ";
            					_x addWeaponGlobal "arifle_Mk20_ACO_pointer_F";
            					_x addMagazineGlobal "30Rnd_556x45_Stanag";
            					_x addMagazineGlobal "30Rnd_556x45_Stanag";
            				}forEach units _newGroup;
            			}; */
            			case "CIV":
            			{
            				_newGroup = [_Position, CIVILIAN, _unitArray, _relativeArray,[],[0,0],[],[],_Azimuth] call BIS_fnc_spawnGroup;
            					_x setskill ["aimingAccuracy",0];
            					_x setskill ["aimingShake",0];
            					_x setskill ["aimingSpeed",0];
            					_x setskill ["endurance",0];
            					_x setskill ["spotDistance",0];
            					_x setskill ["spotTime",0];
            					_x setskill ["courage",0];
            					_x setskill ["reloadSpeed",0];
            					_x setskill ["commanding",0];
            					_x setskill ["general",0];
            					{
            						_unit setVariable["type",floor (random 6),true];
            						_unit setVariable["rank",floor (random 10),true];
            						_unit setVariable["town","town1",true];
            					}forEach units _newGroup;
            			};
            		};
            		sleep 1;
            		//add new group to the array
            		_groupArray = _groupArray + [_newGroup];
            
            		//add waypoints
            		_waypoint = [_missionFileName, _groupName, "Waypoint1", "ARRAY"] call iniDB_read;
            		_waypointType = [_missionFileName, _groupName, "Waypoint1Type", "STRING"] call iniDB_read;
            		_kk = 2;
            		While {_waypointType!=""} do {
            			//waypoint setup
            			if (_kk>2 and _WaypointType=="AMBUSH") then
            			{
            				_trg = createTrigger ["EmptyDetector", _waypoint, true];
            				_trg setTriggerArea [100,100, 0, false];
            				_trg synchronizeTrigger [_wp];
            				_trg triggerAttachVehicle [_caller];
            				_trg setTriggerActivation ["GROUP","PRESENT",false];
            				_WaypointType = "SAD";
            			};
            			_wp = _newGroup addWaypoint[_waypoint,7];
            			if (_WaypointType=="WAIT") then
            			{
            				_WaypointType = "MOVE";
            				_wp setWaypointTimeout [300,300,300];
            			};
            			if (_WaypointType=="LIMITED") then
            			{
            				_WaypointType = "MOVE";
            				_wp setWaypointSpeed "LIMITED";
            			} else
            			{
            				_wp setWaypointSpeed "NORMAL";
            			};
            			if (_WaypointType=="HIDE") then
            			{
            				_WaypointType = "MOVE";
            				_wp setWaypointType _WaypointType;
            				_wp setWaypointTimeout [30,145,300];
            				_wp setWaypointBehaviour "STEALTH";
            				_wp setWaypointSpeed "LIMITED";
            				_wp setWaypointCombatMode "GREEN";
            				_wp setWaypointFormation "FILE";
            			}
            			else
            			{
            				_wp setWaypointBehaviour "SAFE";
            				_wp setWaypointCombatMode "YELLOW";
            				_wp setWaypointFormation "STAG COLUMN";
            				_wp setWaypointType _WaypointType;
            			};
            			//next waypoint setup
            			_iniWP = format["Waypoint%1",_kk];
            			_iniWPType = format["Waypoint%1Type",_kk];
            			_waypoint = [_missionFileName, _groupName, _iniWP, "ARRAY"] call iniDB_read;
            			_waypointType = [_missionFileName, _groupName, _iniWPType, "STRING"] call iniDB_read;
            			_kk = _kk + 1;
            			sleep 1;
            		};//end waypoint while
            		
            		//increment groups
            		_jj = _jj + 1;
            		_groupName = format["GROUP%1",_jj];
            		_Type = [_missionFileName, _groupName, "Type1", "STRING"] call iniDB_read;
            	};//end group while
		    }
			else
			{
				
		        //hint saying they are coming
		        [66,missionNamespace getVariable _NPCID] remoteExec ["Messages",_theGroup];
				sleep 3;
			};
		}forEach[0,1,2,4,5,6,7];
		//_jobCompleteCount _p
		
		/////////////////////////////////////////
		//mission trigger
		//_destination
		_newTrig = createTrigger ["EmptyDetector", _destination];
		_newTrig setTriggerArea[_radius,_radius,0,false];
		_newTrig2 = createTrigger ["EmptyDetector", _destination];
		_newTrig2 setTriggerArea[_radius,_radius,0,false];

		_newTrig setTriggerActivation["EAST","NOT PRESENT",false];
		_newTrig setTriggerStatements["this", "", ""];
		_newTrig2 setTriggerActivation["EAST","NOT PRESENT",false];
		_newTrig2 setTriggerStatements["true", "", ""];
		
		_NPC = player;
		_missionFileName = "PM9b0";
		_spawn3 = [_newTrig,_newTask,_newTrig2,_missionFileName,_theGroup,_NPC,_missionNumber,_newTask,_groupArray,_missionObjectList,_startTime] execVM "PersonalTaskEnd.sqf";

		/////////////////////////////////////////
	}
	else
	{//regular job type
		//intro vids
		_camTarget1 = getPos _caller;
		_camPos1 = _camTarget1 vectorAdd [0,20,5];
		_camTarget2 = PMLocations select _missionType select _missionLevel;
		_camPos2 = _camTarget2 vectorAdd [0,50,20];
		_camTarget3 = PMLootDropOffs select _missionType select _missionLevel;
		_camPos3 = _camTarget3 vectorAdd [0,20,20];
		_CI = [_camPos1,_camTarget1,_camPos2,_camTarget2,_camPos3,_camTarget3,_title,_missionFileName,_caller];
		if (local _caller) then
		{
			_CI execVM "JobIntros.sqf";
		}
		else
		{
			_CI remoteExec ["JobIntros",_caller];
		};
		
		sleep 0.2;
		
		_newTask = [_theGroup,_taskName,[_description,_title,_marker],_destination,TRUE,10,true,"target",false] call BIS_fnc_taskCreate;
		
		//create a marker
		_radius = PMRadii select _missionLevel;
		_Xpos = _destination select 0;
		_Ypos = _destination select 1;
		_markerstr = createMarker [_title,[_Xpos,_Ypos]];
		_markerstr setMarkerShape "ELLIPSE";
		_markerstr setMarkerColor "ColorYELLOW";
		_markerstr setMarkerSize [_radius,_radius];
		_markerstr setMarkerBrush "FDiagonal";
		_markerstr setMarkerText "Mission in Progress";

		_skill = (PMSkillArrays select _missionLevel);
//		+ (HGDifficulty*AddedDifficulty);
		_rankArray = PMRankArray select _missionLevel;
		_unitNumber = PMUnitNumbersArrays select _missionLevel;
		_ammo = PMAmmoArrays select _missionLevel;
		_radius = PMRadii select _missionLevel;
		_location = PMLocations select _missionType select _missionLevel;
		_side = PMSidesArray  select _missionType select _missionLevel;
		_loop = PMloopArray select _missionLevel;
		//_groupArray = [];

		for [{_i=0}, {_i<_loop}, {_i=_i+1}] do
		{
			_xPos = _location select 0;
			_yPos = _location select 1;
			_wayPos = [];
			
			_notLand = true;
			while {_notLand} do
			{
				_wayPos = [random[_xPos - 200,_xPos,_xPos + 200],random[_yPos - 200,_yPos,_yPos + 200],0];
				
				_notLand = (_wayPos isFlatEmpty [-1, -1, -1, -1, 0, false] isEqualTo []);
			};
			
			_unitArray = selectRandom (PMUnitArrays select _missionType select _missionLevel);
			_newGroup = grpNull;
			_newGroup = [_wayPos, _side, _unitArray, [], _rankArray, _skill, _ammo, _unitNumber] call BIS_fnc_spawnGroup;
			sleep 1;
			_newGroup setSpeedMode "LIMITED";
			_newGroup setBehaviour "CARELESS";
			_newGroup setFormation "FILE";

			_groupArray = _groupArray + [_newGroup];
			
			_notLand = true;
			while {_notLand} do
			{
				_wayPos = [random[_xPos - 100,_xPos,_xPos + 100],random[_yPos - 100,_yPos,_yPos + 100],0];
				
				_notLand = (_wayPos isFlatEmpty [-1, -1, -1, -1, 0, false] isEqualTo []);
			};
			
			_wp1 = _newGroup addWaypoint[_wayPos,0];
			_wp1 setWaypointType "LOAD";
			_wp1 setWaypointTimeout PMWaypointTimeout;
			
			_notLand = true;
			while {_notLand} do
			{
				_wayPos = [random[_xPos - 100,_xPos,_xPos + 100],random[_yPos - 100,_yPos,_yPos + 100],0];
				
				_notLand = (_wayPos isFlatEmpty [-1, -1, -1, -1, 0, false] isEqualTo []);
			};
			
			_wp2 = _newGroup addWaypoint[_wayPos,0];
			_wp2 setWaypointType "LOAD";
			_wp2 setWaypointTimeout PMWaypointTimeout;
			
			_notLand = true;
			while {_notLand} do
			{
				_wayPos = [random[_xPos - 100,_xPos,_xPos + 100],random[_yPos - 100,_yPos,_yPos + 100],0];
				
				_notLand = (_wayPos isFlatEmpty [-1, -1, -1, -1, 0, false] isEqualTo []);
			};
			
			_wp3 = _newGroup addWaypoint[_wayPos,0];
			_wp3 setWaypointType "LOAD";
			_wp3 setWaypointTimeout PMWaypointTimeout;
			
			_notLand = true;
			while {_notLand} do
			{
				_wayPos = [random[_xPos - 100,_xPos,_xPos + 100],random[_yPos - 100,_yPos,_yPos + 100],0];
				
				_notLand = (_wayPos isFlatEmpty [-1, -1, -1, -1, 0, false] isEqualTo []);
			};
			
			_wp4 = _newGroup addWaypoint[waypointPosition _wp1,0];
			_wp4 setWaypointType "CYCLE";
			_wp4 setWaypointTimeout PMWaypointTimeout;
		};
		
		//loot item
		_boxLetter = "";
		_location = PMLocations select _missionType select _missionLevel;
		_lootType = "";

		if (_missionType < 9 and _missionType > 5) then
		{
			_lootType = selectRandom (PMLootArrayVehicle select _missionType select _missionLevel select 1);
		};
		if (_missionType < 6) then
		{
			_lootType = "Box_IND_WpsSpecial_F";
		};
		_loot = createVehicle [_lootType, _location, [], 1, "NONE"];
		_loot lock true;
		
		clearWeaponCargoGlobal _loot;
		clearItemCargoGlobal _loot;
		clearBackpackCargoGlobal _loot;
		clearMagazineCargoGlobal _loot;

		//PM addActions
		[_missionType,_missionLevel,_loot,_caller] remoteExec ["PMLocalSetup1", _caller];
	};
	_allDone = 0;
	while {_allDone==0} do
	{
		sleep 30;
		
		//check caller still connected
		_allDone = 1;
		{
			if (name _x == _name) then
			{
				_allDone = 0;
			};
		}forEach allUnits;
		
		//if the leader isnt the caller or there are no units on the mission
		if ((str _caller != str (leader _theGroup)) or ((count units _theGroup) == 0)) then
		{
			_allDone = 1;
		};
		
		//if loot has been destroyed
		if (_missionType < 9 and _missionType > 5) then
		{
			if not(alive _loot) then
			{
				_allDone = 1;
			};
		};
		
		//check if forcibly cancelled
		_Mission0 = ["MissionsInProgress", "MISSIONS", "Mission0", "STRING"] call iniDB_read;
		_Mission1 = ["MissionsInProgress", "MISSIONS", "Mission1", "STRING"] call iniDB_read;
		_Mission2 = ["MissionsInProgress", "MISSIONS", "Mission2", "STRING"] call iniDB_read;
		_Mission3 = ["MissionsInProgress", "MISSIONS", "Mission3", "STRING"] call iniDB_read;
		_Mission4 = ["MissionsInProgress", "MISSIONS", "Mission4", "STRING"] call iniDB_read;
		_Mission5 = ["MissionsInProgress", "MISSIONS", "Mission5", "STRING"] call iniDB_read;
		_Mission6 = ["MissionsInProgress", "MISSIONS", "Mission6", "STRING"] call iniDB_read;
		
		//forced ending by deleting MIP ID
		if not (_Mission0 == _missionFileName or _Mission1 == _missionFileName or _Mission2 == _missionFileName or _Mission3 == _missionFileName or _Mission4 == _missionFileName or _Mission5 == _missionFileName or _Mission6 == _missionFileName) then
		{
			_allDone = 2;
		};
	};
	[_missionFileName,_theGroup,_caller,_missionLevel,_newTask,_groupArray,[],"Canceled"] execVM "JobFinished.sqf";
	deleteMarker _title;
};//end if _isInProgress