private ["_playerJoinUnit", "_MSLPlayableUnits", "_MSLPlayerUnits", "_unitsOnBuses", "_unitList"];

_playerJoinUnit = (_this select 0);
_MSLPlayableUnits = [];
_MSLPlayerUnits = [];
_unitsOnBuses = [];
{
	if ((_x getVariable ["MSLPlayable",false]) and !(isPlayer _x)) then {
		_MSLPlayableUnits pushBack _x;
	};
	if ((_x getVariable ["MSLPlayer",false]) and !(isPlayer _x)) then {
		_MSLPlayerUnits pushBack _x;
	};
	if ((vehicle _x) in MSLBUSES) then {
		_unitsOnBuses pushBack _x;
	};
} forEach allUnits;

_unitList = ((_MSLPlayerUnits arrayIntersect _MSLPlayableUnits) arrayIntersect allUnits) - _unitsOnBuses;

if ((count _unitList)>0) then {
	selectPlayer (_unitList select (floor(random (count _unitList))));
} else {
	_playerJoinUnit join (playableUnits select 0);
	_playerJoinUnit setPos (getPos (playableUnits select 0));
};

player addAction ["<t color='#FF5500'>Swap Units</t>",{
		[(_this select 1)] call Werthles_fnc_MSLChangeSlot;
	}
	,[],0,true,true,"","(MSLPROGRESS == 0) or (MSLPROGRESS == 1)"];