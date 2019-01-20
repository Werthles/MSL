//executed on player respawn
//adds local debug option to players' action menu
//removes previous debug option as appropriate


//params
params [["_newUnit",objNull,[objNull]],["_oldUnit",objNull,[objNull]],["_debug",false,[false]]];

if (isNil "WHKDEBUGGER") then {WHKDEBUGGER = [];};
if (isNil "WHKDEBUGHC") then {WHKDEBUGHC = false;};

if not (isNil "WHKAction") then
{
	_oldUnit removeAction WHKAction;
};

if ((WHKDEBUGGER find _oldUnit) > -1) then
{
	WHKDEBUGGER = WHKDEBUGGER - [_oldUnit];
	WHKDEBUGGER pushBack _newUnit;
	publicVariable "WHKDEBUGGER";
};

WHKAction = _newUnit addAction ["<t color='#C67171'>Toggle WHM Debug</t>",
	{
		[(_this select 3)] call Werthles_fnc_WHKDebugAddAction;
	},_debug,-666,false,true,"",WHKCondition];