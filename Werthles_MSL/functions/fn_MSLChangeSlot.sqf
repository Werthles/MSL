private ["_playerJoinUnit", "_MSLPlayableUnits", "_MSLPlayerUnits", "_unitsOnBuses", "_unitList"];

_playerJoinUnit = (_this select 0);
_MSLPlayableUnits = [];
_MSLPlayerUnits = [];
_unitsOnBuses = [];
_addActionID = (_this select 1);

player removeAction _addActionID;

{
	if ((_x getVariable ["MSLPlayable",false]) and !(isPlayer _x)) then {
		_MSLPlayableUnits pushBack _x;
	};
	if ((_x getVariable ["MSLPlayable",false]) and (isPlayer _x)) then {
		_MSLPlayerUnits pushBack _x;
	};
	// if ((vehicle _x) in MSLBUSES) then {
	// 	_unitsOnBuses pushBack _x;
	// };
} forEach allUnits;

//_unitList = ((_MSLPlayerUnits arrayIntersect _MSLPlayableUnits) arrayIntersect allUnits) - _unitsOnBuses;

_unitList = _MSLPlayableUnits;
_newUnit = (_unitList select (floor(random (count _unitList))));

if ((count _unitList)>0) then {
	selectPlayer _newUnit;
} else {
	[_playerJoinUnit] join (_MSLPlayerUnits select 0);
	_playerJoinUnit setPos (getPos (_MSLPlayerUnits select 0));
};

_newUnit addAction ["<t color='#FF5500'>Swap Units</t>",{
		[(_this select 1), (_this select 2)] call Werthles_fnc_MSLChangeSlot;
	}
	,[],0,true,true,"","(MSLPROGRESS == 0) or (MSLPROGRESS == 1)"];