//the function executed when a player's action menu option is activated
//turns on or off debug for the player

//executes on human clients
params [["_debug",false,[false]]];

//turn off
if ((WHKDEBUGGER find player) > -1) then
{
	WHKDEBUGGER = WHKDEBUGGER - [player];
	publicVariable "WHKDEBUGGER";

	if ((count WHKDEBUGGER) < 1) then
	{
		WHKDEBUGHC = false;
		publicVariable "WHKDEBUGHC";
	};
	
	["WHKHCDEBUGGER", "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
	[2,[]] call Werthles_fnc_WHKDebugHint;
	sleep 4;
	hintSilent parseText "";
}
else //turn on
{
	WHKDEBUGGER pushBack player;
	publicVariable "WHKDEBUGGER";
	
	if not (WHKDEBUGHC) then
	{
		WHKDEBUGHC = true;
		publicVariable "WHKDEBUGHC";
	};
	
	["WHKHCDEBUGGER", "onEachFrame",{[_debug] call Werthles_fnc_WHKDebugLoop3D;},[]] call BIS_fnc_addStackedEventHandler;
	[1,[]] call Werthles_fnc_WHKDebugHint;
};