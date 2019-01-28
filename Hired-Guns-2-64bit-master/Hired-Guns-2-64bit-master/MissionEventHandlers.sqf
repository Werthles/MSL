//MissionEventHandlers.sqf
//Runs on all machines
//Called from each machine
//Called by init.sqf
//Initialised all mission event scripts

addMissionEventHandler ["HandleDisconnect",{
	private ["_unit","_uid"];
	_unit = _this select 0;
	_uid = _this select 2;
	
	[_unit,_uid] execVM "OnPlayerLeaving.sqf";
}];

addMissionEventHandler ["EntityKilled",{
    //pvs
    private ["_killed", "_killer", "_oldUnit", "_killCount", "_ret","_uid"];

	_killed = _this select 0;
	_killer = _this select 1;
	_uid = getPlayerUID _killer;
	
	if ((isPlayer _killed) and (isPlayer _killer)) then
	{
	    [62,[name _killed,name _killer]] call Messages;
	};
	if (isServer) then
	{
		if (isPlayer _killer) then
		{
			if (_killed isKindOf "man") then
			{
				if ((side group _killed) == resistance) then
				{
					if (isPlayer _killed) then
					{
						if (_killed != _killer) then
						{
							[47,[name _killer,name _oldUnit]] remoteExec ["Messages",true];
							
							_killCount = [_uid, "KillCounts", "Players", "SCALAR"] call iniDB_read;
							_killCount = _killCount + 1;
							_ret = [_uid, "KillCounts", "Players", _killCount] call iniDB_write;
						}
						else
						{
							_killCount = [_uid, "KillCounts", "Suicides", "SCALAR"] call iniDB_read;
							_killCount = _killCount + 1;
							_ret = [_uid, "KillCounts", "Suicides", _killCount] call iniDB_write;
						};
					}
					else
					{
						_killCount = [_uid, "KillCounts", "Friendly", "SCALAR"] call iniDB_read;
						_killCount = _killCount + 1;
						_ret = [_uid, "KillCounts", "Friendly", _killCount] call iniDB_write;
					};
				}
				else
				{
					if ((side group _killed) == CIVILIAN) then
					{
						_killCount = [_uid, "KillCounts", "Civilian", "SCALAR"] call iniDB_read;
						_killCount = _killCount + 1;
						_ret = [_uid, "KillCounts", "Civilian", _killCount] call iniDB_write;
					}
					else
					{
						if (_killed isKindOf "animal") then
						{
							_killCount = [_uid, "KillCounts", "Animal", "SCALAR"] call iniDB_read;
							_killCount = _killCount + 1;
							_ret = [_uid, "KillCounts", "Animal", _killCount] call iniDB_write;
						}
						else
						{
							_killCount = [_uid, "KillCounts", "Enemy", "SCALAR"] call iniDB_read;
							_killCount = _killCount + 1;
							_ret = [_uid, "KillCounts", "Enemy", _killCount] call iniDB_write;
						};
					};
				};
			}
			else
			{
				if (_killed isKindOf "car") then
				{
					_killCount = [_uid, "KillCounts", "Car", "SCALAR"] call iniDB_read;
					_killCount = _killCount + 1;
					_ret = [_uid, "KillCounts", "Car", _killCount] call iniDB_write;
				}
				else
				{
					if (_killed isKindOf "plane") then
					{
						_killCount = [_uid, "KillCounts", "Plane", "SCALAR"] call iniDB_read;
						_killCount = _killCount + 1;
						_ret = [_uid, "KillCounts", "Plane", _killCount] call iniDB_write;
					};
				};
			};
		};
	};
}];

addMissionEventHandler ["EntityRespawned",{
    //pvs
	private ["_unit", "_oldUnit", "_handle", "_nul", "_date", "_closest", "_townName", "_seconds", "_secString","_uid"];
	
	_unit = _this select 0;
	
	if (_unit == player) then
	{
		_oldUnit = _this select 1;
		removeAllActions _oldUnit;
		_uid = getPlayerUID _unit;
		
		//hint "EntityRespawnedEntityRespawnedEntityRespawnedEntityRespawned";
		
		//removeAllActions _oldUnit;
		_unit addAction ["<t color='#FF0000'>Options (Shortcut ""U"")</t>",{_handle=createdialog "HG_GUIMain";},[],-9999,false,true,"buldTerrainRaise10cm"];

		execVM "safezone.sqf";
		execVM "RespawnGear.sqf";
		[_unit] execVM "SaveLocation.sqf";

		_nul = _unit spawn {
		    //pvs
		    private ["_unit", "_date", "_closest", "_townName", "_seconds", "_secString"];
		    
			_unit = _this;
			sleep 10;
			_date = date;

			_closest = (nearestLocations [_unit,["NameCityCapital","NameCity","NameVillage"],3000]) select 0;
			_townName = text _closest;

			_seconds = _date select 4;
			_secString = "";
			if (_seconds < 10) then
			{
				_secString =  format["0%1",_seconds];
			} else
			{
				_secString = str(_seconds);
			};
			[_townName, str(_date select 2) + "/" + str(_date select 1) + "/" + str(_date select 0),str(_date select 3) + ":" + _secString] spawn BIS_fnc_infoText;
		};
	};
}];

addMissionEventHandler ["Ended",{
	private ["_uid"];
	{
		if (isPlayer _x) then
		{
			_uid = getPlayerUID _x;
			[_x,_uid] execVM "OnPlayerLeaving.sqf";
		};
	}forEach playableUnits;
}];