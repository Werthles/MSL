private ["_inidbi", "_RworldName", "_bus", "_RmissionName", "_RDate", "_Rdate", "_RwindDir", "_RfogForecast", "_Rgusts", "_RnextWeatherChange", "_RgetMissionDLCs", "_RtoStringdiag_activeSQFScripts", "_RcadetMode", "_building", "_counter", "_RtypeOf", "_Rposition", "_boat", "_Rspecial", "_air", "_car", "_grp", "_dummy", "_counter2", "_MSLID", "_ddd", "_damageArray", "_eee", "_counter3", "_wp", "_wpsToSync", "_groupIdToSync", "_wpNumToSync", "_playerList", "_playerList2", "_playerList3", "_playerCount", "_unitsOnBuses", "_i", "_del", "_counter4", "_trigger", "_objArray", "_attObj", "_counter5", "_marker", "_counter6", "_unitMSLNames", "_counter7", "_trigStatements", "_logicCenter", "_counter8", "_logic", "_logicGroup", "_units", "_vehicles"];

//hint "Serverload";
//params
params [["_clientID",-2,[0]],["_filename","filename",[""]],["_hiddenCheck",false,[false]],["_serverTriggerCheck",false,[false]]];

//inidbi2 setup
_inidbi = ["new", _filename] call OO_INIDBI;
_RworldName = ["read", ["MISSIONDETAILS", "worldName", ""]] call _inidbi;

//reset progress bar tracking variable
MSLPROGRESS = 0;
publicVariable "MSLPROGRESS";

//only load if mission was saved on the same map
if (_RworldName == worldName) then {

//safemode players
{
	_x setCaptive true;
	_x allowDamage false;
}forEach allPlayers;

//Delete Everything
//{
//	if !((typeOf _x)=="Logic") then {deleteVehicle _x;};
//} forEach nearestObjects[[worldSize/2, worldSize/2], [], worldSize*2, false,true];

//delete tasks - will this always delete all tasks?
{
	{
		_x call BIS_fnc_deleteTask;
	} forEach (_x call BIS_fnc_tasksUnit);
} forEach allUnits;
{
	[_x] join grpNull;
	(group _x) deleteGroupWhenEmpty true;
} forEach allUnits;
//delete allMissionObjects 
{
	_x setVariable ["MSLID", nil];
	_x setVariable ["MSLName", nil];
	//_x setVariable ["MSLPlayer", nil];
	//_x setVariable ["MSLPlayable", nil];
	deleteVehicle _x;
}forEach ((((((allMissionObjects "All") - allUnits) - MSLBUSES) - (allMissionObjects "Logic")) - (entities "HeadlessClient_F")) + (allMissionObjects "ModuleTaskCreate_F") + (allMissionObjects "ModuleTaskSetState_F") + (allMissionObjects "emptyDetector"));


//confirm trigger delete
{
	deleteVehicle _x;
}forEach allMissionObjects "emptyDetector";


//if unit was previously playable, or is playable/player, keep the unit
{
	_bus = objNull;
	if ((_x getVariable["MSLPlayable",false]) or (isPlayer _x) or (_x in allPlayers) or (_x in playableUnits)) then {
		{
			if ((count (crew (_x)))<18) exitWith {
				_bus = _x;
			};
		} forEach MSLBUSES;
		_x moveInAny _bus;
		_x setVariable ["MSLPlayable", false];
	}
	else {
		deleteVehicle _x;
	};
}forEach (allUnits - MSLBUSES - (entities "HeadlessClient_F"));


//confirm empty groups will be deleted
{ [_x, true] remoteExec ["deleteGroupWhenEmpty", 0];}forEach allGroups;


//deleteLocation
_allLocationTypes = [];
"_allLocationTypes pushBack configName _x" configClasses (
	configFile >> "CfgLocationTypes"
);
{deleteLocation _x;}
forEach nearestLocations [[worldSize/2, worldSize/2], _allLocationTypes, worldSize];

//increment progress
MSLPROGRESS = 0.1;
publicVariable "MSLPROGRESS";

//Load everything

//MISSIONDETAILS
//_RmissionName = ["read", ["MISSIONDETAILS", "missionName", ""]] call _inidbi;
//_RDate = ["read", ["MISSIONDETAILS", "Date", ""]] call _inidbi;
setAccTime (["read", ["MISSIONDETAILS", "accTime", 1]] call _inidbi);
_Rdate = ["read", ["MISSIONDETAILS", "date", 0]] call _inidbi;
setTimeMultiplier (["read", ["MISSIONDETAILS", "timeMultiplier", 0]] call _inidbi);
setWind ((["read", ["MISSIONDETAILS", "wind", [0,0,false]]] call _inidbi) set [2,false]);
//_RwindDir = ["read", ["MISSIONDETAILS", "windDir", 250]] call _inidbi;
0 setWaves (["read", ["MISSIONDETAILS", "waves", 0.1]] call _inidbi);
setViewDistance (["read", ["MISSIONDETAILS", "viewDistance", 2500]] call _inidbi);
0 setRainbow (["read", ["MISSIONDETAILS", "rainbow", 0.35]] call _inidbi);
0 setLightnings (["read", ["MISSIONDETAILS", "lightnings", 0]] call _inidbi);
0 setFog (["read", ["MISSIONDETAILS", "fog", 0]] call _inidbi);
//_RfogForecast = ["read", ["MISSIONDETAILS", "fogForecast", 0]] call _inidbi;
0 setOvercast (["read", ["MISSIONDETAILS", "overcast", 0]] call _inidbi);
0 setRain (["read", ["MISSIONDETAILS", "rain", 0]] call _inidbi);
//simulSetHumidity (["read", ["MISSIONDETAILS", "humidity", 0]] call _inidbi);
_Rgusts = ["read", ["MISSIONDETAILS", "gusts", 0]] call _inidbi;
forceWeatherChange;
simulWeatherSync;
//_RnextWeatherChange = ["read", ["MISSIONDETAILS", "nextWeatherChange", 1500]] call _inidbi;
//_RgetMissionDLCs = ["read", ["MISSIONDETAILS", "getMissionDLCs", []]] call _inidbi;
west setFriend [east,(["read", ["MISSIONDETAILS", "westgetFriendeast", 0]] call _inidbi)];
west setFriend [independent,(["read", ["MISSIONDETAILS", "westgetFriendindependent", 1]] call _inidbi)];
west setFriend [civilian,(["read", ["MISSIONDETAILS", "westgetFriendcivilian", 1]] call _inidbi)];
east setFriend [independent,(["read", ["MISSIONDETAILS", "eastgetFriendindependent", 0]] call _inidbi)];
east setFriend [civilian,(["read", ["MISSIONDETAILS", "eastgetFriendcivilian", 1]] call _inidbi)];
independent setFriend [civilian,(["read", ["MISSIONDETAILS", "independentgetFriendcivilian", 1]] call _inidbi)];
//_RtoStringdiag_activeSQFScripts = ["read", ["MISSIONDETAILS", "toStringdiag_activeSQFScripts", ""]] call _inidbi;
//enableEnvironment (toArray (["read", ["MISSIONDETAILS", "environmentEnabled", [true,true]]] call _inidbi));
enableStressDamage (["read", ["MISSIONDETAILS", "isStressDamageEnabled", false]] call _inidbi);
//_RcadetMode = ["read", ["MISSIONDETAILS", "cadetMode", true]] call _inidbi;

//increment progress
MSLPROGRESS = 0.2;
publicVariable "MSLPROGRESS";

//location
{
	if ((_x find "LOCATION")>-1) then {
		//_location = locationNull;
		// if ((text (nearestLocation [(["read", [_x, "locationPosition", []]] call _inidbi), (["read", [_x, "locationType", ""]] call _inidbi)])) == (["read", [_x, "locationName", ""]] call _inidbi)) then
		// {
		// 	_location = nearestLocation [(["read", [_x, "locationPosition", []]] call _inidbi), (["read", [_x, "locationType", ""]] call _inidbi)]
		// } else {
			_location = createLocation [
				(["read", [_x, "locationType", ""]] call _inidbi),
				(["read", [_x, "locationPosition", []]] call _inidbi),
				(["read", [_x, "locationSize", []]] call _inidbi) select 0,
				(["read", [_x, "locationSize", []]] call _inidbi) select 1
			];
		//};
		_location setText (["read", [_x, "locationName", ""]] call _inidbi);
		_location setSide (call(compile (["read", [_x, "locationside", ""]] call _inidbi)));
		{
			_location setVariable[_x select 0,_x select 1];
		} forEach (["read", [_x, "allVars", []]] call _inidbi);
	};
}forEach ("getSections" call _inidbi);

//missionNamespace
{
	missionNamespace setVariable[_x select 0,_x select 1];
} forEach (["read", ["MISSIONNAMESPACE", "allVars", []]] call _inidbi);
//increment progress
MSLPROGRESS = 0.25;
publicVariable "MSLPROGRESS";

//buildings
{
	if ((_x find "BUILDING")>-1) then {
		_building = (["read", [_x, "typeOf", ""]] call _inidbi) createVehicle (toArray(["read", [_x, "position", [0,0,0]]] call _inidbi));
		{
			_building setVariable[_x select 0,_x select 1];
		} forEach (["read", [_x, "allVars", []]] call _inidbi);
		_building setVectorDir (["read", [_x, "vectorDir", [0,0,0]]] call _inidbi);
		_building setVectorUp (["read", [_x, "vectorUp", [0,0,0]]] call _inidbi);
		_building setVariable ["MSLID", parseNumber (_x select [8])];
		_building setVariable ["MSLName", _x];
	};
}forEach ("getSections" call _inidbi);

//hidden
{
	if ((_x find "HIDDEN")>-1) then {
		hideObjectGlobal (nearestTerrainObjects [(["read", [_x, "position", [0,0,0]]] call _inidbi),[(["read", [_x, "typeOf", ""]] call _inidbi)],0.1] select 0);
	};
}forEach ("getSections" call _inidbi);

_vehicles = [];

//air
_counter = 0;
while {["read", ["AIR" + (str _counter), "typeOf", ""]] call _inidbi != ""} do {

	_RtypeOf = ["read", ["AIR" + (str _counter), "typeOf", ""]] call _inidbi;
	_Rposition = toArray (["read", ["AIR" + (str _counter), "position", ""]] call _inidbi);
	_Rspecial = (["read", ["AIR" + (str _counter), "special", "FORM"]] call _inidbi);

	_air = createVehicle [_RtypeOf, _Rposition, [], 0, _Rspecial];
	//_air enableSimulationGlobal false;
	_air setVectorDir (["read", ["AIR" + (str _counter), "vectorDir", [0,0,0]]] call _inidbi);
	_air setVectorUp (["read", ["AIR" + (str _counter), "vectorUp", [0,0,0]]] call _inidbi);
	_air setVehicleVarName (["read", ["AIR" + (str _counter), "vehicleVarName", ""]] call _inidbi);
missionNamespace setVariable ["AIR" + (str _counter), _air, true];
	
	{
		_air setVariable[_x select 0,_x select 1];
	} forEach (["read", ["AIR" + (str _counter), "allVars", []]] call _inidbi);
	_air setVariable ["MSLID", _counter];
	_air setVariable ["MSLName", "AIR" + (str _counter)];

	_air setObjectTextureGlobal [0,["read", ["CAR" + (str _counter), "colour", ""]] call _inidbi];

	_vehicles pushBack _air;
	_counter = _counter + 1;
};

//cars
_counter = 0;
while {(["read", ["CAR" + (str _counter), "typeOf", ""]] call _inidbi) != ""} do {

	_RtypeOf = ["read", ["CAR" + (str _counter), "typeOf", ""]] call _inidbi;
	_Rposition = toArray (["read", ["CAR" + (str _counter), "position", ""]] call _inidbi);

	_car = createVehicle [_RtypeOf, _Rposition, [], 0, "FORM"];
	//_car enableSimulationGlobal false;
	_car setVectorDir (["read", ["CAR" + (str _counter), "vectorDir", [0,0,0]]] call _inidbi);
	_car setVectorUp (["read", ["CAR" + (str _counter), "vectorUp", [0,0,0]]] call _inidbi);
	
	{
		_car setVariable[_x select 0,_x select 1];
	} forEach (["read", ["CAR" + (str _counter), "allVars", []]] call _inidbi);
	_car setVariable ["MSLID", _counter];
	_car setVariable ["MSLName", "CAR" + (str _counter)];

	_car setObjectTextureGlobal [0,["read", ["CAR" + (str _counter), "colour", ""]] call _inidbi];

	_vehicles pushBack _car;
	_counter = _counter + 1;
};

//boats
_counter = 0;
while {["read", ["BOAT" + (str _counter), "typeOf", ""]] call _inidbi != ""} do {

	_RtypeOf = ["read", ["BOAT" + (str _counter), "typeOf", ""]] call _inidbi;
	_Rposition = toArray (["read", ["BOAT" + (str _counter), "position", ""]] call _inidbi);

	_boat = createVehicle [_RtypeOf, _Rposition, [], 0, "FORM"];
	//_boat enableSimulationGlobal false;
	_boat setVectorDir (["read", ["BOAT" + (str _counter), "vectorDir", [0,0,0]]] call _inidbi);
	_boat setVectorUp (["read", ["BOAT" + (str _counter), "vectorUp", [0,0,0]]] call _inidbi);
	
	{
		_boat setVariable[_x select 0,_x select 1];
	} forEach (["read", ["BOAT" + (str _counter), "allVars", []]] call _inidbi);
	_boat setVariable ["MSLID", _counter];
	_boat setVariable ["MSLName", "BOAT" + (str _counter)];

	_boat setObjectTextureGlobal [0,["read", ["CAR" + (str _counter), "colour", ""]] call _inidbi];

	_vehicles pushBack _boat;
	_counter = _counter + 1;
};

//increment progress
MSLPROGRESS = 0.3;
publicVariable "MSLPROGRESS";

//groups
_counter = 0;
while {["read", ["GROUP" + (str _counter), "side", ""]] call _inidbi != ""} do {
	_grp = createGroup civilian;
	_dummy = objNull;
	switch (["read", ["GROUP" + (str _counter), "side", ""]] call _inidbi) do {
		case "WEST": { _grp = createGroup west;
			_dummy = _grp createUnit ["B_Soldier_VR_F",[worldSize/2,worldSize/2,0],[],worldSize/2,"NONE"];
			[_dummy] joinSilent _grp;
		};
		case "EAST": { _grp = createGroup east;
			_dummy = _grp createUnit ["O_Soldier_VR_F",[worldSize/2,worldSize/2,0],[],worldSize/2,"NONE"];
			[_dummy] joinSilent _grp;
		};
		case "GUER": { _grp = createGroup resistance;
			_dummy = _grp createUnit ["I_Soldier_VR_F",[worldSize/2,worldSize/2,0],[],worldSize/2,"NONE"];
			[_dummy] joinSilent _grp;
		};
		case "CIV": { _grp = createGroup civilian;
			_dummy = _grp createUnit ["C_Soldier_VR_F",[worldSize/2,worldSize/2,0],[],worldSize/2,"NONE"];
			[_dummy] joinSilent _grp;
		};
		default {_grp = createGroup west;
			_dummy = _grp createUnit ["B_Soldier_VR_F",[worldSize/2,worldSize/2,0],[],worldSize/2,"NONE"];
			[_dummy] joinSilent _grp;
		};
	};
	
	{
		_grp setVariable[_x select 0,_x select 1];
	} forEach (["read", ["GROUP" + (str _counter), "allVars", []]] call _inidbi);
	_grp setVariable ["MSLID", _counter];
	_grp setVariable ["MSLName", "GROUP" + (str _counter)];

	//units in group
	_counter2 = 0;
	while {(["read", ["GROUP" + (str _counter),"unit" + (str _counter2), -1]] call _inidbi) != -1} do {
		_MSLID = str (["read", ["GROUP" + (str _counter),"unit" + str _counter2, -1]] call _inidbi);
		
		MSLnewUnit = _grp createUnit [
			(["read", ["UNIT" + _MSLID, "typeOf", ""]] call _inidbi),
			toArray (["read", ["UNIT" + _MSLID, "position", ""]] call _inidbi),
			[],0,"NONE"];
		waitUntil { !(isNil "MSLnewUnit") };

		MSLnewUnit setSkill (["read", ["UNIT" + _MSLID, "skill", 0.3]] call _inidbi);

		MSLnewUnit setRank (["read", ["UNIT" + _MSLID, "rank", "PRIVATE"]] call _inidbi);
	
		//MSLIDs
		{
			MSLnewUnit setVariable[_x select 0,_x select 1];
		} forEach (["read", ["UNIT" + _MSLID, "allVars", []]] call _inidbi);
		MSLnewUnit setVariable ["MSLID", _MSLID];
		MSLnewUnit setVariable ["MSLName", "UNIT" + _MSLID];

		if ((["read", ["UNIT" + _MSLID, "leader", false]] call _inidbi)) then {
			[_grp, MSLnewUnit] remoteExec ["selectLeader", groupOwner _grp];
		};
		
		_ddd = (["read", ["UNIT" + _MSLID, "isPlayer", false]] call _inidbi);
		MSLnewUnit setVariable ["MSLPlayer",(_ddd or (isPlayer MSLnewUnit))];

		//gear
		removeAllAssignedItems MSLnewUnit;
		removeAllItems MSLnewUnit;
		removeAllWeapons MSLnewUnit;
		removeUniform MSLnewUnit;
		removeBackpack MSLnewUnit;
		removeVest MSLnewUnit;
		removeHeadgear MSLnewUnit;
		removeGoggles MSLnewUnit;

		MSLnewUnit forceAddUniform (["read", ["UNIT" + _MSLID, "uniform", ""]] call _inidbi);
		MSLnewUnit addVest (["read", ["UNIT" + _MSLID, "vest", ""]] call _inidbi);
		MSLnewUnit addBackpack (["read", ["UNIT" + _MSLID, "backpack", ""]] call _inidbi);
		
		{
			MSLnewUnit addItem _x;
			MSLnewUnit assignItem _x;
		}forEach (["read", ["UNIT" + _MSLID, "assignedItems", ""]] call _inidbi);
		
		{
			MSLnewUnit addWeapon (_x select 0);
			MSLnewUnit addWeaponItem [(_x select 0),(_x select 1)];
			MSLnewUnit addWeaponItem [(_x select 0),(_x select 2)];
			MSLnewUnit addWeaponItem [(_x select 0),(_x select 3)];
			MSLnewUnit addWeaponItem [(_x select 0),((_x select 4) select 0)];
			MSLnewUnit addWeaponItem [(_x select 0),(_x select 5)];
		}forEach (["read", ["UNIT" + _MSLID, "weaponsItems", ""]] call _inidbi);
		
		{
			MSLnewUnit addItemToUniform _x;
		}forEach (["read", ["UNIT" + _MSLID, "uniformItems", ""]] call _inidbi);
		
		{
			MSLnewUnit addItemToVest _x;
		}forEach (["read", ["UNIT" + _MSLID, "vestItems", ""]] call _inidbi);
		
		{
			MSLnewUnit addItemToBackpack _x;
		}forEach (["read", ["UNIT" + _MSLID, "backpackItems", ""]] call _inidbi);
		
		MSLnewUnit addHeadgear (["read", ["UNIT" + _MSLID, "headgear", ""]] call _inidbi);
		MSLnewUnit addGoggles (["read", ["UNIT" + _MSLID, "goggles", ""]] call _inidbi);

		MSLnewUnit setName (["read", ["UNIT" + _MSLID, "name", ""]] call _inidbi);
		MSLnewUnit setFace (["read", ["UNIT" + _MSLID, "face", ""]] call _inidbi);
		MSLnewUnit setSpeaker (["read", ["UNIT" + _MSLID, "speaker", ""]] call _inidbi);
		MSLnewUnit setPitch (["read", ["UNIT" + _MSLID, "pitch", ""]] call _inidbi);
		MSLnewUnit setNameSound (["read", ["UNIT" + _MSLID, "nameSound", ""]] call _inidbi);
		[MSLnewUnit,(["read", ["UNIT" + _MSLID, "UnitInsignia", ""]] call _inidbi)] call BIS_fnc_setUnitInsignia;
		MSLnewUnit setUnitPos (["read", ["UNIT" + _MSLID, "stance", ""]] call _inidbi);

		MSLnewUnit setVehicleVarName (["read", ["UNIT" + _MSLID, "vehicleVarName", ""]] call _inidbi);
missionNamespace setVariable ["UNIT" + _MSLID, MSLnewUnit, true];
		MSLnewUnit setVectorDir (["read", ["UNIT" + _MSLID, "vectorDir", ""]] call _inidbi);
		MSLnewUnit setVectorUp (["read", ["UNIT" + _MSLID, "vectorUp", ""]] call _inidbi);
		MSLnewUnit setDamage (["read", ["UNIT" + _MSLID, "damage", 0]] call _inidbi);
		MSLnewUnit triggerDynamicSimulation (["read", ["UNIT" + _MSLID, "canTriggerDynamicSimulation", ""]] call _inidbi);
		MSLnewUnit enableSimulation (["read", ["UNIT" + _MSLID, "simulationEnabled", ""]] call _inidbi);
		MSLnewUnit hideObjectGlobal (["read", ["UNIT" + _MSLID, "isObjectHidden", ""]] call _inidbi);
		MSLnewUnit allowDamage (["read", ["UNIT" + _MSLID, "isDamageAllowed", ""]] call _inidbi);
		MSLnewUnit enableStamina (["read", ["UNIT" + _MSLID, "isStaminaEnabled", ""]] call _inidbi);
		MSLnewUnit setVehicleReportOwnPosition (["read", ["UNIT" + _MSLID, "vehicleReportOwnPosition", ""]] call _inidbi);
		MSLnewUnit setVehicleReportRemoteTargets (["read", ["UNIT" + _MSLID, "vehicleReportRemoteTargets", ""]] call _inidbi);
		MSLnewUnit setVehicleReceiveRemoteTargets (["read", ["UNIT" + _MSLID, "vehicleReceiveRemoteTargets", ""]] call _inidbi);

		_damageArray = (["read", ["UNIT" + _MSLID, "getAllHitPointsDamage", []]] call _inidbi);
		{
			[MSLnewUnit, _x, ((_damageArray select 2) select _forEachIndex)] call BIS_fnc_setHitPointDamage;
		} forEach (_damageArray select 0);

		//playale stuff
		_eee = (["read", ["UNIT" + _MSLID, "isPlayable", false]] call _inidbi);
		MSLnewUnit setVariable ["MSLPlayable",(_eee or (MSLnewUnit in playableUnits))];
		waitUntil { ((MSLnewUnit getVariable "MSLPlayable") or !(MSLnewUnit getVariable "MSLPlayable"))};
		if (["read", ["UNIT" + _MSLID, "vehicleType", ""]] call _inidbi != "") then {
			{
				if (_x getVariable ["MSLID",-1] == (["read", ["UNIT" + _MSLID, "vehicle", -2]] call _inidbi)) then {
					//MSLnewUnit moveInCargo [_x,(["read", ["UNIT" + _MSLID, "vehiclePosition", 0]] call _inidbi)];
					//MSLnewUnit assignAsCargoIndex [_x,(["read", ["UNIT" + _MSLID, "vehiclePosition", 0]] call _inidbi)];
					MSLnewUnit moveInAny _x;
				};
			}forEach allMissionObjects (["read", ["UNIT" + _MSLID, "vehicleType", ""]] call _inidbi);
		};
		MSLnewUnit = nil;
		_counter2 = _counter2 + 1;
	};

	//add waypoints
	//setWaypointHousePosition
	_counter3 = 0;
	while {(["read", ["GROUP" + (str _counter),"waypointType" + (str _counter3), ""]] call _inidbi) != ""} do {
		_wp = _grp addWaypoint [(["read", ["GROUP" + (str _counter),"waypointPos" + (str _counter3), ""]] call _inidbi),0];
		//_wp setWaypointPosition (["read", ["GROUP" + (str _counter),"waypointPos" + (str _counter3), ""]] call _inidbi);
		//_wp setWaypointHousePosition (["read", ["GROUP" + (str _counter),"waypointHousePos" + (str _counter3), ""]] call _inidbi);
		_wp setWaypointDescription (["read", ["GROUP" + (str _counter),"waypointDescription" + (str _counter3), ""]] call _inidbi);
		_wp setWaypointName (["read", ["GROUP" + (str _counter),"waypointName" + (str _counter3), ""]] call _inidbi);
		_wp setWaypointCompletionRadius (["read", ["GROUP" + (str _counter),"waypointCompletionRadius" + (str _counter3), ""]] call _inidbi);
		_wp setWaypointCombatMode (["read", ["GROUP" + (str _counter),"waypointCombatMode" + (str _counter3), ""]] call _inidbi);
		_wp setWaypointBehaviour (["read", ["GROUP" + (str _counter),"waypointBehaviour" + (str _counter3), ""]] call _inidbi);
		_wp setWaypointFormation (["read", ["GROUP" + (str _counter),"waypointFormation" + (str _counter3), ""]] call _inidbi);
		_wp setWaypointSpeed (["read", ["GROUP" + (str _counter),"waypointSpeed" + (str _counter3), ""]] call _inidbi);
		_wp setWaypointType (["read", ["GROUP" + (str _counter),"waypointType" + (str _counter3), ""]] call _inidbi);
		if (_counter3 == 0) then {
			_wp setWaypointVisible false;
		} else {
			_wp setWaypointVisible (["read", ["GROUP" + (str _counter),"waypointVisible" + (str _counter3), ""]] call _inidbi);
		};
		
		_wp setWaypointLoiterRadius (["read", ["GROUP" + (str _counter),"waypointLoiterRadius" + (str _counter3), ""]] call _inidbi);
		_wp setWaypointLoiterType (["read", ["GROUP" + (str _counter),"waypointLoiterType" + (str _counter3), ""]] call _inidbi);
		//_wp waypointAttachVehicle (["read", ["GROUP" + (str _counter),"waypointAttachedVehicle" + (str _counter3), ""]] call _inidbi);
		{
			if ((_x getVariable ["MSLName","#"])==(["read", ["GROUP" + (str _counter),"waypointAttachedVehicle" + (str _counter3), ""]] call _inidbi)) then {
				_wp waypointAttachVehicle _x;
			};
			if ((_x getVariable ["MSLName","#"])==(["read", ["GROUP" + (str _counter),"waypointAttachedObject" + (str _counter3), ""]] call _inidbi)) then {
				_wp waypointAttachObject _x;
			};
		} forEach allMissionObjects "all";

		//_wp waypointAttachObject (["read", ["GROUP" + (str _counter),"waypointAttachedObject" + (str _counter3), ""]] call _inidbi);
		_wp setWaypointTimeout (["read", ["GROUP" + (str _counter),"waypointTimeout" + (str _counter3), ""]] call _inidbi);
		//_wp synchronizeTrigger (["read", ["GROUP" + (str _counter),"synchronizedTriggers" + (str _counter3), ""]] call _inidbi);
		//_wp synchronizeWaypoint (["read", ["GROUP" + (str _counter),"synchronizedWaypoints" + (str _counter3), ""]] call _inidbi);
		_wp setWaypointStatements (["read", ["GROUP" + (str _counter),"waypointStatements" + (str _counter3), ""]] call _inidbi);
		_wpsToSync = [];
		{
			_groupIdToSync = _x select 0;
			_wpNumToSync = _x select 1;
			{
				if ((_x getVariable ["_MSLID", -1]) == _groupIdToSync) then {
					_wpsToSync append [[_x, _wpNumToSync]];
				};
			} forEach allGroups;
		}forEach (["read", ["GROUP" + (str _counter),"synchronizedWaypoints" + (str _counter3), ""]] call _inidbi);
		_wp synchronizeWaypoint _wpsToSync;
	_counter3 = _counter3 + 1;
	};
	deleteWaypoint [_grp, 0];
	_counter = _counter + 1;
	//reset for next group
	deleteVehicle _dummy;
	_dummy = nil;
};

MSLPROGRESS = 0.4;
publicVariable "MSLPROGRESS";

//selectPlayer puts units in the same slot
//marker rectangle causes error with config rectange not found

_playerList = [];
_playerList2 = [];
_playerList3 = [];
_playerList append allPlayers;
_playerList2 append allPlayers;
_playerCount = count allPlayers;

_unitsTaken = [];

//find units to exclude
_unitsOnBuses = [];
{
	if ((vehicle _x) in MSLBUSES) then {
		_unitsOnBuses append [_x];
	};
} forEach allUnits;

{
	if ((_playerCount > 0) and !(_x in _unitsTaken)) then {
		if (_x getVariable ["MSLPlayer", false]) then {
			[_x] remoteExec ["selectPlayer",owner (_playerList2 select (_playerCount - 1))];
			_unitsTaken pushBack _x;
			[true,_Rdate,_x] remoteExec ["Werthles_fnc_MSLLocalUpdates",(owner (_playerList2 select (_playerCount - 1)))];
			_playerCount = _playerCount - 1;
		};
	};
}forEach (allUnits - _unitsOnBuses);

//assign players to units that were playable last time
_playerList3 append _playerList2;
{
	if ((_playerCount > 0) and !(_x in _unitsTaken)) then {
		if (_x getVariable["MSLPlayable",false]) then {
			_unitsTaken pushBack _x;
			[_x] remoteExec ["selectPlayer",owner (_playerList2 select (_playerCount - 1))];
			[true,_Rdate,_x] remoteExec ["Werthles_fnc_MSLLocalUpdates",(owner (_playerList2 select (_playerCount - 1)))];
			_playerCount = _playerCount - 1;
		};
	};
} forEach (allUnits - _unitsOnBuses);

while {_playerCount >0} do {
	_i = 0;
	playerToJoin = (allPlayers select _i);
	while {(playerToJoin in _unitsOnBuses)} do {
		_i = _i + 1;
		playerToJoin = (allPlayers select _i);
	};
	_MSLID = (playerToJoin getVariable ["MSLID",0]);
	(["read", ["UNIT" + _MSLID, "typeOf", ""]] call _inidbi) createUnit [
		toArray (["read", ["UNIT" + _MSLID, "position", ""]] call _inidbi),
		(group playerToJoin),
		"MSLnewUnit = this",
		(["read", ["UNIT" + _MSLID, "skill", 0.3]] call _inidbi),
		(["read", ["UNIT" + _MSLID, "rank", "PRIVATE"]] call _inidbi)
	];

//missionNamespace setVariable ["NEWUNIT" + (str _playerCount), MSLnewUnit, true];
	waitUntil { !(isNil "MSLnewUnit") };
	MSLnewUnit setVariable ["MSLPlayable",true];
	MSLnewUnit setVariable ["MSLPlayer",true];
	[MSLnewUnit] remoteExec ["selectPlayer",owner (_playerList2 select 0)];
	[true,_Rdate,MSLnewUnit] remoteExec ["Werthles_fnc_MSLLocalUpdates",(owner (_playerList2 select 0))];
	_del = _playerList2 deleteAt 0;

	MSLnewUnit = nil;
	_playerCount = _playerCount - 1;
};
// {
// 	_x enableSimulationGlobal true;
// 	{
// 		_x enableSimulationGlobal true;
// 	} forEach (crew _x);
// } forEach (_vehicles);

	
MSLPROGRESS = 0.5;
publicVariable "MSLPROGRESS";

//triggers
	AUNITS = [];
	ATRIGS = [];
_counter4 = 0;
while {(["read", ["TRIGGER" + (str _counter4), "triggerType", ""]] call _inidbi)!=""} do {
	_trigger = createTrigger [
"EmptyDetector",
toArray (["read", ["TRIGGER" + (str _counter4),"getPos", ""]] call _inidbi),
_serverTriggerCheck
	];

	_trigger setTriggerStatements (["read", ["TRIGGER" + (str _counter4),"triggerStatements", ""]] call _inidbi);
	_trigger setVehicleVarName (["read", ["TRIGGER" + (str _counter4),"vehicleVarName", ""]] call _inidbi);
missionNamespace setVariable ["TRIGGER" + (str _counter4), _trigger, true];
	_trigger setTriggerText (["read", ["TRIGGER" + (str _counter4),"triggerText", ""]] call _inidbi);
	_trigger setTriggerArea ((["read", ["TRIGGER" + (str _counter4),"triggerArea", ""]] call _inidbi));
	_trigger setTriggerTimeout (["read", ["TRIGGER" + (str _counter4),"triggerTimeout", ""]] call _inidbi);

	if ((["read", ["TRIGGER" + (str _counter4),"triggerAttachedVehicle", ""]] call _inidbi) != "") then {
		{
			//triggerAttachVehicle
			if ((_x getVariable ["MSLName","#"])==(["read", ["TRIGGER" + (str _counter4),"triggerAttachedVehicle", ""]] call _inidbi)) then {

				// hint (str _trigger);
				// sleep 2;
				// hint (str [vehicle _x]);
				_trigger triggerAttachVehicle [ _x];
				// sleep 2;
				// hint (str (triggerAttachedVehicle _trigger));
				// sleep 2;
				AUNITS append [(vehicle _x)];
				ATRIGS append [_trigger];
			};
		} forEach (allMissionObjects "all");
	};

	_trigger setTriggerActivation (["read", ["TRIGGER" + (str _counter4),"triggerActivation", []]] call _inidbi);

	if ((["read", ["TRIGGER" + (str _counter4),"triggerActivated", false]] call _inidbi)) then {
		_trigger setTriggerStatements ["true","",""];
		//hint "fefefe";
		//sleep 3;
		_trigger setTriggerStatements (["read", ["TRIGGER" + (str _counter4),"triggerStatements", ""]] call _inidbi);
	};

	//triggerAttachObject
	_objArray = [];
	{
		_attObj = _x;
		{
			if (_attObj == (_x getVariable["MSLName",""])) then {
				_trigger triggerAttachObject _x;
			};
		} forEach allMissionObjects "all";
	} forEach (["read", ["TRIGGER" + (str _counter4),"attachedObjects", []]] call _inidbi);

	//synchronizeObjectsAdd
	_objArray = [];
	{
		_attObj = _x;
		{
			if (_attObj == (_x getVariable["MSLName",""])) then {
				_objArray append [_x];
			};
		} forEach allMissionObjects "all";
	} forEach (["read", ["TRIGGER" + (str _counter4),"synchronizedObjects", []]] call _inidbi);
	_trigger synchronizeObjectsAdd _objArray;

	//synchronizeWaypoint
	_wpsToSync = [];
	{
		_groupIdToSync = _x select 0;
		_wpNumToSync = _x select 1;
		{
			if ((_x getVariable ["_MSLID", -1]) == _groupIdToSync) then {
				_wpsToSync append [[_x, _wpNumToSync]];
			};
		} forEach allGroups;
	}forEach (["read", ["TRIGGER" + (str _counter4),"synchronizedWaypoints", []]] call _inidbi);
	_trigger synchronizeWaypoint _wpsToSync;

	//vars
	{
		_trigger setVariable[_x select 0,_x select 1];
	} forEach (["read", ["TRIGGER" + (str _counter4), "allVars", []]] call _inidbi);
	_trigger setVariable ["MSLID", _counter4];
	_trigger setVariable ["MSLName", "TRIGGER" + (str _counter4)];

	_counter4 = _counter4 + 1;
};

MSLPROGRESS = 0.6;
publicVariable "MSLPROGRESS";

//markers
_counter5 = 0;
while {(["read", ["MARKER" + (str _counter5), "markerType", ""]] call _inidbi)!=""} do {
	_marker = createMarker [
		(["read", ["MARKER" + (str _counter5), "markerName", "MARKER" + (str _counter5)]] call _inidbi),
		toArray (["read", ["MARKER" + (str _counter5), "markerPos", ""]] call _inidbi)
	];

	if (((["read", ["MARKER" + (str _counter5),"markerType", ""]] call _inidbi) == "RECTANGLE") or ((["read", ["MARKER" + (str _counter5),"markerType", ""]] call _inidbi) == "ELLIPSE")) then {
		_marker setMarkerType "";
	} else {
		_marker setMarkerType (["read", ["MARKER" + (str _counter5),"markerType", ""]] call _inidbi);
	};
	
	_marker setMarkerShape (["read", ["MARKER" + (str _counter5),"markerShape", ""]] call _inidbi);
	_marker setMarkerText (["read", ["MARKER" + (str _counter5),"markerText", ""]] call _inidbi);
	_marker setMarkerSize (["read", ["MARKER" + (str _counter5),"markerSize", ""]] call _inidbi);
	_marker setMarkerDir (["read", ["MARKER" + (str _counter5),"markerDir", ""]] call _inidbi);
	_marker setMarkerBrush (["read", ["MARKER" + (str _counter5),"markerBrush", ""]] call _inidbi);
	_marker setMarkerColor (["read", ["MARKER" + (str _counter5),"markerColor", ""]] call _inidbi);
	_marker setMarkerAlpha (["read", ["MARKER" + (str _counter5),"markerAlpha", ""]] call _inidbi);

	_counter5 = _counter5 + 1;
};

_logicCenter = createCenter sideLogic; 

MSLPROGRESS = 0.7;
publicVariable "MSLPROGRESS";
//tasks
_counter6 = 0;
while {(["read", ["TASKS" + (str _counter6), "taskState", ""]] call _inidbi)!=""} do {

	 _unitMSLNames = (["read", ["TASKS" + (str _counter6), "units", []]] call _inidbi);
	// _units = [];
	// {
	// 	if ((_x getVariable ["MSLName",""]) in _unitMSLNames) then {
	// 		_units append [_x];
	// 	};
	// } forEach allUnits;

///////////////
_units = [];
_syncedUnitsObjects = [];
_syncedUnits = (["read", ["TASKS" + (str _counter6), "syncedUnits", 0]] call _inidbi);
	{
		if ((_x getVariable ["MSLName",""]) in _syncedUnits) then {
			_syncedUnitsObjects pushBackUnique _x;
		};
	} forEach allUnits;
	switch ((["read", ["TASKS" + (str _counter6), "owner", 0]] call _inidbi)) do {
		case 0: {
			{
				if ((_x getVariable ["MSLName",""]) in _unitMSLNames) then {
					_units pushBackUnique _x;
				};
			} forEach allUnits;
		};
		case 1: {
			{
				if (_x getVariable["MSLName",""] in _syncedUnits) then {
					_units pushBackUnique (group _x);
				};
			} forEach allUnits;
			};
		case 2: {
			{
				if (_x getVariable["MSLName",""] in _syncedUnits) then {
					_units pushBackUnique (side _x);
				};
			} forEach allUnits;
		};
		case 3: {
			_unitObjects = allUnits;
		 };
		case 4: {
			_units = [west];
		 };
		case 5: {
			_units = [east];
		 };
		case 6: {
			_units = [resistance];
		 };
		case 7: {
			_units = [civilian];
		 };
		case -1: {
			{
				if ((_x getVariable ["MSLName",""]) in _unitMSLNames) then {
					_units append [_x];
				};
			} forEach allUnits;
		};
	};

//////////////////////////////
_logicGroup = createGroup _logicCenter;

newTask = nil;

_grp = createGroup sideLogic; 
"ModuleTaskCreate_F" createUnit [ 
 (["read", ["TASKS" + (str _counter6), "destination", [0,0,0]]] call _inidbi), 
 _grp, 
 "this setVariable [""BIS_fnc_initModules_disableAutoActivation"", false, true]; newTask = this;" 
];

waitUntil { !(isNil "newTask") };
_logic = newTask;
//_logic = _logicGroup createUnit ["ModuleTaskCreate_F", [0,0,0], [], 0, "NONE"];
_logic setVehicleVarName (["read", ["TASKS" + (str _counter6), "id", "TASKS" + (str _counter6)]] call _inidbi); 
missionNamespace setVariable [(["read", ["TASKS" + (str _counter6), "id", "TASKS" + (str _counter6)]] call _inidbi), _logic, true];
//_logic setVariable ["BIS_fnc_initModules_disableAutoActivation", false, true];
{
	_logic setVariable[_x select 0,_x select 1];
} forEach (["read", ["TASKS" + (str _counter6), "allVars", []]] call _inidbi);
_logic setVariable ["MSLID", _counter6];
_logic setVariable ["MSLName", "TASKS" + (str _counter6)];

_logic synchronizeObjectsAdd _syncedUnitsObjects;

[_logic, _syncedUnitsObjects, true] call BIS_fnc_moduleTaskCreate;

// _logic setTaskState (["read", ["TASKS" + (str _counter6), "taskState", "CREATED"]] call _inidbi);
// _logic setSimpleTaskDescription (["read", ["TASKS" + (str _counter6), "description", ""]] call _inidbi);
///////////////////////////////

	// [_units,
	// (["read", ["TASKS" + (str _counter6), "id", "TASKS" + (str _counter6)]] call _inidbi),
	// (["read", ["TASKS" + (str _counter6), "description", ""]] call _inidbi),
	// (["read", ["TASKS" + (str _counter6), "destination", [0,0,0]]] call _inidbi),
	// (["read", ["TASKS" + (str _counter6), "taskState", "CREATED"]] call _inidbi),
	// 1,
	// true,
	// "",
	// true
	// ] call BIS_fnc_taskCreate;

	
	_counter7 = 0;
	while {(["read", ["TASKS" + (str _counter6), "trigger" + (str _counter7) + "State", ""]] call _inidbi)!=""} do {
		{
			if ((_x getVariable ["MSLID",-1]) == (["read", ["TASKS" + (str _counter6), "trigger" + (str _counter7) + "Id", -2]] call _inidbi)) then {
				_trigStatements = triggerStatements _x;
				_trigStatements set [1, (_trigStatements select 1) + "; [" 
				+ (str (["read", ["TASKS" + (str _counter6), "id", "TASKS" + (str _counter6)]] call _inidbi)) + ", " 
				+ (str (["read", ["TASKS" + (str _counter6), "trigger" + (str _counter7) + "State", ""]] call _inidbi)) + "] call BIS_fnc_taskSetState;"];
				_x setTriggerStatements _trigStatements;
			};
		} forEach allMissionObjects "emptyDetector";
		_counter7 = _counter7 + 1;
	};

	_counter6 = _counter6 + 1;
};
MSLPROGRESS = 0.8;
publicVariable "MSLPROGRESS";

//logics
_counter8 = 0;
while {(["read", ["LOGIC" + (str _counter8), "type", ""]] call _inidbi)!=""} do {
	//_logic = (["read", ["LOGIC" + (str _counter8), "type", ""]] call _inidbi) createVehicle [0,0,0];
	if ((["read", ["LOGIC" + (str _counter8), "type", ""]] call _inidbi)!="ModuleTaskCreate_F") then {
_logicGroup = createGroup _logicCenter;
_logic = _logicGroup createUnit [(["read", ["LOGIC" + (str _counter8), "type", ""]] call _inidbi), [0,0,0], [], 0, "NONE"];
_logic setVehicleVarName ("LOGIC" + (str _counter8)); 
missionNamespace setVariable ["LOGIC" + (str _counter8), _logic, true];
_logic setVariable ["BIS_fnc_initModules_disableAutoActivation", false, true];
{
	_logic setVariable[_x select 0,_x select 1];
} forEach (["read", ["LOGIC" + (str _counter8), "allVars", ""]] call _inidbi);
_logic setVariable ["MSLID", _counter8];
_logic setVariable ["MSLName", "LOGIC" + (str _counter8)];
	};
	_counter8 = _counter8 + 1;
};

MSLPROGRESS = 0.9;
publicVariable "MSLPROGRESS";

//unsafemode players
{
	_x setCaptive false;
	_x allowDamage true;
}forEach allPlayers;

//delete old player units
{
	_x setCaptive true;
	_x setSkill 0;
	//deleteVehicle _x;
	[_x] remoteExec ["deleteVehicle", owner _x];
} forEach _playerList2;

//remove tags
{
	// _x setVariable ["MSLID", nil];
	// _x setVariable ["MSLName", nil];
	// _x setVariable ["MSLPlayer", nil];
	//_x setVariable ["MSLPlayable", nil];
} forEach allMissionObjects "all";

//remove non-lobby-joinable units from the buses
{
	{
		if !(_x in playableUnits) then {
			deleteVehicle _x;
		};
	} forEach crew _x;
} forEach MSLBUSES;

[true] remoteExec ["Werthles_fnc_MSLLoadPlayer",_clientID];
}
else
{
	[false,"This save was on a different map!"] remoteExec ["Werthles_fnc_MSLLoadPlayer",_clientID];
};

["delete", _inidbi] call OO_INIDBI;

MSLPROGRESS = 1;
publicVariable "MSLPROGRESS";