private ["_inidbiSAVELIST", "_i", "_bus"];

if (isNil "MSLBUSES") then {MSLBUSES = [];};
if (isNil "MSLINIT") then {MSLINIT = true;};
if !(isDedicated) then {
	waitUntil {!isNull player};
};
if (isNil "MSLPLAYERINIT") then {
	MSLPLAYERINIT = true;
	MSLAddActionID = player addAction ["<t color='#FF5500'>Multiplayer Save and Load</t>",{createdialog "MSLDialog";},[],-999,false,true,"","isServer or serverCommandAvailable ""#kick"""];
};

MSLPLAYERINIT = false;

//if server, set up 
if (isServer and MSLINIT) then
{
	MSLINIT = false;
	publicVariable "MSLINIT";
	_inidbiSAVELIST = ["new", "SAVELIST"] call OO_INIDBI;
	["write", ["FileListFile", "Message", "Do not remove"]] call _inidbiSAVELIST;
	["delete", _inidbiSAVELIST] call OO_INIDBI;

	MSLALLPLAYABLEUNITS = [];
	{
		_x setVariable ["MSLPlayable", true];
		MSLALLPLAYABLEUNITS pushBack _x;
	} forEach (playableUnits + switchableUnits);
	publicVariable "MSLALLPLAYABLEUNITS";

	MSLBUSES = [];
	for [{_i = 0}, {_i<100}, {_i = _i + 5;}] do {
		_bus = createVehicle ["C_Truck_02_transport_F",
			[_i,-5000,7531],
			[],
			0,
			"FLY"
		];
		_bus enableSimulationGlobal false;
		_bus lock true;
		_bus setVectorDir [0,0,0];
		_bus setVectorUp [0,0,0];
		_bus setPos [_i,-5000,7531];
		MSLBUSES pushBack _bus;
	};
	publicVariable "MSLBUSES";
	
	MSLPROGRESS = 0;
	publicVariable "MSLPROGRESS";
};

waitUntil {(count (MSLBUSES) > 0)};

{
	_x addAction ["<t color='#FF5500'>Exit the Bus</t>",{
		[(_this select 1),1234] call Werthles_fnc_MSLChangeSlot;
	}
	,[],0,true,true,"","(MSLPROGRESS == 0) or (MSLPROGRESS == 1)"];
} forEach MSLBUSES;

if (hasInterface) then {
	[] spawn {
		sleep 15;
		player removeAction MSLAddActionID;
		MSLAddActionID = player addAction ["<t color='#FF5500'>Multiplayer Save and Load</t>",{createdialog "MSLDialog";},[],-999,false,true,"","isServer or serverCommandAvailable ""#kick"""];
	};
};
