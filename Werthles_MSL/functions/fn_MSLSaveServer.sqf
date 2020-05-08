//hint "Serversave";
params [["_clientID",-2,[0]],["_saveName","",[""]],["_hiddenCheck",false,[false]],["_serverTriggerCheck",false,[false]],["_simple",false,[false]]];
private ["_allMissionObjectsAll", "_allMissionObjectsAir", "_allMissionObjectsCar", "_allMissionObjectsBoat", "_allMissionObjectsBuilding", "_allMissionObjectsTrigger", "_allMissionObjectsTaskStates", "_allMissionObjectsTasks", "_allMissionObjectsLogic", "_allUnitsOnTheBus", "_allGroupsOnTheBus", "_allUnitsNotOnTheBus", "_allBadGroups", "_allGoodGroups", "_inidbi", "_inidbiSAVELIST", "_dateTime", "_dateTimeString", "_allSaves", "_newSaveNumber", "_MISSIONNAMESPACE", "_allVars", "_MISSIONDETAILS", "_hiddenObjects", "_placedObjects", "_airNum", "_object", "_carNum", "_boatNum", "_buildingNum", "_unitNum", "_soldier", "_groupIndex", "_groupID", "_waypointNum", "_syncWPs", "_wpNum", "_triggerNum", "_syncs", "_cat", "_dog", "_TAV", "_markerNum", "_tasks", "_task", "_syncedUnitObjects", "_syncedUnits", "_unitObjects", "_syncer", "_syncedunits", "_taskNum", "_taskObj", "_taskStateModule", "_triggerStr", "_logicNum", "_allLocationTypes", "_locationIndex", "_locationID", "_loc", "_units", "_thingNum", "_allMissionObjectsThing"];
_simple = !_simple;
if !(_simple) then {
	
MSLPROGRESS = 0;
publicVariable "MSLPROGRESS";

_allMissionObjectsAll = allMissionObjects "all";
_allMissionObjectsThing = allMissionObjects "thing";
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


//if (!("exists" call _inidbi)) then {};
_inidbiSAVELIST = ["new", "SAVELIST"] call OO_INIDBI;

_dateTime = "getTimeStamp" call _inidbiSAVELIST;
//_dateTimeString = str _dateTime;
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

MSLPROGRESS = 0.05;
publicVariable "MSLPROGRESS";

//_dateTimeString = "real_date" callExtension "+";
//_dateTime = parseSimpleArray (_dateTimeString);

//_dateTime = "getTimeStamp" call _inidbi;

_inidbi = ["new", _saveName] call OO_INIDBI;
	

//missionNamespace
// _MISSIONNAMESPACE = "N";
// _allVars = [];
// {
// 	if ((typeName (missionNamespace getVariable[_x,[]]) in ["SCALAR","STRING","BOOL","TEXT"]) and ((_x find "MSL")!=0) and ((_x find "msl")!=0) and ((_x find "bis_")!=0) and ((_x find "oo_inidbi")!=0)) then {
// 		_allVars append [[_x,missionNamespace getVariable[_x,""]]];
// MSLPROGRESS = MSLPROGRESS + 0.0005;
// publicVariable "MSLPROGRESS";
// 	};
// } forEach (allVariables missionNamespace);
// ["write", [_MISSIONNAMESPACE, "A", _allVars]] call _inidbi;
//hint (str _allVars);


MSLPROGRESS = 0.1;
publicVariable "MSLPROGRESS";

//MISSIONDETAILS 
_MISSIONDETAILS = "M";
["write", [_MISSIONDETAILS, "A", worldName]] call _inidbi;
["write", [_MISSIONDETAILS, "B", missionName]] call _inidbi;
["write", [_MISSIONDETAILS, "C", (toString date)]] call _inidbi;
//["write", [_MISSIONDETAILS, "accTime", accTime]] call _inidbi;
//["write", [_MISSIONDETAILS, "date", date]] call _inidbi;
["write", [_MISSIONDETAILS, "D", timeMultiplier]] call _inidbi;
["write", [_MISSIONDETAILS, "E", wind]] call _inidbi;
["write", [_MISSIONDETAILS, "F", waves]] call _inidbi;
["write", [_MISSIONDETAILS, "G", viewDistance]] call _inidbi;
["write", [_MISSIONDETAILS, "H", rainbow]] call _inidbi;
["write", [_MISSIONDETAILS, "I", lightnings]] call _inidbi;
["write", [_MISSIONDETAILS, "J", fog]] call _inidbi;
//["write", [_MISSIONDETAILS, "fogForecast", fogForecast]] call _inidbi;
["write", [_MISSIONDETAILS, "K", nextWeatherChange]] call _inidbi;
["write", [_MISSIONDETAILS, "L", overcast]] call _inidbi;
["write", [_MISSIONDETAILS, "M", rain]] call _inidbi;
//["write", [_MISSIONDETAILS, "humidity", humidity]] call _inidbi;
["write", [_MISSIONDETAILS, "N", gusts]] call _inidbi;
["write", [_MISSIONDETAILS, "O", getMissionDLCs]] call _inidbi;
["write", [_MISSIONDETAILS, "P", west getFriend east]] call _inidbi;
["write", [_MISSIONDETAILS, "Q", west getFriend independent]] call _inidbi;
["write", [_MISSIONDETAILS, "R", west getFriend civilian]] call _inidbi;
["write", [_MISSIONDETAILS, "S", east getFriend independent]] call _inidbi;
["write", [_MISSIONDETAILS, "T", east getFriend civilian]] call _inidbi;
["write", [_MISSIONDETAILS, "U", independent getFriend civilian]] call _inidbi;
//["write", [_MISSIONDETAILS, "V", diag_activeSQFScripts]] call _inidbi;
["write", [_MISSIONDETAILS, "W", toString environmentEnabled]] call _inidbi;
["write", [_MISSIONDETAILS, "X", isStressDamageEnabled]] call _inidbi;
["write", [_MISSIONDETAILS, "Y", 2]] call _inidbi; //version
["write", [_MISSIONDETAILS, "Z", _simple]] call _inidbi; //simple
//["write", [_MISSIONDETAILS, "cadetMode", cadetMode]] call _inidbi;

MSLPROGRESS = 0.2;
publicVariable "MSLPROGRESS";


//hidden buildings - H
_hiddenObjects = [];
if (_hiddenCheck) then {
	{
		//placed objects
		// if !(_x in nearestTerrainObjects[_x, [],0.1,false,true]) then
		// {_placedObjects pushBack _x;};
		//hidden map objects
		if (isObjectHidden _x)  then {
			_hiddenObjects pushBack _x;
		};
MSLPROGRESS = MSLPROGRESS + 0.0001;
publicVariable "MSLPROGRESS";
	}forEach (nearestObjects [[worldSize/2, worldSize/2], ["Building"], worldSize*2, false,true]);
	{
		["write", ["H" + (str _forEachIndex), "T" , (typeOf _x)]] call _inidbi;
		["write", ["H" + (str _forEachIndex), "P" , toString (getPos _x)]] call _inidbi;
MSLPROGRESS = MSLPROGRESS + 0.0001;
publicVariable "MSLPROGRESS";
	}forEach _hiddenObjects;
};

//things - Z
{
	if (alive _x) then {
	_thingNum = "Z" + (str _forEachIndex);
	["write", [_thingNum, "T" , typeOf _x]] call _inidbi;
	["write", [_thingNum, "P" , toString (getPos _x)]] call _inidbi;

	//vehicleVarName setVehicleVarName - do on all machines
	["write", [_thingNum, "N", (vehicleVarName _x)]] call _inidbi;
	//vectorDir  setVectorDir
	["write", [_thingNum, "D", (vectorDir _x)]] call _inidbi;
	//vectorUp setVectorUp
	["write", [_thingNum, "U", (vectorUp _x)]] call _inidbi;

	// vars
	// _allVars = [];
	// _object = _x;
	// {
	// 	if (typeName (_object getVariable[_x,[]]) in ["SCALAR","STRING","BOOL","TEXT","CODE"]) then {
	// 		_allVars append [[_x,_object getVariable[_x,""]]];
	// 	};
	// } forEach allVariables _x;
	// ["write", [_thingNum, "V", _allVars]] call _inidbi;

	//set MSLID
	_x setVariable ["MSLID",_forEachIndex];
	_x setVariable ["MSLName",_thingNum];

MSLPROGRESS = MSLPROGRESS + 0.001;
publicVariable "MSLPROGRESS";
	};
}forEach _allMissionObjectsThing;


//air - A
{
	if (alive _x) then {
	_airNum = "A" + (str _forEachIndex);
	["write", [_airNum, "T" , typeOf _x]] call _inidbi;
	["write", [_airNum, "P" , toString (getPos _x)]] call _inidbi;
	["write", [_airNum, "S" , 
		["FORM","FLY"] select (((getPos _x) select 2)>5)
	]] call _inidbi;

	//vehicleVarName setVehicleVarName - do on all machines
	["write", [_airNum, "N", (vehicleVarName _x)]] call _inidbi;
	//vectorDir  setVectorDir
	["write", [_airNum, "D", (vectorDir _x)]] call _inidbi;
	//vectorUp setVectorUp
	["write", [_airNum, "U", (vectorUp _x)]] call _inidbi;

	//colour
	["write", [_airNum, "C" , ((getObjectTextures _x) select 0)]] call _inidbi;

	//vars
	// _allVars = [];
	// _object = _x;
	// {
	// 	if (typeName (_object getVariable[_x,[]]) in ["SCALAR","STRING","BOOL","TEXT","CODE"]) then {
	// 		_allVars append [[_x,_object getVariable[_x,""]]];
	// 	};
	// } forEach allVariables _x;
	// ["write", [_airNum, "V", _allVars]] call _inidbi;

	//set MSLID
	_x setVariable ["MSLID",_forEachIndex];
	_x setVariable ["MSLName",_airNum];

MSLPROGRESS = MSLPROGRESS + 0.001;
publicVariable "MSLPROGRESS";
};
}forEach _allMissionObjectsAir;

//cars - C
{
	if (alive _x) then {
	_carNum = "C" + (str _forEachIndex);
	["write", [_carNum, "T" , typeOf _x]] call _inidbi;
	["write", [_carNum, "P" , toString (getPos _x)]] call _inidbi;

	//vehicleVarName setVehicleVarName - do on all machines
	["write", [_carNum, "N", (vehicleVarName _x)]] call _inidbi;
	//vectorDir  setVectorDir
	["write", [_carNum, "D", (vectorDir _x)]] call _inidbi;
	//vectorUp setVectorUp
	["write", [_carNum, "U", (vectorUp _x)]] call _inidbi;

	//colour
	["write", [_carNum, "C" , ((getObjectTextures _x) select 0)]] call _inidbi;

	//vars
	// _allVars = [];
	// _object = _x;
	// {
	// 	if (typeName (_object getVariable[_x,[]]) in ["SCALAR","STRING","BOOL","TEXT","CODE"]) then {
	// 		_allVars append [[_x,_object getVariable[_x,""]]];
	// 	};
	// } forEach allVariables _x;
	// ["write", [_carNum, "V", _allVars]] call _inidbi;

	//set MSLID
	_x setVariable ["MSLID",_forEachIndex];
	_x setVariable ["MSLName",_carNum];

MSLPROGRESS = MSLPROGRESS + 0.001;
publicVariable "MSLPROGRESS";
};
}forEach (_allMissionObjectsCar);

//boats
{
	if (alive _x) then {
	_boatNum = "B" + (str _forEachIndex);
	["write", [_boatNum, "T" , typeOf _x]] call _inidbi;
	["write", [_boatNum, "P" , toString (getPos _x)]] call _inidbi;

	//vehicleVarName setVehicleVarName - do on all machines
	["write", [_boatNum, "N", (vehicleVarName _x)]] call _inidbi;
	//vectorDir  setVectorDir
	["write", [_boatNum, "D", (vectorDir _x)]] call _inidbi;
	//vectorUp setVectorUp
	["write", [_boatNum, "U", (vectorUp _x)]] call _inidbi;

	//colour
	["write", [_boatNum, "C" , ((getObjectTextures _x) select 0)]] call _inidbi;

	//vars
	// _allVars = [];
	// _object = _x;
	// {
	// 	if (typeName (_object getVariable[_x,[]]) in ["SCALAR","STRING","BOOL","TEXT","CODE"]) then {
	// 		_allVars append [[_x,_object getVariable[_x,""]]];
	// 	};
	// } forEach allVariables _x;
	// ["write", [_boatNum, "V", _allVars]] call _inidbi;

	//set MSLID
	_x setVariable ["MSLID",_forEachIndex];
	_x setVariable ["MSLName",_boatNum];

MSLPROGRESS = MSLPROGRESS + 0.001;
publicVariable "MSLPROGRESS";
	};
}forEach _allMissionObjectsBoat;

//buildings - S
{
	if (alive _x) then {
	_buildingNum = "S" + (str _forEachIndex);
	["write", [_buildingNum, "T" , typeOf _x]] call _inidbi;
	["write", [_buildingNum, "P" , toString (getPos _x)]] call _inidbi;

	//vehicleVarName setVehicleVarName - do on all machines
	["write", [_buildingNum, "N", (vehicleVarName _x)]] call _inidbi;
	//vectorDir  setVectorDir
	["write", [_buildingNum, "D", (vectorDir _x)]] call _inidbi;
	//vectorUp setVectorUp
	["write", [_buildingNum, "U", (vectorUp _x)]] call _inidbi;

	//vars
	// _allVars = [];
	// _object = _x;
	// {
		
	// 	if (typeName (_object getVariable[_x,[]]) in ["SCALAR","STRING","BOOL","TEXT","CODE"]) then {
	// 		_allVars append [[_x,_object getVariable[_x,""]]];
	// 	};
	// } forEach allVariables _x;
	// ["write", [_buildingNum, "V", _allVars]] call _inidbi;

	//set MSLID
	_x setVariable ["MSLID",_forEachIndex];
	_x setVariable ["MSLName",_buildingNum];

MSLPROGRESS = MSLPROGRESS + 0.001;
publicVariable "MSLPROGRESS";
	};
}forEach _allMissionObjectsBuilding;

MSLPROGRESS = 0.3;
publicVariable "MSLPROGRESS";

//units - U
{
	_unitNum = "U" + (str _forEachIndex);
	["write", [_unitNum, "A", typeOf _x]] call _inidbi;//typeOf
	["write", [_unitNum, "B", toString (getPos _x)]] call _inidbi;//position
	["write", [_unitNum, "C", (leader _x == _x)]] call _inidbi;//leader
	["write", [_unitNum, "D", (isPlayer _x)]] call _inidbi;//isPlayer
	// if (isMultiplayer) then {
	// 	["write", [_unitNum, "isPlayable", (_x in playableUnits)]] call _inidbi;//isPlayable
	// } else {
	// 	["write", [_unitNum, "isPlayable", (_x in switchableUnits)]] call _inidbi;//isPlayable
	// };
	["write", [_unitNum, "E", ((_x getVariable["MSLPlayable",false]) or (_x in playableUnits) or (_x in switchableUnits))]] call _inidbi;
	["write", [_unitNum, "F", (skill _x)]] call _inidbi;//skill
	["write", [_unitNum, "G", (rank _x)]] call _inidbi;//rank

	// = uniform player;
	// ["write", [_unitNum, "H", (uniform _x)]] call _inidbi;
	// // = vest player;
	// ["write", [_unitNum, "I", (vest _x)]] call _inidbi;
	// // = backpack player;
	// ["write", [_unitNum, "J", (backpack _x)]] call _inidbi;
	// // = weaponsItems player;
	// ["write", [_unitNum, "K", (weaponsItems _x)]] call _inidbi;
	// // = uniformItems player;
	// ["write", [_unitNum, "L", (uniformItems _x)]] call _inidbi;
	// // = vestItems player;
	// ["write", [_unitNum, "M", (vestItems _x)]] call _inidbi;
	// // = backpackItems player;
	// ["write", [_unitNum, "N", (backpackItems _x)]] call _inidbi;
	// // = assignedItems player;
	// ["write", [_unitNum, "O", (assignedItems _x)]] call _inidbi;
	// // = headgear player;
	// ["write", [_unitNum, "P", (headgear _x)]] call _inidbi;
	// // = goggles player;
	// ["write", [_unitNum, "Q", (goggles _x)]] call _inidbi;

	//unit init - impossible

	//name  setName
	//["write", [_unitNum, "R", (name _x)]] call _inidbi;
	//face setFace
	//["write", [_unitNum, "S", (face _x)]] call _inidbi;
	//speaker setSpeaker
	//["write", [_unitNum, "T", (speaker _x)]] call _inidbi;
	//pitch setPitch
	//["write", [_unitNum, "U", (pitch _x)]] call _inidbi;
	//nameSound setNameSound
	//["write", [_unitNum, "V", (nameSound _x)]] call _inidbi;
	//player call BIS_fnc_getUnitInsignia; [this,"111thID"] call BIS_fnc_setUnitInsignia;
	//["write", [_unitNum, "W", _x call BIS_fnc_getUnitInsignia]] call _inidbi;

	//stance - player playAction "PlayerProne"; _soldier setUnitPos "UP";
	//["write", [_unitNum, "X", (stance _x)]] call _inidbi;

	//vehicleVarName setVehicleVarName - do on all machines
	["write", [_unitNum, "Y", (vehicleVarName _x)]] call _inidbi;
	//vectorDir  setVectorDir
	["write", [_unitNum, "Z", (vectorDir _x)]] call _inidbi;
	//vectorUp setVectorUp
	["write", [_unitNum, "0", (vectorUp _x)]] call _inidbi;
	//roleDescription - no set
	//["write", [_unitNum, "1", (roleDescription _x)]] call _inidbi;
	//damage setDamage
	["write", [_unitNum, "2", (damage _x)]] call _inidbi;
	//getAllHitPointsDamage  setHitIndex or setHitPointDamage
	//["write", [_unitNum, "3", (getAllHitPointsDamage _x)]] call _inidbi;
	//canTriggerDynamicSimulation triggerDynamicSimulation
	//["write", [_unitNum, "4", (canTriggerDynamicSimulation _x)]] call _inidbi;
	//simulationEnabled enableSimulation
	//["write", [_unitNum, "5", (simulationEnabled _x)]] call _inidbi;
	//isObjectHidden hideObjectGlobal 
	//["write", [_unitNum, "6", (isObjectHidden _x)]] call _inidbi;
	//isDamageAllowed allowDamage
	["write", [_unitNum, "7", (isDamageAllowed _x)]] call _inidbi;
	//isStaminaEnabled enableStamina
	["write", [_unitNum, "8", (isStaminaEnabled _x)]] call _inidbi;
	//
	//vehicleReportOwnPosition setVehicleReportOwnPosition
	//["write", [_unitNum, "9", (vehicleReportOwnPosition _x)]] call _inidbi;
	//vehicleReportRemoteTargets setVehicleReceiveRemoteTargets
	//["write", [_unitNum, "10", (vehicleReportRemoteTargets _x)]] call _inidbi;
	//vehicleReceiveRemoteTargets setVehicleReceiveRemoteTargets
	//["write", [_unitNum, "11", (vehicleReceiveRemoteTargets _x)]] call _inidbi;

	//vehicle
	if (vehicle _x != _x) then {
		if ((vehicle _x) in (_allMissionObjectsAir)) then {
			["write", [_unitNum, "12", "AIR"]] call _inidbi;//air
		};
		if ((vehicle _x) in (_allMissionObjectsBoat)) then {
			["write", [_unitNum, "12", "Ship"]] call _inidbi;//boat
		};
		if ((vehicle _x) in (_allMissionObjectsCar)) then {
			["write", [_unitNum, "12", "LandVehicle"]] call _inidbi;//car
		};
		["write", [_unitNum, "13", (vehicle _x) getVariable ["MSLID",0]]] call _inidbi;//car ID
		//["write", [_unitNum, "14", (vehicle _x) getCargoIndex _x]] call _inidbi;//car seat
	};

	//vars
	// _allVars = [];
	// _object = _x;
	// {
	// 	if (typeName (_object getVariable[_x,[]]) in ["SCALAR","STRING","BOOL","TEXT","CODE"]) then {
	// 		_allVars append [[_x,_object getVariable[_x,""]]];
	// 	};
	// } forEach allVariables _x;
	// ["write", [_unitNum, "15", _allVars]] call _inidbi;
	
	_x setVariable ["MSLID",_forEachIndex];//MSLID
	_x setVariable ["MSLName",_unitNum];

MSLPROGRESS = MSLPROGRESS + 0.001;
publicVariable "MSLPROGRESS";
}forEach _allUnitsNotOnTheBus;

MSLPROGRESS = 0.4;
publicVariable "MSLPROGRESS";

//groups - G
_groupIndex = 0;
{
	if ((count (units _x))>0) then {
	_groupID = "G" + (str _groupIndex);
	["write", [_groupID, "S", str (side _x)]] call _inidbi;
	{
		["write", [_groupID, "U" + (str _forEachIndex), _x getVariable "MSLID"]] call _inidbi;
	}forEach (units _x);

	//group name
	["write", [_groupID, "Z", groupId  _x]] call _inidbi;

	//waypoints
	{
		_waypointNum = (str _forEachIndex);
		//waypointPosition
		["write", [_groupID, "P" + _waypointNum, waypointPosition _x]] call _inidbi;
		//waypointHousePosition setWaypointHousePosition
		//["write", [_groupID, "waypointHousePosition" + _waypointNum, waypointHousePosition  _x]] call _inidbi;
		//waypointDescription setWaypointDescription
		//["write", [_groupID, "D" + _waypointNum, waypointDescription  _x]] call _inidbi;
		//waypointName  setWaypointName
		["write", [_groupID, "N" + _waypointNum, waypointName  _x]] call _inidbi;
		//waypointCompletionRadius setWaypointCompletionRadius
		["write", [_groupID, "R" + _waypointNum, waypointCompletionRadius  _x]] call _inidbi;
		//waypointCombatMode setWaypointCombatMode
		["write", [_groupID, "C" + _waypointNum, waypointCombatMode  _x]] call _inidbi;
		//waypointBehaviour setWaypointBehaviour
		["write", [_groupID, "B" + _waypointNum, waypointBehaviour  _x]] call _inidbi;
		//waypointFormation setWaypointFormation
		["write", [_groupID, "F" + _waypointNum, waypointFormation  _x]] call _inidbi;
		//waypointSpeed setWaypointSpeed
		["write", [_groupID, "A" + _waypointNum, waypointSpeed  _x]] call _inidbi;
		//waypointType setWaypointType
		["write", [_groupID, "T" + _waypointNum, waypointType  _x]] call _inidbi;
		//waypointVisible setWaypointVisible
		["write", [_groupID, "V" + _waypointNum, waypointVisible  _x]] call _inidbi;
		//waypointLoiterRadius setWaypointLoiterRadius
		["write", [_groupID, "L" + _waypointNum, waypointLoiterRadius  _x]] call _inidbi;
		//waypointLoiterType setWaypointLoiterType
		["write", [_groupID, "E" + _waypointNum, waypointLoiterType  _x]] call _inidbi;
		//waypointAttachedVehicle waypointAttachVehicle
		["write", [_groupID, "G" + _waypointNum, (waypointAttachedVehicle  _x) getVariable ["MSLName",""]]] call _inidbi;
		//waypointAttachedObject waypointAttachObject
		["write", [_groupID, "H" + _waypointNum, (waypointAttachedObject  _x) getVariable ["MSLName",""]]] call _inidbi;
		//waypointTimeout setWaypointTimeout
		["write", [_groupID, "I" + _waypointNum, (waypointTimeout  _x)]] call _inidbi;
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
		["write", [_groupID, "J" + _waypointNum, _syncWPs]] call _inidbi;
		//waypointStatements  setWaypointStatements
		["write", [_groupID, "K" + _waypointNum, (waypointStatements  _x)]] call _inidbi;
	}forEach (waypoints _x);

	//vars
	// _allVars = [];
	// _object = _x;
	// {
	// 	if (typeName (_object getVariable[_x,[]]) in ["SCALAR","STRING","BOOL","TEXT","CODE"]) then {
	// 		_allVars append [[_x,_object getVariable[_x,""]]];
	// 	};
	// } forEach allVariables _x;
	// ["write", [_groupID, "M", _allVars]] call _inidbi;
	
	_x setVariable ["MSLID",_groupIndex];
	_x setVariable ["MSLName",_groupID];
	
	MSLPROGRESS = 0.4 + (1/(count _allGoodGroups));
	publicVariable "MSLPROGRESS";
	
	_groupIndex = _groupIndex + 1;
};

MSLPROGRESS = MSLPROGRESS + 0.001;
publicVariable "MSLPROGRESS";
}forEach _allGoodGroups;

MSLPROGRESS = 0.5;
publicVariable "MSLPROGRESS";

//triggers
{
	_triggerNum = "T" + (str _forEachIndex);
	//vehicleVarName setVehicleVarName
	["write", [_triggerNum, "V", vehicleVarName _x]] call _inidbi;
	//triggerText  setTriggerText
	//["write", [_triggerNum, "T", triggerText _x]] call _inidbi;
	//getPos setPos
	["write", [_triggerNum, "P", toString (getPos _x)]] call _inidbi;
	//triggerArea setTriggerArea 
	["write", [_triggerNum, "A",  (triggerArea _x)]] call _inidbi;
	//triggerType setTriggerType
	["write", [_triggerNum, "Y", (triggerType _x)]] call _inidbi;
	//triggerActivation setTriggerActivation -local
	["write", [_triggerNum, "B", (triggerActivation _x)]] call _inidbi;
	//triggerActivated
	["write", [_triggerNum, "C", triggerActivated _x]] call _inidbi;
	//attachedObjects triggerAttachObject attachTo -needs changing
	//["write", [_triggerNum, "attachedObjects", (attachedObjects _x)]] call _inidbi;

	
	_syncs = [];
	{
		_object = _x getVariable["MSLName", ""];
		_syncs append [_object];
	} forEach (attachedObjects  _x);
	["write", [_triggerNum, "O", _syncs]] call _inidbi;

	
	_syncWPs = [];
	{
		_groupID = (_x select 0) getVariable["MSLID", -1];
		_wpNum = (_x select 1);
		_syncWPs append [[_groupID,_wpNum]];
	} forEach (synchronizedWaypoints  _x);
	["write", [_triggerNum, "W", _syncWPs]] call _inidbi;

	_syncs = [];
	{
		_object = _x getVariable["MSLName", ""];
		_syncs append [_object];
	} forEach (synchronizedObjects  _x);
	["write", [_triggerNum, "S", _syncs]] call _inidbi;

	//synchronizedWaypoints synchronizeWaypoint -needs changing
	//["write", [_triggerNum, "synchronizedWaypoints", (synchronizedWaypoints _x)]] call _inidbi;

	//synchronizedObjects  synchronizeObjectsAdd
	//["write", [_triggerNum, "synchronizedObjects", (synchronizedObjects _x)]] call _inidbi;
	//triggerStatements setTriggerStatements
	["write", [_triggerNum, "D", (triggerStatements _x)]] call _inidbi;
	//triggerTimeout setTriggerTimeout
	["write", [_triggerNum, "E", (triggerTimeout _x)]] call _inidbi;
	//triggerTimeoutCurrent 
	["write", [_triggerNum, "F", triggerTimeoutCurrent _x]] call _inidbi;

	//trick arma to give attached vehicle
	_cat = triggerActivation _x;
	_dog = triggerActivation _x;
	_cat set [0,"VEHICLE"];
	_x setTriggerActivation _cat;
	_TAV = triggerAttachedVehicle _x;
	_x setTriggerActivation _dog;

	//triggerAttachedVehicle triggerAttachVehicle
	["write", [_triggerNum, "G", ((_TAV) getVariable["MSLName",""])]] call _inidbi;

	//vars
	// _allVars = [];
	// _object = _x;
	// {
	// 	if (typeName (_object getVariable[_x,[]]) in ["SCALAR","STRING","BOOL","TEXT","CODE"]) then {
	// 		_allVars append [[_x,_object getVariable[_x,""]]];
	// 	};
	// } forEach allVariables _x;
	// ["write", [_triggerNum, "X", _allVars]] call _inidbi;
	
	_x setVariable ["MSLID",_forEachIndex];
	_x setVariable ["MSLName",_triggerNum];

MSLPROGRESS = MSLPROGRESS + 0.001;
publicVariable "MSLPROGRESS";
}forEach _allMissionObjectsTrigger;

MSLPROGRESS = 0.6;
publicVariable "MSLPROGRESS";

//markers - L
{
	_markerNum = "L" + (str _forEachIndex);
	//markerType setMarkerType
	["write", [_markerNum, "Y", markerType _x]] call _inidbi;
	//markerText setMarkerText
	["write", [_markerNum, "T", markerText _x]] call _inidbi;
	//_x  createMarker
	["write", [_markerNum, "N", _x]] call _inidbi;
	//markerPos setMarkerPos
	["write", [_markerNum, "P", toString (markerPos _x)]] call _inidbi;
	//markerSize setMarkerSize
	["write", [_markerNum, "Z", markerSize _x]] call _inidbi;
	//markerDir setMarkerDir
	["write", [_markerNum, "D", markerDir _x]] call _inidbi;
	//markerBrush setMarkerBrush
	["write", [_markerNum, "B", markerBrush _x]] call _inidbi;
	//markerColor setMarkerColor
	["write", [_markerNum, "C", markerColor _x]] call _inidbi;
	//markerAlpha setMarkerAlpha
	["write", [_markerNum, "A", markerAlpha _x]] call _inidbi;
	//markerShape setMarkerShape
	["write", [_markerNum, "S", markerShape _x]] call _inidbi;

MSLPROGRESS = MSLPROGRESS + 0.001;
publicVariable "MSLPROGRESS";
} forEach allMapMarkers;

MSLPROGRESS = 0.7;
publicVariable "MSLPROGRESS";

//tasks - K
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
	_taskNum = "K" + (str _forEachIndex);
	//units
	["write", [_taskNum, "U", _units]] call _inidbi;
	//id
	//_task call BIS_fnc_taskVar
	["write", [_taskNum, "I", (str _x)]] call _inidbi;
	//description
	["write", [_taskNum, "Z", (_task call BIS_fnc_taskDescription)]] call _inidbi;
	//destination
	["write", [_taskNum, "D", (_task call BIS_fnc_taskDestination)]] call _inidbi;
	//taskState
	["write", [_taskNum, "S", _task call BIS_fnc_taskState]] call _inidbi;


	["write", [_taskNum, "Y", _syncedUnits]] call _inidbi;
	["write", [_taskNum, "O", (_x getVariable ["owner",-1])]] call _inidbi;
	
	//vars
	_allVars = [];
	_object = _x;
	{
		if (typeName (_object getVariable[_x,[]]) in ["SCALAR","STRING","BOOL","TEXT","CODE"]) then {
			_allVars append [[_x,_object getVariable[_x,""]]];
		};
	} forEach (allVariables _x);
	["write", [_taskNum, "A", _allVars]] call _inidbi;

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
			_triggerStr = "T" + (str _triggerNum);
			// Current result is saved in variable _x
			["write", [_taskNum, _triggerStr + "I", _x getVariable["MSLID",-1]]] call _inidbi;
			["write", [_taskNum, _triggerStr + "S", _taskStateModule getVariable["state","CREATED"]]] call _inidbi;
//["write", ["TEST", "TEST3", _triggerNum]] call _inidbi;
			_triggerNum = _triggerNum + 1;
		} forEach ((synchronizedObjects _x) arrayIntersect (_allMissionObjectsTrigger));
//["write", ["TEST", "TEST2", str _x]] call _inidbi;
	} forEach ((synchronizedObjects (_taskObj)) arrayIntersect (_allMissionObjectsTaskStates));
//["write", ["TEST", "TEST1", str _x]] call _inidbi;
MSLPROGRESS = MSLPROGRESS + 0.001;
publicVariable "MSLPROGRESS";
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

//logics/modules - J
{
	_logicNum = "J" + (str _forEachIndex);
	["write", [_logicNum, "T", typeOf _x]] call _inidbi;

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
	["write", [_logicNum, "V", _allVars]] call _inidbi;
MSLPROGRESS = MSLPROGRESS + 0.001;
publicVariable "MSLPROGRESS";
} forEach _allMissionObjectsLogic;

MSLPROGRESS = 0.9;
publicVariable "MSLPROGRESS";

//missionNamespace and Locations - P
_allLocationTypes = [];
"_allLocationTypes pushBack configName _x" configClasses (
	configFile >> "CfgLocationTypes"
);
_locationIndex = 0;
{
	_x setVariable ["MSL",true];
	if (_x getVariable "MSL") then {
		_locationID = "P" + (str _locationIndex);
		["write", [_locationID, "N", text  _x]] call _inidbi;
		["write", [_locationID, "S", str (side  _x)]] call _inidbi;
		["write", [_locationID, "P", locationPosition  _x]] call _inidbi;
		["write", [_locationID, "Z", size  _x]] call _inidbi;
		["write", [_locationID, "T", type  _x]] call _inidbi;
		
		//vars
		_allVars = [];
		_loc = _x;
		{
			if (typeName (_loc getVariable[_x,[]]) in ["SCALAR","STRING","BOOL","TEXT","CODE"]) then {
				_allVars append [[_x,_loc getVariable[_x,""]]];
			};
		} forEach allVariables _x;
		["write", [_locationID, "V", _allVars]] call _inidbi;
		
		_locationIndex = _locationIndex + 1;
	};
MSLPROGRESS = MSLPROGRESS + 0.001;
publicVariable "MSLPROGRESS";
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

//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

} else {

//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
MSLPROGRESS = 0;
publicVariable "MSLPROGRESS";

_allMissionObjectsAll = allMissionObjects "all";
_allMissionObjectsThing = allMissionObjects "thing";
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



//if (!("exists" call _inidbi)) then {};
_inidbiSAVELIST = ["new", "SAVELIST"] call OO_INIDBI;

_dateTime = "getTimeStamp" call _inidbiSAVELIST;
//_dateTimeString = str _dateTime;
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

MSLPROGRESS = 0.05;
publicVariable "MSLPROGRESS";

//_dateTimeString = "real_date" callExtension "+";
//_dateTime = parseSimpleArray (_dateTimeString);

//_dateTime = "getTimeStamp" call _inidbi;

_inidbi = ["new", _saveName] call OO_INIDBI;
	

//missionNamespace
_MISSIONNAMESPACE = "N";
_allVars = [];
{
	if ((typeName (missionNamespace getVariable[_x,[]]) in ["SCALAR","STRING","BOOL","TEXT"]) and ((_x find "MSL")!=0) and ((_x find "msl")!=0) and ((_x find "bis_")!=0) and ((_x find "oo_inidbi")!=0)) then {
		_allVars append [[_x,missionNamespace getVariable[_x,""]]];
MSLPROGRESS = MSLPROGRESS + 0.0005;
publicVariable "MSLPROGRESS";
	};
} forEach (allVariables missionNamespace);
["write", [_MISSIONNAMESPACE, "A", _allVars]] call _inidbi;
//hint (str _allVars);


MSLPROGRESS = 0.1;
publicVariable "MSLPROGRESS";

//MISSIONDETAILS 
_MISSIONDETAILS = "M";
["write", [_MISSIONDETAILS, "A", worldName]] call _inidbi;
["write", [_MISSIONDETAILS, "B", missionName]] call _inidbi;
["write", [_MISSIONDETAILS, "C", (toString date)]] call _inidbi;
//["write", [_MISSIONDETAILS, "accTime", accTime]] call _inidbi;
//["write", [_MISSIONDETAILS, "date", date]] call _inidbi;
["write", [_MISSIONDETAILS, "D", timeMultiplier]] call _inidbi;
["write", [_MISSIONDETAILS, "E", wind]] call _inidbi;
["write", [_MISSIONDETAILS, "F", waves]] call _inidbi;
["write", [_MISSIONDETAILS, "G", viewDistance]] call _inidbi;
["write", [_MISSIONDETAILS, "H", rainbow]] call _inidbi;
["write", [_MISSIONDETAILS, "I", lightnings]] call _inidbi;
["write", [_MISSIONDETAILS, "J", fog]] call _inidbi;
//["write", [_MISSIONDETAILS, "fogForecast", fogForecast]] call _inidbi;
["write", [_MISSIONDETAILS, "K", nextWeatherChange]] call _inidbi;
["write", [_MISSIONDETAILS, "L", overcast]] call _inidbi;
["write", [_MISSIONDETAILS, "M", rain]] call _inidbi;
//["write", [_MISSIONDETAILS, "humidity", humidity]] call _inidbi;
["write", [_MISSIONDETAILS, "N", gusts]] call _inidbi;
["write", [_MISSIONDETAILS, "O", getMissionDLCs]] call _inidbi;
["write", [_MISSIONDETAILS, "P", west getFriend east]] call _inidbi;
["write", [_MISSIONDETAILS, "Q", west getFriend independent]] call _inidbi;
["write", [_MISSIONDETAILS, "R", west getFriend civilian]] call _inidbi;
["write", [_MISSIONDETAILS, "S", east getFriend independent]] call _inidbi;
["write", [_MISSIONDETAILS, "T", east getFriend civilian]] call _inidbi;
["write", [_MISSIONDETAILS, "U", independent getFriend civilian]] call _inidbi;
//["write", [_MISSIONDETAILS, "V", diag_activeSQFScripts]] call _inidbi;
["write", [_MISSIONDETAILS, "W", toString environmentEnabled]] call _inidbi;
["write", [_MISSIONDETAILS, "X", isStressDamageEnabled]] call _inidbi;
["write", [_MISSIONDETAILS, "Y", 2]] call _inidbi; //version
["write", [_MISSIONDETAILS, "Z", _simple]] call _inidbi; //simple
//["write", [_MISSIONDETAILS, "cadetMode", cadetMode]] call _inidbi;

MSLPROGRESS = 0.2;
publicVariable "MSLPROGRESS";


//hidden buildings - H
_hiddenObjects = [];
if (_hiddenCheck) then {
	{
		//placed objects
		// if !(_x in nearestTerrainObjects[_x, [],0.1,false,true]) then
		// {_placedObjects pushBack _x;};
		//hidden map objects
		if (isObjectHidden _x)  then {
			_hiddenObjects pushBack _x;
		};
MSLPROGRESS = MSLPROGRESS + 0.0001;
publicVariable "MSLPROGRESS";
	}forEach (nearestObjects [[worldSize/2, worldSize/2], ["Building"], worldSize*2, false,true]);
	{
		["write", ["H" + (str _forEachIndex), "T" , (typeOf _x)]] call _inidbi;
		["write", ["H" + (str _forEachIndex), "P" , toString (getPos _x)]] call _inidbi;
MSLPROGRESS = MSLPROGRESS + 0.0001;
publicVariable "MSLPROGRESS";
	}forEach _hiddenObjects;
};

//things - Z
{
	if (alive _x) then {
	_thingNum = "Z" + (str _forEachIndex);
	["write", [_thingNum, "T" , typeOf _x]] call _inidbi;
	["write", [_thingNum, "P" , toString (getPos _x)]] call _inidbi;

	//vehicleVarName setVehicleVarName - do on all machines
	["write", [_thingNum, "N", (vehicleVarName _x)]] call _inidbi;
	//vectorDir  setVectorDir
	["write", [_thingNum, "D", (vectorDir _x)]] call _inidbi;
	//vectorUp setVectorUp
	["write", [_thingNum, "U", (vectorUp _x)]] call _inidbi;

	// vars
	_allVars = [];
	_object = _x;
	{
		if (typeName (_object getVariable[_x,[]]) in ["SCALAR","STRING","BOOL","TEXT","CODE"]) then {
			_allVars append [[_x,_object getVariable[_x,""]]];
		};
	} forEach allVariables _x;
	["write", [_thingNum, "V", _allVars]] call _inidbi;

	//set MSLID
	_x setVariable ["MSLID",_forEachIndex];
	_x setVariable ["MSLName",_thingNum];

MSLPROGRESS = MSLPROGRESS + 0.001;
publicVariable "MSLPROGRESS";
	};
}forEach _allMissionObjectsThing;

//air - A
{
	if (alive _x) then {
	_airNum = "A" + (str _forEachIndex);
	["write", [_airNum, "T" , typeOf _x]] call _inidbi;
	["write", [_airNum, "P" , toString (getPos _x)]] call _inidbi;
	["write", [_airNum, "S" , 
		["FORM","FLY"] select (((getPos _x) select 2)>5)
	]] call _inidbi;

	//vehicleVarName setVehicleVarName - do on all machines
	["write", [_airNum, "N", (vehicleVarName _x)]] call _inidbi;
	//vectorDir  setVectorDir
	["write", [_airNum, "D", (vectorDir _x)]] call _inidbi;
	//vectorUp setVectorUp
	["write", [_airNum, "U", (vectorUp _x)]] call _inidbi;

	//colour
	["write", [_airNum, "C" , ((getObjectTextures _x) select 0)]] call _inidbi;

	//vars
	_allVars = [];
	_object = _x;
	{
		if (typeName (_object getVariable[_x,[]]) in ["SCALAR","STRING","BOOL","TEXT","CODE"]) then {
			_allVars append [[_x,_object getVariable[_x,""]]];
		};
	} forEach allVariables _x;
	["write", [_airNum, "V", _allVars]] call _inidbi;

	//set MSLID
	_x setVariable ["MSLID",_forEachIndex];
	_x setVariable ["MSLName",_airNum];
MSLPROGRESS = MSLPROGRESS + 0.001;
publicVariable "MSLPROGRESS";
	};
}forEach _allMissionObjectsAir;

//cars - C
{
	if (alive _x) then {
	_carNum = "C" + (str _forEachIndex);
	["write", [_carNum, "T" , typeOf _x]] call _inidbi;
	["write", [_carNum, "P" , toString (getPos _x)]] call _inidbi;

	//vehicleVarName setVehicleVarName - do on all machines
	["write", [_carNum, "N", (vehicleVarName _x)]] call _inidbi;
	//vectorDir  setVectorDir
	["write", [_carNum, "D", (vectorDir _x)]] call _inidbi;
	//vectorUp setVectorUp
	["write", [_carNum, "U", (vectorUp _x)]] call _inidbi;

	//colour
	["write", [_carNum, "C" , ((getObjectTextures _x) select 0)]] call _inidbi;

	//vars
	_allVars = [];
	_object = _x;
	{
		if (typeName (_object getVariable[_x,[]]) in ["SCALAR","STRING","BOOL","TEXT","CODE"]) then {
			_allVars append [[_x,_object getVariable[_x,""]]];
		};
	} forEach allVariables _x;
	["write", [_carNum, "V", _allVars]] call _inidbi;

	//set MSLID
	_x setVariable ["MSLID",_forEachIndex];
	_x setVariable ["MSLName",_carNum];

MSLPROGRESS = MSLPROGRESS + 0.001;
publicVariable "MSLPROGRESS";
	};
}forEach (_allMissionObjectsCar);

//boats
{
	if (alive _x) then {
	_boatNum = "B" + (str _forEachIndex);
	["write", [_boatNum, "T" , typeOf _x]] call _inidbi;
	["write", [_boatNum, "P" , toString (getPos _x)]] call _inidbi;

	//vehicleVarName setVehicleVarName - do on all machines
	["write", [_boatNum, "N", (vehicleVarName _x)]] call _inidbi;
	//vectorDir  setVectorDir
	["write", [_boatNum, "D", (vectorDir _x)]] call _inidbi;
	//vectorUp setVectorUp
	["write", [_boatNum, "U", (vectorUp _x)]] call _inidbi;

	//colour
	["write", [_boatNum, "C" , ((getObjectTextures _x) select 0)]] call _inidbi;

	//vars
	_allVars = [];
	_object = _x;
	{
		if (typeName (_object getVariable[_x,[]]) in ["SCALAR","STRING","BOOL","TEXT","CODE"]) then {
			_allVars append [[_x,_object getVariable[_x,""]]];
		};
	} forEach allVariables _x;
	["write", [_boatNum, "V", _allVars]] call _inidbi;

	//set MSLID
	_x setVariable ["MSLID",_forEachIndex];
	_x setVariable ["MSLName",_boatNum];

MSLPROGRESS = MSLPROGRESS + 0.001;
publicVariable "MSLPROGRESS";
	};
}forEach _allMissionObjectsBoat;

//buildings - S
{
	if (alive _x) then {
	_buildingNum = "S" + (str _forEachIndex);
	["write", [_buildingNum, "T" , typeOf _x]] call _inidbi;
	["write", [_buildingNum, "P" , toString (getPos _x)]] call _inidbi;

	//vehicleVarName setVehicleVarName - do on all machines
	["write", [_buildingNum, "N", (vehicleVarName _x)]] call _inidbi;
	//vectorDir  setVectorDir
	["write", [_buildingNum, "D", (vectorDir _x)]] call _inidbi;
	//vectorUp setVectorUp
	["write", [_buildingNum, "U", (vectorUp _x)]] call _inidbi;

	//vars
	_allVars = [];
	_object = _x;
	{
		
		if (typeName (_object getVariable[_x,[]]) in ["SCALAR","STRING","BOOL","TEXT","CODE"]) then {
			_allVars append [[_x,_object getVariable[_x,""]]];
		};
	} forEach allVariables _x;
	["write", [_buildingNum, "V", _allVars]] call _inidbi;

	//set MSLID
	_x setVariable ["MSLID",_forEachIndex];
	_x setVariable ["MSLName",_buildingNum];

MSLPROGRESS = MSLPROGRESS + 0.001;
publicVariable "MSLPROGRESS";
	};
}forEach _allMissionObjectsBuilding;

MSLPROGRESS = 0.3;
publicVariable "MSLPROGRESS";

//units - U
{
	_unitNum = "U" + (str _forEachIndex);
	["write", [_unitNum, "A", typeOf _x]] call _inidbi;//typeOf
	["write", [_unitNum, "B", toString (getPos _x)]] call _inidbi;//position
	["write", [_unitNum, "C", (leader _x == _x)]] call _inidbi;//leader
	["write", [_unitNum, "D", (isPlayer _x)]] call _inidbi;//isPlayer
	// if (isMultiplayer) then {
	// 	["write", [_unitNum, "isPlayable", (_x in playableUnits)]] call _inidbi;//isPlayable
	// } else {
	// 	["write", [_unitNum, "isPlayable", (_x in switchableUnits)]] call _inidbi;//isPlayable
	// };
	["write", [_unitNum, "E", ((_x getVariable["MSLPlayable",false]) or (_x in playableUnits) or (_x in switchableUnits))]] call _inidbi;
	["write", [_unitNum, "F", (skill _x)]] call _inidbi;//skill
	["write", [_unitNum, "G", (rank _x)]] call _inidbi;//rank

	// = uniform player;
	["write", [_unitNum, "H", (uniform _x)]] call _inidbi;
	// = vest player;
	["write", [_unitNum, "I", (vest _x)]] call _inidbi;
	// = backpack player;
	["write", [_unitNum, "J", (backpack _x)]] call _inidbi;
	// = weaponsItems player;
	["write", [_unitNum, "K", (weaponsItems _x)]] call _inidbi;
	// = uniformItems player;
	["write", [_unitNum, "L", (uniformItems _x)]] call _inidbi;
	// = vestItems player;
	["write", [_unitNum, "M", (vestItems _x)]] call _inidbi;
	// = backpackItems player;
	["write", [_unitNum, "N", (backpackItems _x)]] call _inidbi;
	// = assignedItems player;
	["write", [_unitNum, "O", (assignedItems _x)]] call _inidbi;
	// = headgear player;
	["write", [_unitNum, "P", (headgear _x)]] call _inidbi;
	// = goggles player;
	["write", [_unitNum, "Q", (goggles _x)]] call _inidbi;

	//unit init - impossible

	//name  setName
	["write", [_unitNum, "R", (name _x)]] call _inidbi;
	//face setFace
	["write", [_unitNum, "S", (face _x)]] call _inidbi;
	//speaker setSpeaker
	["write", [_unitNum, "T", (speaker _x)]] call _inidbi;
	//pitch setPitch
	["write", [_unitNum, "U", (pitch _x)]] call _inidbi;
	//nameSound setNameSound
	["write", [_unitNum, "V", (nameSound _x)]] call _inidbi;
	//player call BIS_fnc_getUnitInsignia; [this,"111thID"] call BIS_fnc_setUnitInsignia;
	["write", [_unitNum, "W", _x call BIS_fnc_getUnitInsignia]] call _inidbi;

	//stance - player playAction "PlayerProne"; _soldier setUnitPos "UP";
	["write", [_unitNum, "X", (stance _x)]] call _inidbi;

	//vehicleVarName setVehicleVarName - do on all machines
	["write", [_unitNum, "Y", (vehicleVarName _x)]] call _inidbi;
	//vectorDir  setVectorDir
	["write", [_unitNum, "Z", (vectorDir _x)]] call _inidbi;
	//vectorUp setVectorUp
	["write", [_unitNum, "0", (vectorUp _x)]] call _inidbi;
	//roleDescription - no set
	["write", [_unitNum, "1", (roleDescription _x)]] call _inidbi;
	//damage setDamage
	["write", [_unitNum, "2", (damage _x)]] call _inidbi;
	//getAllHitPointsDamage  setHitIndex or setHitPointDamage
	["write", [_unitNum, "3", (getAllHitPointsDamage _x)]] call _inidbi;
	//canTriggerDynamicSimulation triggerDynamicSimulation
	["write", [_unitNum, "4", (canTriggerDynamicSimulation _x)]] call _inidbi;
	//simulationEnabled enableSimulation
	["write", [_unitNum, "5", (simulationEnabled _x)]] call _inidbi;
	//isObjectHidden hideObjectGlobal 
	["write", [_unitNum, "6", (isObjectHidden _x)]] call _inidbi;
	//isDamageAllowed allowDamage
	["write", [_unitNum, "7", (isDamageAllowed _x)]] call _inidbi;
	//isStaminaEnabled enableStamina
	["write", [_unitNum, "8", (isStaminaEnabled _x)]] call _inidbi;
	//
	//vehicleReportOwnPosition setVehicleReportOwnPosition
	["write", [_unitNum, "9", (vehicleReportOwnPosition _x)]] call _inidbi;
	//vehicleReportRemoteTargets setVehicleReceiveRemoteTargets
	["write", [_unitNum, "10", (vehicleReportRemoteTargets _x)]] call _inidbi;
	//vehicleReceiveRemoteTargets setVehicleReceiveRemoteTargets
	["write", [_unitNum, "11", (vehicleReceiveRemoteTargets _x)]] call _inidbi;

	//vehicle
	if (vehicle _x != _x) then {
		if ((vehicle _x) in (_allMissionObjectsAir)) then {
			["write", [_unitNum, "12", "AIR"]] call _inidbi;//air
		};
		if ((vehicle _x) in (_allMissionObjectsBoat)) then {
			["write", [_unitNum, "12", "Ship"]] call _inidbi;//boat
		};
		if ((vehicle _x) in (_allMissionObjectsCar)) then {
			["write", [_unitNum, "12", "LandVehicle"]] call _inidbi;//car
		};
		["write", [_unitNum, "13", (vehicle _x) getVariable ["MSLID",0]]] call _inidbi;//car ID
		["write", [_unitNum, "14", (vehicle _x) getCargoIndex _x]] call _inidbi;//car seat
	};

	//vars
	_allVars = [];
	_object = _x;
	{
		if (typeName (_object getVariable[_x,[]]) in ["SCALAR","STRING","BOOL","TEXT","CODE"]) then {
			_allVars append [[_x,_object getVariable[_x,""]]];
		};
	} forEach allVariables _x;
	["write", [_unitNum, "15", _allVars]] call _inidbi;
	
	_x setVariable ["MSLID",_forEachIndex];//MSLID
	_x setVariable ["MSLName",_unitNum];

MSLPROGRESS = MSLPROGRESS + 0.001;
publicVariable "MSLPROGRESS";
}forEach _allUnitsNotOnTheBus;

MSLPROGRESS = 0.4;
publicVariable "MSLPROGRESS";

//groups - G
_groupIndex = 0;
{
	if ((count (units _x))>0) then {
	_groupID = "G" + (str _groupIndex);
	["write", [_groupID, "S", str (side _x)]] call _inidbi;
	{
		["write", [_groupID, "U" + (str _forEachIndex), _x getVariable "MSLID"]] call _inidbi;
	}forEach (units _x);

	//group name
	["write", [_groupID, "Z", groupId  _x]] call _inidbi;

	//waypoints
	{
		_waypointNum = (str _forEachIndex);
		//waypointPosition
		["write", [_groupID, "P" + _waypointNum, waypointPosition _x]] call _inidbi;
		//waypointHousePosition setWaypointHousePosition
		//["write", [_groupID, "waypointHousePosition" + _waypointNum, waypointHousePosition  _x]] call _inidbi;
		//waypointDescription setWaypointDescription
		["write", [_groupID, "D" + _waypointNum, waypointDescription  _x]] call _inidbi;
		//waypointName  setWaypointName
		["write", [_groupID, "N" + _waypointNum, waypointName  _x]] call _inidbi;
		//waypointCompletionRadius setWaypointCompletionRadius
		["write", [_groupID, "R" + _waypointNum, waypointCompletionRadius  _x]] call _inidbi;
		//waypointCombatMode setWaypointCombatMode
		["write", [_groupID, "C" + _waypointNum, waypointCombatMode  _x]] call _inidbi;
		//waypointBehaviour setWaypointBehaviour
		["write", [_groupID, "B" + _waypointNum, waypointBehaviour  _x]] call _inidbi;
		//waypointFormation setWaypointFormation
		["write", [_groupID, "F" + _waypointNum, waypointFormation  _x]] call _inidbi;
		//waypointSpeed setWaypointSpeed
		["write", [_groupID, "A" + _waypointNum, waypointSpeed  _x]] call _inidbi;
		//waypointType setWaypointType
		["write", [_groupID, "T" + _waypointNum, waypointType  _x]] call _inidbi;
		//waypointVisible setWaypointVisible
		["write", [_groupID, "V" + _waypointNum, waypointVisible  _x]] call _inidbi;
		//waypointLoiterRadius setWaypointLoiterRadius
		["write", [_groupID, "L" + _waypointNum, waypointLoiterRadius  _x]] call _inidbi;
		//waypointLoiterType setWaypointLoiterType
		["write", [_groupID, "E" + _waypointNum, waypointLoiterType  _x]] call _inidbi;
		//waypointAttachedVehicle waypointAttachVehicle
		["write", [_groupID, "G" + _waypointNum, (waypointAttachedVehicle  _x) getVariable ["MSLName",""]]] call _inidbi;
		//waypointAttachedObject waypointAttachObject
		["write", [_groupID, "H" + _waypointNum, (waypointAttachedObject  _x) getVariable ["MSLName",""]]] call _inidbi;
		//waypointTimeout setWaypointTimeout
		["write", [_groupID, "I" + _waypointNum, (waypointTimeout  _x)]] call _inidbi;
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
		["write", [_groupID, "J" + _waypointNum, _syncWPs]] call _inidbi;
		//waypointStatements  setWaypointStatements
		["write", [_groupID, "K" + _waypointNum, (waypointStatements  _x)]] call _inidbi;
	}forEach (waypoints _x);

	//vars
	_allVars = [];
	_object = _x;
	{
		if (typeName (_object getVariable[_x,[]]) in ["SCALAR","STRING","BOOL","TEXT","CODE"]) then {
			_allVars append [[_x,_object getVariable[_x,""]]];
		};
	} forEach allVariables _x;
	["write", [_groupID, "M", _allVars]] call _inidbi;
	
	_x setVariable ["MSLID",_groupIndex];
	_x setVariable ["MSLName",_groupID];
	
	MSLPROGRESS = 0.4 + (1/(count _allGoodGroups));
	publicVariable "MSLPROGRESS";
	
	_groupIndex = _groupIndex + 1;
};

MSLPROGRESS = MSLPROGRESS + 0.001;
publicVariable "MSLPROGRESS";
}forEach _allGoodGroups;

MSLPROGRESS = 0.5;
publicVariable "MSLPROGRESS";

//triggers
{
	_triggerNum = "T" + (str _forEachIndex);
	//vehicleVarName setVehicleVarName
	["write", [_triggerNum, "V", vehicleVarName _x]] call _inidbi;
	//triggerText  setTriggerText
	["write", [_triggerNum, "T", triggerText _x]] call _inidbi;
	//getPos setPos
	["write", [_triggerNum, "P", toString (getPos _x)]] call _inidbi;
	//triggerArea setTriggerArea 
	["write", [_triggerNum, "A",  (triggerArea _x)]] call _inidbi;
	//triggerType setTriggerType
	["write", [_triggerNum, "Y", (triggerType _x)]] call _inidbi;
	//triggerActivation setTriggerActivation -local
	["write", [_triggerNum, "B", (triggerActivation _x)]] call _inidbi;
	//triggerActivated
	["write", [_triggerNum, "C", triggerActivated _x]] call _inidbi;
	//attachedObjects triggerAttachObject attachTo -needs changing
	//["write", [_triggerNum, "attachedObjects", (attachedObjects _x)]] call _inidbi;

	
	_syncs = [];
	{
		_object = _x getVariable["MSLName", ""];
		_syncs append [_object];
	} forEach (attachedObjects  _x);
	["write", [_triggerNum, "O", _syncs]] call _inidbi;

	
	_syncWPs = [];
	{
		_groupID = (_x select 0) getVariable["MSLID", -1];
		_wpNum = (_x select 1);
		_syncWPs append [[_groupID,_wpNum]];
	} forEach (synchronizedWaypoints  _x);
	["write", [_triggerNum, "W", _syncWPs]] call _inidbi;

	_syncs = [];
	{
		_object = _x getVariable["MSLName", ""];
		_syncs append [_object];
	} forEach (synchronizedObjects  _x);
	["write", [_triggerNum, "S", _syncs]] call _inidbi;

	//synchronizedWaypoints synchronizeWaypoint -needs changing
	//["write", [_triggerNum, "synchronizedWaypoints", (synchronizedWaypoints _x)]] call _inidbi;

	//synchronizedObjects  synchronizeObjectsAdd
	//["write", [_triggerNum, "synchronizedObjects", (synchronizedObjects _x)]] call _inidbi;
	//triggerStatements setTriggerStatements
	["write", [_triggerNum, "D", (triggerStatements _x)]] call _inidbi;
	//triggerTimeout setTriggerTimeout
	["write", [_triggerNum, "E", (triggerTimeout _x)]] call _inidbi;
	//triggerTimeoutCurrent 
	["write", [_triggerNum, "F", triggerTimeoutCurrent _x]] call _inidbi;

	//trick arma to give attached vehicle
	_cat = triggerActivation _x;
	_dog = triggerActivation _x;
	_cat set [0,"VEHICLE"];
	_x setTriggerActivation _cat;
	_TAV = triggerAttachedVehicle _x;
	_x setTriggerActivation _dog;

	//triggerAttachedVehicle triggerAttachVehicle
	["write", [_triggerNum, "G", ((_TAV) getVariable["MSLName",""])]] call _inidbi;

	//vars
	_allVars = [];
	_object = _x;
	{
		if (typeName (_object getVariable[_x,[]]) in ["SCALAR","STRING","BOOL","TEXT","CODE"]) then {
			_allVars append [[_x,_object getVariable[_x,""]]];
		};
	} forEach allVariables _x;
	["write", [_triggerNum, "X", _allVars]] call _inidbi;
	
	_x setVariable ["MSLID",_forEachIndex];
	_x setVariable ["MSLName",_triggerNum];

MSLPROGRESS = MSLPROGRESS + 0.001;
publicVariable "MSLPROGRESS";
}forEach _allMissionObjectsTrigger;

MSLPROGRESS = 0.6;
publicVariable "MSLPROGRESS";

//markers - L
{
	_markerNum = "L" + (str _forEachIndex);
	//markerType setMarkerType
	["write", [_markerNum, "Y", markerType _x]] call _inidbi;
	//markerText setMarkerText
	["write", [_markerNum, "T", markerText _x]] call _inidbi;
	//_x  createMarker
	["write", [_markerNum, "N", _x]] call _inidbi;
	//markerPos setMarkerPos
	["write", [_markerNum, "P", toString (markerPos _x)]] call _inidbi;
	//markerSize setMarkerSize
	["write", [_markerNum, "Z", markerSize _x]] call _inidbi;
	//markerDir setMarkerDir
	["write", [_markerNum, "D", markerDir _x]] call _inidbi;
	//markerBrush setMarkerBrush
	["write", [_markerNum, "B", markerBrush _x]] call _inidbi;
	//markerColor setMarkerColor
	["write", [_markerNum, "C", markerColor _x]] call _inidbi;
	//markerAlpha setMarkerAlpha
	["write", [_markerNum, "A", markerAlpha _x]] call _inidbi;
	//markerShape setMarkerShape
	["write", [_markerNum, "S", markerShape _x]] call _inidbi;

MSLPROGRESS = MSLPROGRESS + 0.001;
publicVariable "MSLPROGRESS";
} forEach allMapMarkers;

MSLPROGRESS = 0.7;
publicVariable "MSLPROGRESS";

//tasks - K
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
	_taskNum = "K" + (str _forEachIndex);
	//units
	["write", [_taskNum, "U", _units]] call _inidbi;
	//id
	//_task call BIS_fnc_taskVar
	["write", [_taskNum, "I", (str _x)]] call _inidbi;
	//description
	["write", [_taskNum, "Z", (_task call BIS_fnc_taskDescription)]] call _inidbi;
	//destination
	["write", [_taskNum, "D", (_task call BIS_fnc_taskDestination)]] call _inidbi;
	//taskState
	["write", [_taskNum, "S", _task call BIS_fnc_taskState]] call _inidbi;


	["write", [_taskNum, "Y", _syncedUnits]] call _inidbi;
	["write", [_taskNum, "O", (_x getVariable ["owner",-1])]] call _inidbi;
	
	//vars
	_allVars = [];
	_object = _x;
	{
		if (typeName (_object getVariable[_x,[]]) in ["SCALAR","STRING","BOOL","TEXT","CODE"]) then {
			_allVars append [[_x,_object getVariable[_x,""]]];
		};
	} forEach (allVariables _x);
	["write", [_taskNum, "A", _allVars]] call _inidbi;

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
			_triggerStr = "T" + (str _triggerNum);
			// Current result is saved in variable _x
			["write", [_taskNum, _triggerStr + "I", _x getVariable["MSLID",-1]]] call _inidbi;
			["write", [_taskNum, _triggerStr + "S", _taskStateModule getVariable["state","CREATED"]]] call _inidbi;
//["write", ["TEST", "TEST3", _triggerNum]] call _inidbi;
			_triggerNum = _triggerNum + 1;
		} forEach ((synchronizedObjects _x) arrayIntersect (_allMissionObjectsTrigger));
//["write", ["TEST", "TEST2", str _x]] call _inidbi;
	} forEach ((synchronizedObjects (_taskObj)) arrayIntersect (_allMissionObjectsTaskStates));
//["write", ["TEST", "TEST1", str _x]] call _inidbi;
MSLPROGRESS = MSLPROGRESS + 0.001;
publicVariable "MSLPROGRESS";
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

//logics/modules - J
{
	_logicNum = "J" + (str _forEachIndex);
	["write", [_logicNum, "T", typeOf _x]] call _inidbi;

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
	["write", [_logicNum, "V", _allVars]] call _inidbi;
MSLPROGRESS = MSLPROGRESS + 0.001;
publicVariable "MSLPROGRESS";
} forEach _allMissionObjectsLogic;

MSLPROGRESS = 0.9;
publicVariable "MSLPROGRESS";

//missionNamespace and Locations - P
_allLocationTypes = [];
"_allLocationTypes pushBack configName _x" configClasses (
	configFile >> "CfgLocationTypes"
);
_locationIndex = 0;
{
	_x setVariable ["MSL",true];
	if (_x getVariable "MSL") then {
		_locationID = "P" + (str _locationIndex);
		["write", [_locationID, "N", text  _x]] call _inidbi;
		["write", [_locationID, "S", str (side  _x)]] call _inidbi;
		["write", [_locationID, "P", locationPosition  _x]] call _inidbi;
		["write", [_locationID, "Z", size  _x]] call _inidbi;
		["write", [_locationID, "T", type  _x]] call _inidbi;
		
		//vars
		_allVars = [];
		_loc = _x;
		{
			if (typeName (_loc getVariable[_x,[]]) in ["SCALAR","STRING","BOOL","TEXT","CODE"]) then {
				_allVars append [[_x,_loc getVariable[_x,""]]];
			};
		} forEach allVariables _x;
		["write", [_locationID, "V", _allVars]] call _inidbi;
		
		_locationIndex = _locationIndex + 1;
	};
MSLPROGRESS = MSLPROGRESS + 0.001;
publicVariable "MSLPROGRESS";
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
};

