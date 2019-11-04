//hint "Serversave";
params [["_clientID",-2,[0]],["_saveName","",[""]],["_hiddenCheck",false,[false]],["_serverTriggerCheck",false,[false]]];
private ["_allMissionObjectsAll", "_allMissionObjectsAir", "_allMissionObjectsCar", "_allMissionObjectsBoat", "_allMissionObjectsBuilding", "_allMissionObjectsTrigger", "_allMissionObjectsTaskStates", "_allMissionObjectsTasks", "_allMissionObjectsLogic", "_allUnitsOnTheBus", "_allUnitsNotOnTheBus", "_allBadGroups", "_allGoodGroups", "_inidbi", "_inidbiSAVELIST", "_dateTime", "_dateTimeString", "_allSaves", "_newSaveNumber", "_hiddenObjects", "_placedObjects", "_airNum", "_allVars", "_object", "_carNum", "_boatNum", "_buildingNum", "_unitNum", "_soldier", "_groupID", "_waypointNum", "_syncWPs", "_wpNum", "_triggerNum", "_syncs", "_cat", "_dog", "_TAV", "_markerNum", "_tasks", "_task", "_taskNum", "_taskObj", "_taskStateModule", "_triggerStr", "_logicNum", "_units"];
MSLPROGRESS = 0;
publicVariable "MSLPROGRESS";

//use actionParams and actionIDs to get all player addActions
//all unit carrying objects and clothes
//triggers and syncs/links
//waypoints
//item containers
//running scripts
//all objects and vehicles
//map markers
//tasks
//groupings
//animals
//mass
//player ratings
//briefings
//buildings
//libraryDisclaimers
//deadUnits
//lifeState
//knowsAbout
//infoPanels
//getMass
//getPlateNumber
//set friend/foes
//getAllHitPointsDamage 
//getFatigue
//getDir
//isStaminaEnabled 
//getDammage
//allCurators
//fuel
//formation
//allDeadMen
//allDisplays
//allControls
//allSites
//allVariables 
//flying
//face/identities
//toString diag_activeSQFScripts
//dynamicSimulationEnabled
//simulationEnabled
//locations
//teams
//attachedObjects
//attackEnabled
//assign roles
//allsimpleobjects

_allMissionObjectsAll = allMissionObjects "all";
_allMissionObjectsAir = allMissionObjects "air";
_allMissionObjectsCar = (allMissionObjects "LandVehicle") - MSLBUSES;
_allMissionObjectsBoat = allMissionObjects "Ship";
_allMissionObjectsBuilding = allMissionObjects "Building";
_allMissionObjectsTrigger = allMissionObjects "emptyDetector";
_allMissionObjectsTaskStates = allMissionObjects "ModuleTaskSetState_F";
_allMissionObjectsTasks = allMissionObjects "ModuleTaskCreate_F";
_allMissionObjectsLogic = allMissionObjects "Logic";
_allUnitsOnTheBus = [];
_allGroupsOnTheBus = [];
{
	if ((vehicle _x) in MSLBUSES) then {
		_allUnitsOnTheBus append [_x];
		_allGroupsOnTheBus pushBackUnique (group _x);
	};
} forEach allUnits;
_allUnitsNotOnTheBus = allUnits - _allUnitsOnTheBus;

_allBadGroups = [];
{
	if ((count(units(_x))<1) or ((vehicle((units _x) select 0)) in MSLBUSES)) then {
		_allBadGroups append [_x];
	};
} forEach allGroups;
_allGoodGroups = (allGroups - _allBadGroups) - _allGroupsOnTheBus;
//remove tags
{
	_x setVariable ["MSLID", nil];
} forEach _allMissionObjectsAll;


MSLPROGRESS = 0.05;
publicVariable "MSLPROGRESS";

//if (!("exists" call _inidbi)) then {};
_inidbiSAVELIST = ["new", "SAVELIST"] call OO_INIDBI;

_dateTime = "getTimeStamp" call _inidbiSAVELIST;
_dateTimeString = str _dateTime;
_allSaves = [];

if ("exists" call _inidbiSAVELIST) then {
	_allSaves = "getSections" call _inidbiSAVELIST;
};

_newSaveNumber = "0";
if (isNil "_allSaves") then {_allSaves = []};
if (count _allSaves > 0) then {
	_newSaveNumber = str ((parseNumber (_allSaves select ((count _allSaves) - 1))) + 1);
};
if (_saveName == "" or ("exists" call (["new", _saveName] call OO_INIDBI))) then
{
	_saveName = worldName + "_" + missionName + "_(" +
	str(_dateTime select 2) + "." + str (_dateTime select 1) + "." + str (_dateTime select 0) + "_" + str(_dateTime select 3) +"." + str(_dateTime select 4) + "." + str(_dateTime select 5) + ")" ;
};

["write", [_newSaveNumber, "Filename", _saveName]] call _inidbiSAVELIST;



["delete", _inidbiSAVELIST] call OO_INIDBI;


//_dateTimeString = "real_date" callExtension "+";
//_dateTime = parseSimpleArray (_dateTimeString);

//_dateTime = "getTimeStamp" call _inidbi;

_inidbi = ["new", _saveName] call OO_INIDBI;
	

//missionNamespace
_allVars = [];
{
	if (typeName (missionNamespace getVariable[_x,[]]) in ["SCALAR","STRING","BOOL","TEXT"]) then {
		_allVars append [[_x,missionNamespace getVariable[_x,""]]];
	};
} forEach (allVariables missionNamespace);
["write", ["MISSIONNAMESPACE", "allVars", _allVars]] call _inidbi;
//hint (str _allVars);


MSLPROGRESS = 0.1;
publicVariable "MSLPROGRESS";
//MISSIONDETAILS 
["write", ["MISSIONDETAILS", "worldName", worldName]] call _inidbi;
["write", ["MISSIONDETAILS", "missionName", missionName]] call _inidbi;
["write", ["MISSIONDETAILS", "Date", _dateTimeString]] call _inidbi;
["write", ["MISSIONDETAILS", "accTime", accTime]] call _inidbi;
["write", ["MISSIONDETAILS", "date", date]] call _inidbi;
["write", ["MISSIONDETAILS", "timeMultiplier", timeMultiplier]] call _inidbi;
["write", ["MISSIONDETAILS", "wind", wind]] call _inidbi;
["write", ["MISSIONDETAILS", "waves", waves]] call _inidbi;
["write", ["MISSIONDETAILS", "viewDistance", viewDistance]] call _inidbi;
["write", ["MISSIONDETAILS", "rainbow", rainbow]] call _inidbi;
["write", ["MISSIONDETAILS", "lightnings", lightnings]] call _inidbi;
["write", ["MISSIONDETAILS", "fog", fog]] call _inidbi;
//["write", ["MISSIONDETAILS", "fogForecast", fogForecast]] call _inidbi;
["write", ["MISSIONDETAILS", "nextWeatherChange", nextWeatherChange]] call _inidbi;
["write", ["MISSIONDETAILS", "overcast", overcast]] call _inidbi;
["write", ["MISSIONDETAILS", "rain", rain]] call _inidbi;
//["write", ["MISSIONDETAILS", "humidity", humidity]] call _inidbi;
["write", ["MISSIONDETAILS", "gusts", gusts]] call _inidbi;
["write", ["MISSIONDETAILS", "getMissionDLCs", getMissionDLCs]] call _inidbi;
["write", ["MISSIONDETAILS", "westgetFriendeast", west getFriend east]] call _inidbi;
["write", ["MISSIONDETAILS", "westgetFriendindependent", west getFriend independent]] call _inidbi;
["write", ["MISSIONDETAILS", "westgetFriendcivilian", west getFriend civilian]] call _inidbi;
["write", ["MISSIONDETAILS", "eastgetFriendindependent", east getFriend independent]] call _inidbi;
["write", ["MISSIONDETAILS", "eastgetFriendcivilian", east getFriend civilian]] call _inidbi;
["write", ["MISSIONDETAILS", "independentgetFriendcivilian", independent getFriend civilian]] call _inidbi;
["write", ["MISSIONDETAILS", "toStringdiag_activeSQFScripts", diag_activeSQFScripts]] call _inidbi;
["write", ["MISSIONDETAILS", "environmentEnabled", toString environmentEnabled]] call _inidbi;
["write", ["MISSIONDETAILS", "isStressDamageEnabled", isStressDamageEnabled]] call _inidbi;
//["write", ["MISSIONDETAILS", "cadetMode", cadetMode]] call _inidbi;


MSLPROGRESS = 0.2;
publicVariable "MSLPROGRESS";


//hidden buildings
_hiddenObjects = [];
if (_hiddenCheck) then {
	{
		//placed objects
		// if !(_x in nearestTerrainObjects[_x, [],0.1,false,true]) then
		// {_placedObjects pushBack _x;};
		//hidden map objects
		if (isObjectHidden _x)  then {
			_hiddenObjects pushBack _x;
		}
	}forEach (nearestObjects [[worldSize/2, worldSize/2], ["Building"], worldSize*2, false,true]);
	{
		["write", ["HIDDEN" + (str _forEachIndex), "typeOf" , (typeOf _x)]] call _inidbi;
		["write", ["HIDDEN" + (str _forEachIndex), "position" , toString (getPos _x)]] call _inidbi;
	}forEach _hiddenObjects;
};


//air
{
	_airNum = "AIR" + str _forEachIndex;
	["write", [_airNum, "typeOf" , typeOf _x]] call _inidbi;
	["write", [_airNum, "position" , toString (getPos _x)]] call _inidbi;
	["write", [_airNum, "special" , 
		["FORM","FLY"] select (((getPos _x) select 2)>5)
	]] call _inidbi;

	//vehicleVarName setVehicleVarName - do on all machines
	["write", [_airNum, "vehicleVarName", (vehicleVarName _x)]] call _inidbi;
	//vectorDir  setVectorDir
	["write", [_airNum, "vectorDir", (vectorDir _x)]] call _inidbi;
	//vectorUp setVectorUp
	["write", [_airNum, "vectorUp", (vectorUp _x)]] call _inidbi;

	//colour
	["write", [_airNum, "colour" , ((getObjectTextures _x) select 0)]] call _inidbi;

	//vars
	_allVars = [];
	_object = _x;
	{
		if (typeName (_object getVariable[_x,[]]) in ["SCALAR","STRING","BOOL","TEXT","CODE"]) then {
			_allVars append [[_x,_object getVariable[_x,""]]];
		};
	} forEach allVariables _x;
	["write", [_airNum, "allVars", _allVars]] call _inidbi;

	//set MSLID
	_x setVariable ["MSLID",_forEachIndex];
	_x setVariable ["MSLName",_airNum];
}forEach _allMissionObjectsAir;

//cars
{
	_carNum = "CAR" + str _forEachIndex;
	["write", [_carNum, "typeOf" , typeOf _x]] call _inidbi;
	["write", [_carNum, "position" , toString (getPos _x)]] call _inidbi;

	//vehicleVarName setVehicleVarName - do on all machines
	["write", [_carNum, "vehicleVarName", (vehicleVarName _x)]] call _inidbi;
	//vectorDir  setVectorDir
	["write", [_carNum, "vectorDir", (vectorDir _x)]] call _inidbi;
	//vectorUp setVectorUp
	["write", [_carNum, "vectorUp", (vectorUp _x)]] call _inidbi;

	//colour
	["write", [_carNum, "colour" , ((getObjectTextures _x) select 0)]] call _inidbi;

	//vars
	_allVars = [];
	_object = _x;
	{
		if (typeName (_object getVariable[_x,[]]) in ["SCALAR","STRING","BOOL","TEXT","CODE"]) then {
			_allVars append [[_x,_object getVariable[_x,""]]];
		};
	} forEach allVariables _x;
	["write", [_carNum, "allVars", _allVars]] call _inidbi;

	//set MSLID
	_x setVariable ["MSLID",_forEachIndex];
	_x setVariable ["MSLName",_carNum];
}forEach (_allMissionObjectsCar);

//boats
{
	_boatNum = "BOAT" + str _forEachIndex;
	["write", [_boatNum, "typeOf" , typeOf _x]] call _inidbi;
	["write", [_boatNum, "position" , toString (getPos _x)]] call _inidbi;

	//vehicleVarName setVehicleVarName - do on all machines
	["write", [_boatNum, "vehicleVarName", (vehicleVarName _x)]] call _inidbi;
	//vectorDir  setVectorDir
	["write", [_boatNum, "vectorDir", (vectorDir _x)]] call _inidbi;
	//vectorUp setVectorUp
	["write", [_boatNum, "vectorUp", (vectorUp _x)]] call _inidbi;

	//colour
	["write", [_boatNum, "colour" , ((getObjectTextures _x) select 0)]] call _inidbi;

	//vars
	_allVars = [];
	_object = _x;
	{
		if (typeName (_object getVariable[_x,[]]) in ["SCALAR","STRING","BOOL","TEXT","CODE"]) then {
			_allVars append [[_x,_object getVariable[_x,""]]];
		};
	} forEach allVariables _x;
	["write", [_boatNum, "allVars", _allVars]] call _inidbi;

	//set MSLID
	_x setVariable ["MSLID",_forEachIndex];
	_x setVariable ["MSLName",_boatNum];
}forEach _allMissionObjectsBoat;

//buildings
{
	_buildingNum = "BUILDING" + str _forEachIndex;
	["write", [_buildingNum, "typeOf" , typeOf _x]] call _inidbi;
	["write", [_buildingNum, "position" , toString (getPos _x)]] call _inidbi;

	//vehicleVarName setVehicleVarName - do on all machines
	["write", [_buildingNum, "vehicleVarName", (vehicleVarName _x)]] call _inidbi;
	//vectorDir  setVectorDir
	["write", [_buildingNum, "vectorDir", (vectorDir _x)]] call _inidbi;
	//vectorUp setVectorUp
	["write", [_buildingNum, "vectorUp", (vectorUp _x)]] call _inidbi;

	//vars
	_allVars = [];
	_object = _x;
	{
		
		if (typeName (_object getVariable[_x,[]]) in ["SCALAR","STRING","BOOL","TEXT","CODE"]) then {
			_allVars append [[_x,_object getVariable[_x,""]]];
		};
	} forEach allVariables _x;
	["write", [_buildingNum, "allVars", _allVars]] call _inidbi;

	//set MSLID
	_x setVariable ["MSLID",_forEachIndex];
	_x setVariable ["MSLName",_buildingNum];
}forEach _allMissionObjectsBuilding;

MSLPROGRESS = 0.3;
publicVariable "MSLPROGRESS";

//units
{
	_unitNum = "UNIT" + (str _forEachIndex);
	["write", [_unitNum, "typeOf", typeOf _x]] call _inidbi;//typeOf
	["write", [_unitNum, "position", toString (getPos _x)]] call _inidbi;//position
	["write", [_unitNum, "leader", (leader _x == _x)]] call _inidbi;//leader
	["write", [_unitNum, "isPlayer", (isPlayer _x)]] call _inidbi;//isPlayer
	// if (isMultiplayer) then {
	// 	["write", [_unitNum, "isPlayable", (_x in playableUnits)]] call _inidbi;//isPlayable
	// } else {
	// 	["write", [_unitNum, "isPlayable", (_x in switchableUnits)]] call _inidbi;//isPlayable
	// };
	["write", [_unitNum, "isPlayable", ((_x getVariable["MSLPlayable",false]) or (_x in playableUnits) or (_x in switchableUnits))]] call _inidbi;
	["write", [_unitNum, "skill", (skill _x)]] call _inidbi;//skill
	["write", [_unitNum, "rank", (rank _x)]] call _inidbi;//rank

	// = uniform player;
	["write", [_unitNum, "uniform", (uniform _x)]] call _inidbi;
	// = vest player;
	["write", [_unitNum, "vest", (vest _x)]] call _inidbi;
	// = backpack player;
	["write", [_unitNum, "backpack", (backpack _x)]] call _inidbi;
	// = weaponsItems player;
	["write", [_unitNum, "weaponsItems", (weaponsItems _x)]] call _inidbi;
	// = uniformItems player;
	["write", [_unitNum, "uniformItems", (uniformItems _x)]] call _inidbi;
	// = vestItems player;
	["write", [_unitNum, "vestItems", (vestItems _x)]] call _inidbi;
	// = backpackItems player;
	["write", [_unitNum, "backpackItems", (backpackItems _x)]] call _inidbi;
	// = assignedItems player;
	["write", [_unitNum, "assignedItems", (assignedItems _x)]] call _inidbi;
	// = headgear player;
	["write", [_unitNum, "headgear", (headgear _x)]] call _inidbi;
	// = goggles player;
	["write", [_unitNum, "goggles", (goggles _x)]] call _inidbi;

	//unit init - impossible

	//name  setName
	["write", [_unitNum, "name", (name _x)]] call _inidbi;
	//face setFace
	["write", [_unitNum, "face", (face _x)]] call _inidbi;
	//speaker setSpeaker
	["write", [_unitNum, "speaker", (speaker _x)]] call _inidbi;
	//pitch setPitch
	["write", [_unitNum, "pitch", (pitch _x)]] call _inidbi;
	//nameSound setNameSound
	["write", [_unitNum, "nameSound", (nameSound _x)]] call _inidbi;
	//player call BIS_fnc_getUnitInsignia; [this,"111thID"] call BIS_fnc_setUnitInsignia;
	["write", [_unitNum, "UnitInsignia", _x call BIS_fnc_getUnitInsignia]] call _inidbi;

	//stance - player playAction "PlayerProne"; _soldier setUnitPos "UP";
	["write", [_unitNum, "stance", (stance _x)]] call _inidbi;

	//vehicleVarName setVehicleVarName - do on all machines
	["write", [_unitNum, "vehicleVarName", (vehicleVarName _x)]] call _inidbi;
	//vectorDir  setVectorDir
	["write", [_unitNum, "vectorDir", (vectorDir _x)]] call _inidbi;
	//vectorUp setVectorUp
	["write", [_unitNum, "vectorUp", (vectorUp _x)]] call _inidbi;
	//roleDescription - no set
	["write", [_unitNum, "roleDescription", (roleDescription _x)]] call _inidbi;
	//damage setDamage
	["write", [_unitNum, "damage", (damage _x)]] call _inidbi;
	//getAllHitPointsDamage  setHitIndex or setHitPointDamage
	["write", [_unitNum, "getAllHitPointsDamage", (getAllHitPointsDamage _x)]] call _inidbi;
	//canTriggerDynamicSimulation triggerDynamicSimulation
	["write", [_unitNum, "canTriggerDynamicSimulation", (canTriggerDynamicSimulation _x)]] call _inidbi;
	//simulationEnabled enableSimulation
	["write", [_unitNum, "simulationEnabled", (simulationEnabled _x)]] call _inidbi;
	//isObjectHidden hideObjectGlobal 
	["write", [_unitNum, "isObjectHidden", (isObjectHidden _x)]] call _inidbi;
	//isDamageAllowed allowDamage
	["write", [_unitNum, "isDamageAllowed", (isDamageAllowed _x)]] call _inidbi;
	//isStaminaEnabled enableStamina
	["write", [_unitNum, "isStaminaEnabled", (isStaminaEnabled _x)]] call _inidbi;
	//
	//vehicleReportOwnPosition setVehicleReportOwnPosition
	["write", [_unitNum, "vehicleReportOwnPosition", (vehicleReportOwnPosition _x)]] call _inidbi;
	//vehicleReportRemoteTargets setVehicleReceiveRemoteTargets
	["write", [_unitNum, "vehicleReportRemoteTargets", (vehicleReportRemoteTargets _x)]] call _inidbi;
	//vehicleReceiveRemoteTargets setVehicleReceiveRemoteTargets
	["write", [_unitNum, "vehicleReceiveRemoteTargets", (vehicleReceiveRemoteTargets _x)]] call _inidbi;

	//vehicle
	if (vehicle _x != _x) then {
		if ((vehicle _x) in (_allMissionObjectsAir)) then {
			["write", [_unitNum, "vehicleType", "AIR"]] call _inidbi;//air
		};
		if ((vehicle _x) in (_allMissionObjectsBoat)) then {
			["write", [_unitNum, "vehicleType", "Ship"]] call _inidbi;//boat
		};
		if ((vehicle _x) in (_allMissionObjectsCar)) then {
			["write", [_unitNum, "vehicleType", "LandVehicle"]] call _inidbi;//car
		};
		["write", [_unitNum, "vehicle", (vehicle _x) getVariable ["MSLID",0]]] call _inidbi;//car ID
		["write", [_unitNum, "vehiclePosition", (vehicle _x) getCargoIndex _x]] call _inidbi;//car seat
	};

	//vars
	_allVars = [];
	_object = _x;
	{
		if (typeName (_object getVariable[_x,[]]) in ["SCALAR","STRING","BOOL","TEXT","CODE"]) then {
			_allVars append [[_x,_object getVariable[_x,""]]];
		};
	} forEach allVariables _x;
	["write", [_unitNum, "allVars", _allVars]] call _inidbi;
	
	_x setVariable ["MSLID",_forEachIndex];//MSLID
	_x setVariable ["MSLName",_unitNum];
}forEach _allUnitsNotOnTheBus;

MSLPROGRESS = 0.4;
publicVariable "MSLPROGRESS";

//groups
_groupIndex = 0;
{
	if ((count (units _x))>0) then {
	_groupID = "GROUP" + (str _groupIndex);
	["write", [_groupID, "side", str (side _x)]] call _inidbi;
	{
		["write", [_groupID, "unit" + (str _forEachIndex), _x getVariable "MSLID"]] call _inidbi;
	}forEach (units _x);

	//waypoints
	{
		_waypointNum = (str _forEachIndex);
		//waypointPosition
		["write", [_groupID, "waypointPos" + _waypointNum, waypointPosition _x]] call _inidbi;
		//waypointHousePosition setWaypointHousePosition
		//["write", [_groupID, "waypointHousePosition" + _waypointNum, waypointHousePosition  _x]] call _inidbi;
		//waypointDescription setWaypointDescription
		["write", [_groupID, "waypointDescription" + _waypointNum, waypointDescription  _x]] call _inidbi;
		//waypointName  setWaypointName
		["write", [_groupID, "waypointName" + _waypointNum, waypointName  _x]] call _inidbi;
		//waypointCompletionRadius setWaypointCompletionRadius
		["write", [_groupID, "waypointCompletionRadius" + _waypointNum, waypointCompletionRadius  _x]] call _inidbi;
		//waypointCombatMode setWaypointCombatMode
		["write", [_groupID, "waypointCombatMode" + _waypointNum, waypointCombatMode  _x]] call _inidbi;
		//waypointBehaviour setWaypointBehaviour
		["write", [_groupID, "waypointBehaviour" + _waypointNum, waypointBehaviour  _x]] call _inidbi;
		//waypointFormation setWaypointFormation
		["write", [_groupID, "waypointFormation" + _waypointNum, waypointFormation  _x]] call _inidbi;
		//waypointSpeed setWaypointSpeed
		["write", [_groupID, "waypointSpeed" + _waypointNum, waypointSpeed  _x]] call _inidbi;
		//waypointType setWaypointType
		["write", [_groupID, "waypointType" + _waypointNum, waypointType  _x]] call _inidbi;
		//waypointVisible setWaypointVisible
		["write", [_groupID, "waypointVisible" + _waypointNum, waypointVisible  _x]] call _inidbi;
		//waypointLoiterRadius setWaypointLoiterRadius
		["write", [_groupID, "waypointLoiterRadius" + _waypointNum, waypointLoiterRadius  _x]] call _inidbi;
		//waypointLoiterType setWaypointLoiterType
		["write", [_groupID, "waypointLoiterType" + _waypointNum, waypointLoiterType  _x]] call _inidbi;
		//waypointAttachedVehicle waypointAttachVehicle
		["write", [_groupID, "waypointAttachedVehicle" + _waypointNum, (waypointAttachedVehicle  _x) getVariable ["MSLName",""]]] call _inidbi;
		//waypointAttachedObject waypointAttachObject
		["write", [_groupID, "waypointAttachedObject" + _waypointNum, (waypointAttachedObject  _x) getVariable ["MSLName",""]]] call _inidbi;
		//waypointTimeout setWaypointTimeout
		["write", [_groupID, "waypointTimeout" + _waypointNum, (waypointTimeout  _x)]] call _inidbi;
		//waypointTimeoutCurrent 
		//["write", [_groupID, "waypointTimeoutCurrent" + _waypointNum, waypointTimeoutCurrent  _x]] call _inidbi;
		//synchronizedTriggers synchronizeTrigger -needs changing
		//["write", [_groupID, "synchronizedTriggers" + _waypointNum, (synchronizedTriggers  _x)]] call _inidbi;
		//synchronizedWaypoints  synchronizeWaypoint -needs changing
		_syncWPs = [];
		{
			_groupID = (_x select 0) getVariable["MSLID", -1];
			_wpNum = (_x select 1);
			_syncWPs append [[_groupID,_wpNum]];
		} forEach (synchronizedWaypoints  _x);
		["write", [_groupID, "synchronizedWaypoints" + _waypointNum, _syncWPs]] call _inidbi;
		//waypointStatements  setWaypointStatements
		["write", [_groupID, "waypointStatements" + _waypointNum, (waypointStatements  _x)]] call _inidbi;
	}forEach (waypoints _x);

	//vars
	_allVars = [];
	_object = _x;
	{
		if (typeName (_object getVariable[_x,[]]) in ["SCALAR","STRING","BOOL","TEXT","CODE"]) then {
			_allVars append [[_x,_object getVariable[_x,""]]];
		};
	} forEach allVariables _x;
	["write", [_groupID, "allVars", _allVars]] call _inidbi;
	
	_x setVariable ["MSLID",_groupIndex];
	_x setVariable ["MSLName",_groupID];
	
	MSLPROGRESS = 0.4 + (1/(count _allGoodGroups));
	publicVariable "MSLPROGRESS";
	_groupIndex = _groupIndex + 1;
};
}forEach _allGoodGroups;

MSLPROGRESS = 0.5;
publicVariable "MSLPROGRESS";

//triggers
{
	_triggerNum = "TRIGGER" + (str _forEachIndex);
	//vehicleVarName setVehicleVarName
	["write", [_triggerNum, "vehicleVarName", vehicleVarName _x]] call _inidbi;
	//triggerText  setTriggerText
	["write", [_triggerNum, "triggerText", triggerText _x]] call _inidbi;
	//getPos setPos
	["write", [_triggerNum, "getPos", toString (getPos _x)]] call _inidbi;
	//triggerArea setTriggerArea 
	["write", [_triggerNum, "triggerArea",  (triggerArea _x)]] call _inidbi;
	//triggerType setTriggerType
	["write", [_triggerNum, "triggerType", (triggerType _x)]] call _inidbi;
	//triggerActivation setTriggerActivation -local
	["write", [_triggerNum, "triggerActivation", (triggerActivation _x)]] call _inidbi;
	//triggerActivated
	["write", [_triggerNum, "triggerActivated", triggerActivated _x]] call _inidbi;
	//attachedObjects triggerAttachObject attachTo -needs changing
	//["write", [_triggerNum, "attachedObjects", (attachedObjects _x)]] call _inidbi;

	
	_syncs = [];
	{
		_object = _x getVariable["MSLName", ""];
		_syncs append [_object];
	} forEach (attachedObjects  _x);
	["write", [_triggerNum, "attachedObjects", _syncs]] call _inidbi;

	
	_syncWPs = [];
	{
		_groupID = (_x select 0) getVariable["MSLID", -1];
		_wpNum = (_x select 1);
		_syncWPs append [[_groupID,_wpNum]];
	} forEach (synchronizedWaypoints  _x);
	["write", [_triggerNum, "synchronizedWaypoints", _syncWPs]] call _inidbi;

	_syncs = [];
	{
		_object = _x getVariable["MSLName", ""];
		_syncs append [_object];
	} forEach (synchronizedObjects  _x);
	["write", [_triggerNum, "synchronizedObjects", _syncs]] call _inidbi;

	//synchronizedWaypoints synchronizeWaypoint -needs changing
	//["write", [_triggerNum, "synchronizedWaypoints", (synchronizedWaypoints _x)]] call _inidbi;

	//synchronizedObjects  synchronizeObjectsAdd
	//["write", [_triggerNum, "synchronizedObjects", (synchronizedObjects _x)]] call _inidbi;
	//triggerStatements setTriggerStatements
	["write", [_triggerNum, "triggerStatements", (triggerStatements _x)]] call _inidbi;
	//triggerTimeout setTriggerTimeout
	["write", [_triggerNum, "triggerTimeout", (triggerTimeout _x)]] call _inidbi;
	//triggerTimeoutCurrent 
	["write", [_triggerNum, "triggerTimeoutCurrent", triggerTimeoutCurrent _x]] call _inidbi;

_cat = triggerActivation _x;
_dog = triggerActivation _x;
_cat set [0,"VEHICLE"];
_x setTriggerActivation _cat;
_TAV = triggerAttachedVehicle _x;
_x setTriggerActivation _dog;

	//triggerAttachedVehicle triggerAttachVehicle
	["write", [_triggerNum, "triggerAttachedVehicle", ((_TAV) getVariable["MSLName",""])]] call _inidbi;

	//vars
	_allVars = [];
	_object = _x;
	{
		if (typeName (_object getVariable[_x,[]]) in ["SCALAR","STRING","BOOL","TEXT","CODE"]) then {
			_allVars append [[_x,_object getVariable[_x,""]]];
		};
	} forEach allVariables _x;
	["write", [_triggerNum, "allVars", _allVars]] call _inidbi;
	
	_x setVariable ["MSLID",_forEachIndex];
	_x setVariable ["MSLName",_triggerNum];
}forEach _allMissionObjectsTrigger;

MSLPROGRESS = 0.6;
publicVariable "MSLPROGRESS";

//markers
{
	_markerNum = "MARKER" + (str _forEachIndex);
	//markerType setMarkerType
	["write", [_markerNum, "markerType", markerType _x]] call _inidbi;
	//markerText setMarkerText
	["write", [_markerNum, "markerText", markerText _x]] call _inidbi;
	//_x  createMarker
	["write", [_markerNum, "markerName", _x]] call _inidbi;
	//markerPos setMarkerPos
	["write", [_markerNum, "markerPos", toString (markerPos _x)]] call _inidbi;
	//markerSize setMarkerSize
	["write", [_markerNum, "markerSize", markerSize _x]] call _inidbi;
	//markerDir setMarkerDir
	["write", [_markerNum, "markerDir", markerDir _x]] call _inidbi;
	//markerBrush setMarkerBrush
	["write", [_markerNum, "markerBrush", markerBrush _x]] call _inidbi;
	//markerColor setMarkerColor
	["write", [_markerNum, "markerColor", markerColor _x]] call _inidbi;
	//markerAlpha setMarkerAlpha
	["write", [_markerNum, "markerAlpha", markerAlpha _x]] call _inidbi;
	//markerShape setMarkerShape
	["write", [_markerNum, "markerShape", markerShape _x]] call _inidbi;
} forEach allMapMarkers;

MSLPROGRESS = 0.7;
publicVariable "MSLPROGRESS";

//tasks
_tasks = [];
{
	_tasks append (_x call BIS_fnc_tasksUnit);
} forEach _allUnitsNotOnTheBus;

{
	_task = _x getVariable ["task",""];
	// _units = [];
	// {
	// 	if (_task in (_x call BIS_fnc_tasksUnit)) then {
	// 		_units append [(_x getVariable["MSLName",""])];
	// 	};
	// } forEach _allUnitsNotOnTheBus;
	_syncedUnitObjects = (((synchronizedObjects (_x)) arrayIntersect allUnits) arrayIntersect _allUnitsNotOnTheBus);
	_syncedUnits = [];
	_unitObjects = [];
	_units = [];
	{
		_syncedUnits append [(_x getVariable["MSLName",""])];
	} forEach _syncedUnitObjects;

	switch (_x getVariable ["owner",-1]) do {
		case 0: {_unitObjects =  _syncedUnitObjects;};
		case 1: {
			{
				_unitObjects append (units (group _x));
			} forEach _syncedUnitObjects;
			_unitObjects = (_unitObjects arrayIntersect _unitObjects);
			};
		case 2: {
			{
				_syncer = _x;
				{
					if ((side _x) == (side _syncer)) then {
						_unitObjects append _x;
					};
				} forEach allUnits;
			} forEach _syncedUnitObjects;
			_unitObjects = (_unitObjects arrayIntersect _unitObjects);
		};
		case 3: {
			_unitObjects = allUnits;
		 };
		case 4: {
			{
				if ((side _x) == west) then {
					_unitObjects pushBack _x;
				};
			} forEach allUnits;
		 };
		case 5: {
			{
				if ((side _x) == east) then {
					_unitObjects pushBack _x;
				};
			} forEach allUnits;
		 };
		case 6: {
			{
				if ((side _x) == resistance) then {
					_unitObjects pushBack _x;
				};
			} forEach allUnits;
		 };
		case 7: {
			{
				if ((side _x) == civilian) then {
					_unitObjects pushBack _x;
				};
			} forEach allUnits;
		 };
		case -1: {_unitObjects =  _syncedunits;};
	};

	{
		_units append [(_x getVariable["MSLName",""])];
	} forEach _unitObjects;
	//units
//	{
//		if (_task in (_x call BIS_fnc_tasksUnit)) then {
//			_units pushBack (_x getVariable ["MSLName","-1"]);
//hint ("-2" + (str _units));
//sleep 1;
//		};
// hint ("-1" + (str _x));
// sleep 1;
//	} forEach allUnits;

	//save task
	_taskNum = "TASKS" + (str _forEachIndex);
	//units
	["write", [_taskNum, "units", _units]] call _inidbi;
	//id
	//_task call BIS_fnc_taskVar
	["write", [_taskNum, "id", (str _x)]] call _inidbi;
	//description
	["write", [_taskNum, "description", (_task call BIS_fnc_taskDescription)]] call _inidbi;
	//destination
	["write", [_taskNum, "destination", (_task call BIS_fnc_taskDestination)]] call _inidbi;
	//taskState
	["write", [_taskNum, "taskState", _task call BIS_fnc_taskState]] call _inidbi;


	["write", [_taskNum, "syncedUnits", _syncedUnits]] call _inidbi;
	["write", [_taskNum, "owner", (_x getVariable ["owner",-1])]] call _inidbi;
	
	//vars
	_allVars = [];
	_object = _x;
	{
		if (typeName (_object getVariable[_x,[]]) in ["SCALAR","STRING","BOOL","TEXT","CODE"]) then {
			_allVars append [[_x,_object getVariable[_x,""]]];
		};
	} forEach (allVariables _x);
	["write", [_taskNum, "allVars", _allVars]] call _inidbi;

	//created task
	//[_units,_x call BIS_fnc_taskVar,_x call BIS_fnc_taskDescription,_x call BIS_fnc_taskDestination, _x call BIS_fnc_taskState] call BIS_fnc_TaskCreate;

// hint ("0" + (str _x));
// sleep 1;
	//task state alterations
	_triggerNum = 0;
	_taskObj = _x;
/* 	{
hint ("1" + (str _x));
sleep 1;
		if (str _x == _task) then {
			_taskObj = _x;
hint "2" + (str _taskObj);
sleep 1;
		};
	}forEach allMissionObjects "ModuleTaskCreate_F"; */
	{
// hint "3" + (str _x);
// sleep 1;
		_taskStateModule = _x;
		{
// hint "4" + (str _x);
// sleep 1;
			_triggerStr = "trigger" + (str _triggerNum);
			// Current result is saved in variable _x
			["write", [_taskNum, _triggerStr + "ID", _x getVariable["MSLID",-1]]] call _inidbi;
			["write", [_taskNum, _triggerStr + "State", _taskStateModule getVariable["state","CREATED"]]] call _inidbi;
["write", ["TEST", "TEST3", _triggerNum]] call _inidbi;
			_triggerNum = _triggerNum + 1;
		} forEach ((synchronizedObjects _x) arrayIntersect (_allMissionObjectsTrigger));
["write", ["TEST", "TEST2", str _x]] call _inidbi;
	} forEach ((synchronizedObjects (_taskObj)) arrayIntersect (_allMissionObjectsTaskStates));
["write", ["TEST", "TEST1", str _x]] call _inidbi;
} forEach _allMissionObjectsTasks;//(_tasks arrayIntersect _tasks);

MSLPROGRESS = 0.8;
publicVariable "MSLPROGRESS";

//get all variables on all objects in game
/* 
_allVars = [];
_object = _x;
{
	_allVars append [[_x,_object getVariable[_x,""]]];
} forEach allVariables _x;
["write", ["", "allVars", _allVars]] call _inidbi;
 */
//logics/modules
{
	_logicNum = "LOGIC" + (str _forEachIndex);
	["write", [_logicNum, "type", typeOf _x]] call _inidbi;

	//vars
	_allVars = [];
	_object = _x;
	{
		if (typeName (_object getVariable[_x,[]]) in ["SCALAR","STRING","BOOL","TEXT","CODE"]) then {
			_allVars append [[_x,_object getVariable[_x,""]]];
		}; /* else {
			_allVars append [[_x,_object getVariable["MSLName",(_object getVariable[_x,""])]]];
		}; */
	} forEach allVariables _x;
	["write", [_logicNum, "allVars", _allVars]] call _inidbi;
} forEach _allMissionObjectsLogic;

MSLPROGRESS = 0.9;
publicVariable "MSLPROGRESS";

//missionNamespace and Locations
_allLocationTypes = [];
"_allLocationTypes pushBack configName _x" configClasses (
	configFile >> "CfgLocationTypes"
);
_locationIndex = 0;
{
	_x setVariable ["MSL",true];
	if (_x getVariable "MSL") then {
		_locationID = "LOCATION" + (str _locationIndex);
		["write", [_locationID, "locationName", text  _x]] call _inidbi;
		["write", [_locationID, "locationside", str (side  _x)]] call _inidbi;
		["write", [_locationID, "locationPosition", locationPosition  _x]] call _inidbi;
		["write", [_locationID, "locationSize", size  _x]] call _inidbi;
		["write", [_locationID, "locationType", type  _x]] call _inidbi;
		
		//vars
		_allVars = [];
		_loc = _x;
		{
			if (typeName (_loc getVariable[_x,[]]) in ["SCALAR","STRING","BOOL","TEXT","CODE"]) then {
				_allVars append [[_x,_loc getVariable[_x,""]]];
			};
		} forEach allVariables _x;
		["write", [_locationID, "allVars", _allVars]] call _inidbi;
		
		_locationIndex = _locationIndex + 1;
	};
} forEach nearestLocations [[worldSize/2, worldSize/2], _allLocationTypes, worldSize];

MSLPROGRESS = 0.95;
publicVariable "MSLPROGRESS";

//remove tags
{
	_x setVariable ["MSLID", nil];
	_x setVariable ["MSLName", nil];
	//_x setVariable ["MSLPlayer", nil];
	//_x setVariable ["MSLPlayable", nil];
} forEach _allMissionObjectsAll;

//local setups
{
	[] remoteExec ["Werthles_fnc_MSLLocal",_clientID];
}forEach allPlayers;

//close db
["delete", _inidbi] call OO_INIDBI;

//save completion
[] remoteExec ["Werthles_fnc_MSLSavePlayer",_clientID];

MSLPROGRESS = 1;
publicVariable "MSLPROGRESS";