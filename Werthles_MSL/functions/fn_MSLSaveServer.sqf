hint "Serversave";
params [["_clientID",-2,[0]]];
private ["_inidbi","_dateTime"];

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

_saveName = worldName + "_" + missionName + "_(" +
str(_dateTime select 2) + "." + str (_dateTime select 1) + "." + str (_dateTime select 0) + "_" + str(_dateTime select 3) +"." + str(_dateTime select 4) + "." + str(_dateTime select 5) + ")" ;

["write", [_newSaveNumber, "Filename", _saveName]] call _inidbiSAVELIST;



["delete", _inidbiSAVELIST] call OO_INIDBI;

//_dateTimeString = "real_date" callExtension "+";
//_dateTime = parseSimpleArray (_dateTimeString);

//_dateTime = "getTimeStamp" call _inidbi;

_inidbi = ["new", _saveName] call OO_INIDBI;
	
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
["write", ["MISSIONDETAILS", "toStringdiag_activeSQFScripts", toString diag_activeSQFScripts]] call _inidbi;
["write", ["MISSIONDETAILS", "environmentEnabled", toString environmentEnabled]] call _inidbi;
["write", ["MISSIONDETAILS", "isStressDamageEnabled", isStressDamageEnabled]] call _inidbi;
//["write", ["MISSIONDETAILS", "cadetMode", cadetMode]] call _inidbi;


//hidden buildings
_hiddenObjects = [];
//{
	//placed objects
	//if !(_x in nearestTerrainObjects[_x, [],0.1,false,true]) then
	//{_placedObjects pushBack _x;};
	//hidden map objects
// 	if (isObjectHidden _x)  then {
// 		_hiddenObjects pushBack _x;
// 	}
// }forEach (nearestObjects [[worldSize/2, worldSize/2], ["Building"], worldSize*2, false,true]);
{
	["write", ["HIDDEN" + str _forEachIndex, "typeOf" , typeOf _x]] call _inidbi;
	["write", ["HIDDEN" + str _forEachIndex, "position" , toString (getPos _x)]] call _inidbi;
}forEach _hiddenObjects;

//air
{
	["write", ["AIR" + str _forEachIndex, "typeOf" , typeOf _x]] call _inidbi;
	["write", ["AIR" + str _forEachIndex, "position" , toString (getPos _x)]] call _inidbi;
	["write", ["AIR" + str _forEachIndex, "special" , 
		["FORM","FLY"] select (((getPos _x) select 2)>5)
	]] call _inidbi;
}forEach allMissionObjects "air";

//cars
{
	["write", ["CAR" + str _forEachIndex, "typeOf" , typeOf _x]] call _inidbi;
	["write", ["CAR" + str _forEachIndex, "position" , toString (getPos _x)]] call _inidbi;
}forEach allMissionObjects "cars";

//boats
{
	["write", ["BOAT" + str _forEachIndex, "typeOf" , typeOf _x]] call _inidbi;
	["write", ["BOAT" + str _forEachIndex, "position" , toString (getPos _x)]] call _inidbi;
}forEach allMissionObjects "boats";

//buildings
{
	["write", ["BUILDING" + str _forEachIndex, "typeOf" , typeOf _x]] call _inidbi;
	["write", ["BUILDING" + str _forEachIndex, "position" , toString (getPos _x)]] call _inidbi;
}forEach allMissionObjects "Building";

//units
{
	["write", ["UNIT" + (str _forEachIndex), "typeOf", typeOf _x]] call _inidbi;
	["write", ["UNIT" + (str _forEachIndex), "position", toString (getPos _x)]] call _inidbi;
	["write", ["UNIT" + (str _forEachIndex), "leader", (leader _x == _x)]] call _inidbi;
	_x setVariable ["MSLID",_forEachIndex];
} forEach allUnits;

//groups
{
	_groupID = str _forEachIndex;
	if (count (units _x) > 0) then {["write", ["GROUP" + _groupID, "side", str (side _x)]] call _inidbi;};
	{
		["write", ["GROUP" + _groupID, "unit" + (str _forEachIndex), _x getVariable "MSLID"]] call _inidbi;
	}forEach units _x;
}forEach allGroups;

//local setups
{
	[] remoteExec ["Werthles_fnc_MSLLocal",_clientID];
}forEach allPlayers;

//close db
["delete", _inidbi] call OO_INIDBI;

//save completion
[] remoteExec ["Werthles_fnc_MSLSavePlayer",_clientID];