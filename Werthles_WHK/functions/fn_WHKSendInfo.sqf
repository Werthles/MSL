//send unit locality details to server
//private local variables
private ["_counts", "_HCgroups"];

if (!(isServer or hasInterface) or (useServer and isServer))then
{
	sleep (random 1);
	_counts = {local _x} count allUnits;
	_HCgroups = [];
	{
		if (local _x) then
		{
			if (count units _x == 0) then
			{
				deleteGroup _x;
			}
			else
			{
				_HCgroups append [_x];
			};
		};
	}forEach allGroups;
	[player,_counts,_HCgroups] remoteExec ["Werthles_fnc_WHKAddHeadless",2];
};