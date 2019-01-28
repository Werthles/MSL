//safezone.sqf
//Runs on player
//Called by player
//Called on each respawn from mission event handler

//pvs
private ["_safe", "_safePoint", "_dis"];

//set player invulnerable
player allowDamage false;

//var init
_safe = 1;
_safePoint = getMarkerPos "safezone";

//while player in safezone, or 15 seconds after spawnn, keep player invulnerable
while {_safe==1} do
{
	sleep 15;
	//check distance to safezone marker
	_dis = player distance _safePoint;
	
	//if player leaves slowly, show hint and exit loop
	if (_dis > 50 and _dis<300) then
	{
		[46,nil] call Messages;
		_safe = 0;
	};

	//if player leaves fast exit loop
	if (_dis >=300) then
	{
		_safe = 0;
	};

	//if player has respawned, etc, exit loop
	if (!alive player) then
	{
		_safe = 0;
	};
};

//make player vulnerable again
player allowDamage true;