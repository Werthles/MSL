hint "Serverload";
//player setPos [1000,1000,1000];
params [["_clientID",-2,[0]],["_filename","filename",[""]]];

//safemode players
{
	_x setCaptive true;
	_x allowDamage false;
}forEach allPlayers;

//Delete Everything
{
	if !((typeOf _x)=="Logic") then {deleteVehicle _x;};
} forEach nearestObjects[[worldSize/2, worldSize/2], [], worldSize*2, false,true];
{deleteVehicle _x}forEach allUnits;
//Load everything
_inidbi = ["new", _filename] call OO_INIDBI;

//MISSIONDETAILS
_RworldName = ["read", ["MISSIONDETAILS", "worldName", ""]] call _inidbi;
if (_RworldName == worldName) then {
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

//buildings
{
	if ((_x find "OBJECT")>-1) then {
		(["read", [_x, "typeOf", ""]] call _inidbi) createVehicle (["read", [_x, "getPos", [0,0,0]]] call _inidbi);
	};
}forEach ("getSections" call _inidbi);
{
	if ((_x find "HIDDEN")>-1) then {
		hideObjectGlobal (nearestTerrainObjects [(["read", [_x, "getPos", [0,0,0]]] call _inidbi),[(["read", [_x, "typeOf", ""]] call _inidbi)],0.1] select 0);
	};
}forEach ("getSections" call _inidbi);

 
//units
_counter = 0;
while {["read", ["UNIT" + str _counter, "typeOf", ""]] call _inidbi != ""} do {

	_RtypeOf = ["read", ["UNIT" + (str _counter), "typeOf", ""]] call _inidbi;
	hint _RtypeOf;
	_Rposition = toArray (["read", ["UNIT" + (str _counter), "position", [0,0,0]]] call _inidbi);
	_counter = _counter + 1;

	_grp = createGroup west;
	_ap = _grp createUnit [ _RtypeOf, _Rposition, [], 0, "FORM"];
};

	[true,_Rdate] remoteExec ["Werthles_fnc_MSLLocalUpdates",0];
	[true] remoteExec ["Werthles_fnc_MSLLoadPlayer",_clientID];
}
else
{
	[false,"This save was on a different map!"] remoteExec ["Werthles_fnc_MSLLoadPlayer",_clientID];
};

//unsafemode players
{
	_x setCaptive false;
	_x allowDamage true;
}forEach allPlayers;

["delete", _inidbi] call OO_INIDBI;