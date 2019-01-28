//LoadTask.sqf
//Runs on server
//Called by server on player request
//Called from GUI loadmission action or LodTask PVEH
//Builds NPC missions from .ini files

//pvs
private ["_NPC", "_missionNumber", "_caller", "_theGroup", "_spawn2", "_spawn3", "_spawn4", "_missionFileName", "_ret", "_Mission0", "_Mission1", "_Mission2", "_Mission3", "_Mission4", "_Mission5", "_Mission6", "_isInProgress", "_MIPWritten", "_MIPNumber", "_MIPUIP", "_starter", "_getUID", "_description", "_title", "_typeOfMission", "_taskIcon", "_destination", "_camTarget1", "_camTarget2", "_camTarget3", "_camPos1", "_camPos2", "_camPos3", "_startTime", "_newTask", "_jj", "_groupArray", "_groupName", "_Type", "_ii", "_unitArray", "_Position", "_Side", "_Azimuth", "_relativeArray", "_unit", "_iniType", "_Coord", "_newGroup", "_skill", "_waypoint", "_waypointType", "_kk", "_WaypointType", "_trg", "_wp", "_iniWP", "_iniWPType", "_radius", "_markerstr", "_qq", "_missionObject", "_missionObjectList", "_missionGroupName", "_missionType", "_NPCWeapons", "_NPCAmmo", "_NPCItems", "_NPCBackpacks", "_NPCUniform", "_NPCVest", "_boxString", "_missionPosition", "_missionAzimuth", "_nul", "_mg", "_nt", "_win", "_exit", "_location2", "_building", "_missionSide", "_missionObject0", "_missionGroup", "_enemyIs", "_newTrig", "_newTrig2", "_state", "_state2", "_TCRadius", "_TCPosition", "_Xpos", "_Ypos", "_markerDropOff", "_markerDropOffWords", "_mPosition", "_mType", "_van", "_dist", "_car", "_carObject", "_allDone", "_check1", "_aiLeader", "_taskState","_uid"];

_NPC = _this select 0;
_missionNumber = _this select 1;
_caller = _this select 2;

//other inits
_theGroup = group _caller;
_spawn2 = 0 spawn {};
_spawn3 = 0 spawn {};
_spawn4 = 0 spawn {};
_missionNumber = _missionNumber - 1;
_missionFileName = format["%1b%2",_NPC,_missionNumber];
_uid = getPlayerUID _caller;

//write player ID to MIP file
_ret = ["MissionsInProgress", "UID", _missionFileName, _uid] call iniDB_write;

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
		{
			[32,_starter] remoteExec ["Messages",_caller];
		};
	}
	else
	{
		[33,nil] remoteExec ["Messages",_caller];
	};
}
else // MAIN TASK LOADING CODE
{
	_startTime = time;
	
	//get taskCreate info
	_description = [_missionFileName, "CREATETASK", "description", "STRING"] call iniDB_read;
	_title = [_missionFileName, "CREATETASK", "title", "STRING"] call iniDB_read;
	_typeOfMission = [_missionFileName, "CREATETASK", "TypeOfMission", "STRING"] call iniDB_read;
	_taskIcon = [_missionFileName, "CREATETASK", "TaskIcon", "STRING"] call iniDB_read;
	
	_destination = getMarkerPos ("ZX" + str _NPC + "_" + str _missionNumber);
	_camTarget1 = getPos _caller;
	_camTarget2 = _destination;
	_camTarget3 = _destination;
	_camPos1 = _camTarget1 vectorAdd [0,40,25];
	_camPos2 = _destination vectorAdd [25,25,20];
	_camPos3 = _destination vectorAdd [-100,-100,50];
	
	if (_typeOfMission=="TRANSPORT") then
	{
    	_camTarget2 = [_missionFileName, "ESCORTOBJECT", "Position", "ARRAY"] call iniDB_read;
    	_camTarget3 = [_missionFileName, "ESCORTOBJECT", "TCPosition", "ARRAY"] call iniDB_read;
    	_camPos2 = _camTarget2 vectorAdd [25,25,20];
    	_camPos3 = _camTarget3 vectorAdd [-100,-100,50];
	};
	
	if (_typeOfMission=="ASSASSINATE") then
	{
    	_camTarget2 = [_missionFileName, "KILLOBJECT", "Position", "ARRAY"] call iniDB_read;
    	_camTarget3 = _camTarget2;
    	_camPos2 = _camTarget2 vectorAdd [25,25,20];
    	_camPos3 = _camTarget3 vectorAdd [-100,-100,50];
	};
	
	//check for a mission object
	_qq = 1;
	_missionObject = objNull;
	_missionObjectList = [];
	_missionGroupName = "MISSIONOBJECT1";
	_missionType = [_missionFileName, _missionGroupName, "Type", "STRING"] call iniDB_read;
	
	//check for and create each mission object
	while {_missionType!=""} do
	{
		//load object info
		_missionPosition = [_missionFileName, _missionGroupName, "Position", "ARRAY"] call iniDB_read;
		_missionAzimuth = [_missionFileName, _missionGroupName, "Azimuth", "SCALAR"] call iniDB_read;
		_missionType = [_missionFileName, _missionGroupName, "Type", "STRING"] call iniDB_read;
		
		//hg unts
		_missionType = [_missionFileName, _missionGroupName, "Type", "STRING"] call iniDB_read;
		_missionType = missionNamespace getVariable _missionType;
		if (isNil "_missionType") then
		{
			_missionType = [_missionFileName, _missionGroupName, "Type", "STRING"] call iniDB_read;
		};
		
		//create object
		_missionObject setDir _missionAzimuth;
		_missionObject setFormDir _missionAzimuth;
		_missionObject = createVehicle [_missionType,_missionPosition,[],0,"FLY"];
		_missionObject setDir _missionAzimuth;
		_missionObject setFormDir _missionAzimuth;
		
		//add to list
		_missionObjectList = _missionObjectList + [_missionObject];
		
		//increment groups
		_qq = _qq + 1;
		_missionGroupName = format["MISSIONOBJECT%1",_qq];
		_missionType = [_missionFileName, _missionGroupName, "Type", "STRING"] call iniDB_read;
		_missionType = missionNamespace getVariable _missionType;
		if (isNil "_missionType") then
		{
			_missionType = [_missionFileName, _missionGroupName, "Type", "STRING"] call iniDB_read;
		};
	};//end group while
	
	//add groups
	_jj = 1;
	_groupArray = [];
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
			case "CIV":
			{
				_newGroup = [_Position, CIVILIAN, _unitArray, _relativeArray,[],_skill,[],[],_Azimuth] call BIS_fnc_spawnGroup;
				{
					_x allowFleeing 0;
					_x setUnloadInCombat [false,false];
					_x setVariable["type",floor (random 6),true];
					_x setVariable["rank",floor (random 10),true];
					_x setVariable["town","town1",true];
				}forEach units _newGroup;
			};
		};
		sleep 0.2;
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
			sleep 0.2;
		};//end waypoint while
		
		//increment groups
		_jj = _jj + 1;
		_groupName = format["GROUP%1",_jj];
		_Type = [_missionFileName, _groupName, "Type1", "STRING"] call iniDB_read;
	};//end group while

    //create task
	_newTask = [_theGroup,_missionFileName,[_description,_title,""],_destination,TRUE,10,True,_taskIcon,false] call BIS_fnc_taskCreate;
	
	//start job intro video
	[_camPos1,_camTarget1,_camPos2,_camTarget2,_camPos3,_camTarget3,_title,_missionFileName,_NPC,_missionNumber] remoteExec ["JobIntros",_caller];
	
	//create a marker
	_radius = [_missionFileName, "CREATETASK", "Radius", "SCALAR"] call iniDB_read;
	_markerstr = createMarker [_title,_destination];
	_markerstr setMarkerShape "ELLIPSE";
	_markerstr setMarkerColor "ColorYELLOW";
	_markerstr setMarkerSize [_radius,_radius];
	_markerstr setMarkerBrush "FDiagonal";

	//get items for NPC crates and send to player
	_NPCWeapons = [_missionFileName, "GEAR", "Weapons", "ARRAY"] call iniDB_read;
	_NPCAmmo = [_missionFileName, "GEAR", "Ammo", "ARRAY"] call iniDB_read;
	_NPCItems = [_missionFileName, "GEAR", "Items", "ARRAY"] call iniDB_read;
	_NPCBackpacks = [_missionFileName, "GEAR", "Backpack", "ARRAY"] call iniDB_read;
	_NPCUniform = [_missionFileName, "GEAR", "Uniform", "ARRAY"] call iniDB_read;
	_NPCVest = [_missionFileName, "GEAR", "Vest", "ARRAY"] call iniDB_read;
	_boxString = ("W" + (str _NPC select [3,1]));
	[_NPCWeapons,_NPCAmmo,_NPCItems,_NPCBackpacks,_NPCUniform,_NPCVest,_boxString] remoteExec ["MissionGear", _caller];
	
	//extra crates for mods
	if ((paramsArray select 3)>0) then
	{
    	_nul = createVehicle [NPC0Crate,getPos NPC0,[],0.5,"FLY"];
    	_nul = createVehicle [NPC1Crate,getPos NPC1,[],0.5,"FLY"];
    	_nul = createVehicle [NPC2Crate,getPos NPC2,[],0.5,"FLY"];
    	_nul = createVehicle [NPC3Crate,getPos NPC3,[],0.5,"FLY"];
    	_nul = createVehicle [NPC4Crate,getPos NPC4,[],0.5,"FLY"];
    	_nul = createVehicle [NPC5Crate,getPos NPC5,[],0.5,"FLY"];
    	_nul = createVehicle [NPC6Crate,getPos NPC6,[],0.5,"FLY"];
    	_nul = createVehicle [NPC7Crate,getPos NPC7,[],0.5,"FLY"];
    	_nul = createVehicle [NPC8Crate,getPos NPC8,[],0.5,"FLY"];
    	_nul = createVehicle [NPC9Crate,getPos NPC9,[],0.5,"FLY"];
    };
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	//types of mission: DESTROY, KILL, ESCORT, ASS1
	switch (_typeOfMission) do
	{
		case "DEMOLITION":
		{
			_spawn2 = [_missionObject,_newTask,_newTask,_missionFileName,_theGroup,_NPC,_missionNumber,_newTask,_groupArray,_missionObjectList,_startTime] execVM "DEMOLITIONEnd.sqf";
		};
		
		case "WIPEOUT":
		{
			//_destination
			_radius = [_missionFileName, "CREATETASK", "Radius", "SCALAR"] call iniDB_read;
			_enemyIs = [_missionFileName, "CREATETASK", "Enemy", "STRING"] call iniDB_read;
			_newTrig = createTrigger ["EmptyDetector", _destination];
			_newTrig setTriggerArea[_radius,_radius,0,false];
			_newTrig2 = createTrigger ["EmptyDetector", _destination];
			_newTrig2 setTriggerArea[_radius,_radius,0,false];
			
			switch (_enemyIs) do
			{
				case "":
				{
					_newTrig setTriggerActivation["EAST","NOT PRESENT",false];
					_newTrig setTriggerStatements["this", "", ""];
					_newTrig2 setTriggerActivation["EAST","NOT PRESENT",false];
					_newTrig2 setTriggerStatements["true", "", ""];
				};
				case "EE":
				{
					_newTrig setTriggerActivation["EAST","NOT PRESENT",false];
					_newTrig setTriggerStatements["this", "", ""];
					_newTrig2 setTriggerActivation["EAST","NOT PRESENT",false];
					_newTrig2 setTriggerStatements["true", "", ""];
				};
				case "EC":
				{
					_newTrig2 setTriggerActivation["CIV","NOT PRESENT",false];
					_newTrig2 setTriggerStatements["this", "", ""];
					_newTrig setTriggerActivation["EAST","NOT PRESENT",false];
					_newTrig setTriggerStatements["this", "", ""];
				};
				case "WW":
				{
					_newTrig setTriggerActivation["WEST","NOT PRESENT",false];
					_newTrig setTriggerStatements["this", "", ""];
					_newTrig2 setTriggerActivation["EAST","NOT PRESENT",false];
					_newTrig2 setTriggerStatements["true", "", ""];
				};
				case "EW":
				{
					_newTrig setTriggerActivation["WEST","NOT PRESENT",false];
					_newTrig setTriggerStatements["this", "", ""];
					_newTrig2 setTriggerActivation["EAST","NOT PRESENT",false];
					_newTrig2 setTriggerStatements["this", "", ""];
				};
				case "WC":
				{
					_newTrig2 setTriggerActivation["CIV","NOT PRESENT",false];
					_newTrig2 setTriggerStatements["this", "", ""];
					_newTrig setTriggerActivation["WEST","NOT PRESENT",false];
					_newTrig setTriggerStatements["this", "", ""];
				};
				case "CC":
				{
					_newTrig setTriggerActivation["CIV","NOT PRESENT",false];
					_newTrig setTriggerStatements["this", "", ""];
					_newTrig2 setTriggerActivation["EAST","NOT PRESENT",false];
					_newTrig2 setTriggerStatements["true", "", ""];
				};
			};
			
			
			

			_spawn3 = [_newTrig,_newTask,_newTrig2,_missionFileName,_theGroup,_NPC,_missionNumber,_newTask,_groupArray,_missionObjectList,_startTime] execVM "WIPEOUTEnd.sqf";
		};
		case "ASSASSINATE":
		{
			//add Kill object
			//load object info
			_missionGroupName = "KILLOBJECT";
			_missionPosition = [_missionFileName, _missionGroupName, "Position", "ARRAY"] call iniDB_read;
			_missionSide = [_missionFileName, _missionGroupName, "Side", "STRING"] call iniDB_read;
			_missionAzimuth = [_missionFileName, _missionGroupName, "Azimuth", "SCALAR"] call iniDB_read;
			_missionType = [_missionFileName, _missionGroupName, "Type", "STRING"] call iniDB_read;
			_missionType = missionNamespace getVariable _missionType;
			if (isNil "_missionType") then
			{
				_missionType = [_missionFileName, _missionGroupName, "Type", "STRING"] call iniDB_read;
			};
			
			//create object
			_missionObject0 = objNull;
			_missionObject0 setDir _missionAzimuth;
			_missionGroup = grpNull;
			switch (_missionSide) do
			{
				case "WEST":
				{
					_missionGroup = createGroup WEST;
					_missionObject0 = _missionGroup createUnit [_missionType,_missionPosition, [], 0, "FORM"];
				};
				case "EAST":
				{
					//_missionGroup = createGroup EAST;
					//_missionGroup = [_missionPosition, EAST, [_missionType],[[0,0,0]],[],[0.1,0.1],[],[],_missionAzimuth] call BIS_fnc_spawnGroup;
					
					_missionGroup = createGroup EAST;
					_missionObject0 = _missionGroup createUnit [_missionType,_missionPosition, [], 0, "FORM"];
				};
				case "GUER":
				{
					_missionGroup = createGroup INDEPENDENT;
					_missionObject0 = _missionGroup createUnit [_missionType,_missionPosition, [], 0, "FORM"];
				};
				case "CIV":
				{
					_missionGroup = createGroup CIVILIAN;
					_missionObject0 = _missionGroup createUnit [_missionType,_missionPosition, [], 0, "FORM"];
				};
				case "":
				{
					_missionObject0 = createVehicle [_missionType,_missionPosition,[],0,"CAN_COLLIDE"];
				};
			};
			
			_missionObject0 setDir _missionAzimuth;
			_missionObject0 setFormDir _missionAzimuth;
			
			if (_missionSide == "") then
			{
				 _missionObject = _missionObject0;
			}
			else
			{
				_missionObject = vehicle (leader _missionGroup);
				_missionObjectList = _missionObjectList + (units _missionGroup);
				_missionObject allowFleeing 0;
			};
			
			//new task destination
			[_newTask,[_missionObject,true]] call BIS_fnc_taskSetDestination;
			
			//add waypoints
			_waypoint = [_missionFileName, _missionGroupName, "Waypoint1", "ARRAY"] call iniDB_read;
			_waypointType = [_missionFileName, _missionGroupName, "Waypoint1Type", "STRING"] call iniDB_read;
			_kk = 2;
			While {_waypointType!=""} do
			{
				_wp = _missionGroup addWaypoint[_waypoint,7];
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
				_wp setWaypointBehaviour "SAFE";
				_wp setWaypointCombatMode "YELLOW";
				_wp setWaypointFormation "STAG COLUMN";
				_wp setWaypointType _WaypointType;
				_iniWP = format["Waypoint%1",_kk];
				_iniWPType = format["Waypoint%1Type",_kk];
				_waypoint = [_missionFileName, _missionGroupName, _iniWP, "ARRAY"] call iniDB_read;
				_waypointType = [_missionFileName, _missionGroupName, _iniWPType, "STRING"] call iniDB_read;
				_kk = _kk + 1;
			};//end waypoint while
			//remove mission Objects
			//mg=_missionObject;
			
			_spawn2 = [_missionObject,_newTask,_newTask,_missionFileName,_theGroup,_NPC,_missionNumber,_newTask,_groupArray,_missionObjectList,_startTime] execVM "ASSASSINATEEnd.sqf";
		};
		
		case "TRANSPORT":
		{
			//load object info
			_missionGroupName = "ESCORTOBJECT";
			_missionPosition = [_missionFileName, _missionGroupName, "Position", "ARRAY"] call iniDB_read;
			_missionSide = [_missionFileName, _missionGroupName, "Side", "STRING"] call iniDB_read;
			_missionAzimuth = [_missionFileName, _missionGroupName, "Azimuth", "SCALAR"] call iniDB_read;
			_missionType = [_missionFileName, _missionGroupName, "Type", "STRING"] call iniDB_read;
			_missionType = missionNamespace getVariable _missionType;
			if (isNil "_missionType") then
			{
				_missionType = [_missionFileName, _missionGroupName, "Type", "STRING"] call iniDB_read;
			};
			
			//create object
			_missionObject = objNull;
			_missionObject setDir _missionAzimuth;
			switch (_missionSide) do
			{
				case "WEST":
				{
					_missionGroup = createGroup WEST;
					_missionObject = _missionGroup createUnit [_missionType,_missionPosition, [], 0, "FORM"];
					_missionGroup allowFleeing 0;
					_missionObject setUnloadInCombat [false,false];
				};
				case "EAST":
				{
					_missionGroup = createGroup EAST;
					_missionObject = _missionGroup createUnit [_missionType,_missionPosition, [], 0, "FORM"];
					_missionGroup allowFleeing 0;
					_missionObject setUnloadInCombat [false,false];
				};
				case "GUER":
				{
					_missionGroup = createGroup INDEPENDENT;
					_missionObject = _missionGroup createUnit [_missionType,_missionPosition, [], 0, "FORM"];
					_missionGroup allowFleeing 0;
					_missionObject setUnloadInCombat [false,false];
				};
				case "CIV":
				{
					_missionGroup = createGroup CIVILIAN;
					_missionObject = _missionGroup createUnit [_missionType,_missionPosition, [], 0, "FORM"];
					_missionGroup allowFleeing 0;
					_missionObject setUnloadInCombat [false,false];
				};
				case "":
				{
					_missionObject = createVehicle [_missionType,_missionPosition,[],0,"NONE"];
				};
			};
			
			_missionObject setDir _missionAzimuth;
			_missionObject = vehicle _missionObject;
			_missionObjectList = _missionObjectList + [_missionObject];
			
			//_destination
			//deleteVehicle _newTrig;
			_TCRadius = [_missionFileName, "ESCORTOBJECT", "TCRadius", "SCALAR"] call iniDB_read;
			_TCPosition = [_missionFileName, "ESCORTOBJECT", "TCPosition", "ARRAY"] call iniDB_read;
			_newTrig = createTrigger ["EmptyDetector", _TCPosition];
			_newTrig setTriggerArea[_TCRadius,_TCRadius,0,false,8];
			_newTrig setTriggerActivation["VEHICLE","PRESENT",false];
			_newTrig setTriggerStatements["this", "", ""];
			_newTrig triggerAttachVehicle [_missionObject];
			
			//new task destination
			[_newTask,[_missionObject,true]] call BIS_fnc_taskSetDestination;
			
			//add waypoints
			_waypoint = [_missionFileName, "ESCORTOBJECT", "Waypoint1", "ARRAY"] call iniDB_read;
			_waypointType = [_missionFileName, "ESCORTOBJECT", "Waypoint1Type", "STRING"] call iniDB_read;
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
				_wp = _missionGroup addWaypoint[_waypoint,7];
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
				_waypoint = [_missionFileName, "ESCORTOBJECT", _iniWP, "ARRAY"] call iniDB_read;
				_waypointType = [_missionFileName, "ESCORTOBJECT", _iniWPType, "STRING"] call iniDB_read;
				_kk = _kk + 1;
				sleep 0.2;
			};//end waypoint while
			
			//create a marker
			_Xpos = _TCPosition select 0;
			_Ypos = _TCPosition select 1;
			_markerDropOff = createMarker ["DropOff"+_missionFileName,[_Xpos,_Ypos]];
			_markerDropOff setMarkerShape "ELLIPSE";
			_markerDropOff setMarkerColor "ColorOrange";
			_markerDropOff setMarkerSize [_TCRadius,_TCRadius];
			_markerDropOff setMarkerBrush "Horizontal";
			_markerDropOff setMarkerText "Drop Off";
			
			//words
			_markerDropOffWords = createMarker ["DropOffWords"+_missionFileName,[_Xpos,_Ypos]];
			_markerDropOffWords setMarkerShape "ICON";
			_markerDropOffWords setMarkerText "Drop Off";
			_markerDropOffWords setMarkerType "mil_marker";
			_markerDropOffWords setMarkerColor "ColorBlack";
			
			
			_spawn4 = [_newTrig,_newTask,_missionObject,_missionFileName,_theGroup,_NPC,_missionNumber,_newTask,_groupArray,_missionObjectList,_startTime] execVM "TRANSPORTEnd.sqf";
		};
		case "MOVEANDDESTROY":
		{
			//add Kill object
			//load object info
			_missionGroupName = "KILLOBJECT";
			_missionPosition = [_missionFileName, _missionGroupName, "Position", "ARRAY"] call iniDB_read;
			_missionSide = [_missionFileName, _missionGroupName, "Side", "STRING"] call iniDB_read;
			_missionAzimuth = [_missionFileName, _missionGroupName, "Azimuth", "SCALAR"] call iniDB_read;
			_missionType = [_missionFileName, _missionGroupName, "Type", "STRING"] call iniDB_read;
			_missionType = missionNamespace getVariable _missionType;
			if (isNil "_missionType") then
			{
				_missionType = [_missionFileName, _missionGroupName, "Type", "STRING"] call iniDB_read;
			};
			
			//create object
			_missionObject = objNull;
			_missionObject setDir _missionAzimuth;
			
			switch (_missionSide) do
			{
				case "WEST":
				{
					_missionGroup = createGroup WEST;
					_missionObject = _missionGroup createUnit [_missionType,_missionPosition, [], 0, "FORM"];
					_missionObject setSkill (_skill select 0);
				};
				case "EAST":
				{
					_missionGroup = createGroup EAST;
					_missionObject = _missionGroup createUnit [_missionType,_missionPosition, [], 0, "FORM"];
					_missionObject setSkill (_skill select 0);
				};
				case "GUER":
				{
					_missionGroup = createGroup independent;
					_missionObject = _missionGroup createUnit [_missionType,_missionPosition, [], 0, "FORM"];
					_missionObject setSkill (_skill select 0);
				};
				case "CIV":
				{
					_missionGroup = createGroup civilian;
					_missionObject = _missionGroup createUnit [_missionType,_missionPosition, [], 0, "FORM"];
					_missionObject setSkill (_skill select 0);
				};
				case "":
				{
					_missionObject = createVehicle [_missionType,_missionPosition,[],0,"CAN_COLLIDE"];
				};
			};
			_missionObject setPosATL _missionPosition;
			
			
			_missionObjectList = _missionObjectList + [_missionObject];
			
			
			_mPosition = [_missionFileName, "ASSOBJECT", "Position", "ARRAY"] call iniDB_read;
			_mType = [_missionFileName, "ASSOBJECT", "Type", "STRING"] call iniDB_read;
			_van = createVehicle [_mType,_mPosition,[],0,"FORM"];
			
			
			
			_missionObject setDir _missionAzimuth;
			
			_missionObjectList = _missionObjectList + [_missionObject];
			
			_spawn2 = [_destination,_newTask,_van,_missionFileName,_theGroup,_NPC,_missionNumber,_newTask,_groupArray,_missionObjectList,_startTime] execVM "MOVEANDDESTROYEnd.sqf";
			
			//remove mission Objects
			//mg=_missionObject;
		};
	};
	
	//spawn mission vehicle
	_car = [_missionFileName, "CAR", "Car", "STRING"] call iniDB_read;
	_car = missionNamespace getVariable _car;
	if (isNil "_car") then
	{
		_car = [_missionFileName, "CAR", "Car", "STRING"] call iniDB_read;
	};
	sleep 0.2;
	_carObject = createVehicle [_car,getMarkerPos ("r" + ((str _NPC) select [3,1])),[],2,"NONE"];
	sleep 1;
	_caller action ["getInDriver",_carObject];
	
	//inform mission loaded
	[34,[str (_missionNumber+1),name _NPC]] remoteExec ["Messages",_caller];
	
	//called ending checker
	[_theGroup,_missionFileName,_newTask,_NPC,_missionNumber,_groupArray,_missionObjectList,_title,_spawn2,_spawn3,_spawn4] execVM "LoadTaskEnd.sqf";
};//end if _isInProgress