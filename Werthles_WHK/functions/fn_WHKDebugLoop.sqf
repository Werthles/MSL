//executes on all clients and server
//when debug is active, all machines send a count of their local units to the debugger(s)

//private variables
private ["_localCount"];

while {true} do
{
	//make sure hints are not always displayed together
	sleep (7 + random 7);
	if (WHKDEBUGHC) then
	{
		//count local units
		_localCount = {local _x} count allUnits;
		[3,[profileName,_localCount]] remoteExec ["Werthles_fnc_WHKDebugHint",WHKDEBUGGER];
	};
};