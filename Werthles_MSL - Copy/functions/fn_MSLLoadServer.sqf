hint "Serverload";
//player setPos [1000,1000,1000];
params [["_clientID",-2,[0]],["_filename","filename",[""]]];

_inidbi = ["new", _filename] call OO_INIDBI;
_RworldName = ["read", ["MISSIONDETAILS", "worldName", ""]] call _inidbi;
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
{
	if !((typeOf _x)=="Logic") then {deleteVehicle _x;};
	_x setVariable ["MSLID", nil];
	_x setVariable ["MSLPlayer", nil];
	_x setVariable ["MSLPlayable", nil];
}forEach allMissionObjects "All";
{deleteVehicle _x}forEach allUnits;
{deleteGroup _x;}forEach allGroups;

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

//buildings
{
	if ((_x find "BUILDING")>-1) then {
		(["read", [_x, "typeOf", ""]] call _inidbi) createVehicle (toArray(["read", [_x, "position", [0,0,0]]] call _inidbi));
	};
}forEach ("getSections" call _inidbi);
// {
// 	if ((_x find "HIDDEN")>-1) then {
// 		hideObjectGlobal (nearestTerrainObjects [(["read", [_x, "position", [0,0,0]]] call _inidbi),[(["read", [_x, "typeOf", ""]] call _inidbi)],0.1] select 0);
// 	};
// }forEach ("getSections" call _inidbi);

//boats
_counter = 0;
while {["read", ["BOAT" + str _counter, "typeOf", ""]] call _inidbi != ""} do {

	_RtypeOf = ["read", ["BOAT" + (str _counter), "typeOf", ""]] call _inidbi;
	hint _RtypeOf;
	_Rposition = toArray (["read", ["BOAT" + (str _counter), "position", ""]] call _inidbi);

	_boat = createVehicle [_RtypeOf, _Rposition, [], 0, "FORM"];
	
	_boat setVariable ["MSLID",_counter];
	_counter = _counter + 1;
};

//air
_counter = 0;
while {["read", ["AIR" + str _counter, "typeOf", ""]] call _inidbi != ""} do {

	_RtypeOf = ["read", ["AIR" + (str _counter), "typeOf", ""]] call _inidbi;
	hint _RtypeOf;
	_Rposition = toArray (["read", ["AIR" + (str _counter), "position", ""]] call _inidbi);
	_Rspecial = (["read", ["AIR" + (str _counter), "special", "FORM"]] call _inidbi);

	_air = createVehicle [_RtypeOf, _Rposition, [], 0, _Rspecial];
	
	_air setVariable ["MSLID",_counter];
	_counter = _counter + 1;
};

//cars
_counter = 0;
while {["read", ["CAR" + str _counter, "typeOf", ""]] call _inidbi != ""} do {

	_RtypeOf = ["read", ["CAR" + (str _counter), "typeOf", ""]] call _inidbi;
	hint _RtypeOf;
	_Rposition = toArray (["read", ["CAR" + (str _counter), "position", ""]] call _inidbi);

	_car = createVehicle [_RtypeOf, _Rposition, [], 0, "FORM"];
	
	_car setVariable ["MSLID",_counter];
	_counter = _counter + 1;
};

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

	//units in group
	_counter2 = 0;
	while {(["read", ["GROUP" + (str _counter),"unit" + str _counter2, -1]] call _inidbi) != -1} do {
		_MSLID = str (["read", ["GROUP" + (str _counter),"unit" + str _counter2, -1]] call _inidbi);
		// _nextUnit = _grp createUnit [
		// 	["read", ["UNIT" + _MSLID, "typeOf", ""]] call _inidbi,
		// 	toArray (["read", ["UNIT" + _MSLID, "position", ""]] call _inidbi),
		// 	[],0,"NONE"
		// ];
		(["read", ["UNIT" + _MSLID, "typeOf", ""]] call _inidbi) createUnit [
			toArray (["read", ["UNIT" + _MSLID, "position", ""]] call _inidbi),
			_grp,
			"MSLnewUnit = this",
			(["read", ["UNIT" + _MSLID, "skill", 0.3]] call _inidbi),
			(["read", ["UNIT" + _MSLID, "rank", "PRIVATE"]] call _inidbi)
		];
		waitUntil { !(isNil "MSLnewUnit") };
		//sleep 0.01;
		hint str MSLnewUnit;
		if ((["read", ["UNIT" + _MSLID, "leader", false]] call _inidbi)) then {
			[_grp, MSLnewUnit] remoteExec ["selectLeader", groupOwner _grp];
		};
		
		MSLnewUnit setVariable ["MSLPlayer",(["read", ["UNIT" + _MSLID, "isPlayer", false]] call _inidbi)];
		MSLnewUnit setVariable ["MSLPlayable",(["read", ["UNIT" + _MSLID, "isPlayable", false]] call _inidbi)];

		if !(isMultiplayer) then {
			addSwitchableUnit MSLnewUnit;
		};


		if (["read", ["UNIT" + _MSLID, "vehicleType", ""]] call _inidbi != "") then {
			{
				if (_x getVariable ["MSLID",-1] == (["read", ["UNIT" + _MSLID, "vehicle", -2]] call _inidbi)) then {
					//MSLnewUnit moveInCargo [_x,(["read", ["UNIT" + _MSLID, "vehiclePosition", 0]] call _inidbi)];
					//MSLnewUnit assignAsCargoIndex [_x,(["read", ["UNIT" + _MSLID, "vehiclePosition", 0]] call _inidbi)];
					MSLnewUnit moveInAny _x;
				};
			}forEach allMissionObjects (["read", ["UNIT" + _MSLID, "vehicleType", ""]] call _inidbi);
		};

		//hint (["read", ["UNIT" + _MSLID, "typeOf", ""]] call _inidbi);
		//sleep 1;
		MSLnewUnit = nil;
		_counter2 = _counter2 + 1;
	};
	_counter = _counter + 1;
	deleteVehicle _dummy;
	_dummy = nil;
};

//move players
_playerList = []; 
_playerList2 = []; 
_playerList append allPlayers;
_playerList2 append allPlayers;
_counter = 0;
{
	if ((count (_playerList)) > 0) then{
		if (_x getVariable ["MSLPlayer",false]) then {
			[_x] remoteExec ["selectPlayer", owner (_playerList select 0)];
			_playerList deleteAt 0;
		};
	};
} forEach allMissionObjects "man";

if ((count(_playerList)) >0) then {
	{
		if ((count (_playerList)) > 0) then{
			if (!(_x getVariable ["MSLPlayable",false]) && !(isPlayer _x)) then {
				[_x] remoteExec ["selectPlayer", owner (_playerList select 0)];
				_playerList deleteAt 0;
			};
		};
	} forEach allMissionObjects "man";
};

if ((count(_playerList)) >0) then {
	_playerList join (allPlayers select 0);
};

[true,_Rdate] remoteExec ["Werthles_fnc_MSLLocalUpdates",0];
[true] remoteExec ["Werthles_fnc_MSLLoadPlayer",_clientID];
[] remoteExec ["Werthles_fnc_MSLpostInit",0];

//unsafemode players
{
	_x setCaptive false;
	_x allowDamage true;
}forEach allPlayers;

//delete old player units
{
	_x setCaptive true;
	_x setSkill 0;
	deleteVehicle _x;
} forEach _playerList2;


}
else
{
	[false,"This save was on a different map!"] remoteExec ["Werthles_fnc_MSLLoadPlayer",_clientID];
};

["delete", _inidbi] call OO_INIDBI;