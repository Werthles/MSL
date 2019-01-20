//executes on human clients
//draws icons if debug is activated for a player(s)

//private variables
private ["_check", "_code3D", "_hcColour", "_z", "_On"];

params [["_debug",false,[false]]];

//icon assignment
if ((_debug) or (serverCommandAvailable "#kick")) then
{
	_hcColour = [];
	_z = 0;
	_On = "";
	{
		if (count units _x > 0 and ((getPos (units _x select 0)) distance [0,0,0])>100) then
		{
			if (count WHKHeadlessGroups == 0) then
			{
				_hcColour = [205/255,0/255,0/255,0.6];
				_On = "Awaiting HC Response";
			}
			else
			{
				_On = "";
				_z = WHKHeadlessGroups find _x;
				//if on player's machine
				if (local _x) then
				{
					if (isServer) then
					{
						_hcColour = [237/255,145/255,33/255,0.6];
						_On = "Server/Player's Group";
					}
					else
					{
						_hcColour = [113/255,198/255,113/255,0.6];
						_On = "Player/Player-Controlled Unit";
					};
				}
				else
				{
					//if not on HC
					if (_z == -1) then
					{
						_hcColour = [1,1,80/255,0.6];
						_On = "Not On HC";
					}
					else
					{
						//if on HC
						if (count WHKHeadlessGroupOwners > _z) then
						{
							_On = "On: " + str (WHKHeadlessGroupOwners select _z);
							_hcColour = [30/255,30/255,205/255,0.6];
						};
					};
				};
			};
			{
				//draw HC
				drawIcon3D ["\a3\ui_f\data\map\vehicleicons\iconvirtual_ca.paa", _hcColour, [(getPos _x select 0), (getPos _x select 1), (getPos _x select 2) + 2], 1, 1, 0, _On, 0.5, 0.02, "EtelkaNarrowMediumPro", "center", true];
				
				//draw cross
				if (_z == -1) then
				{
					drawIcon3D ["\a3\ui_f\data\map\mapcontrol\taskiconfailed_ca.paa", [1,0,0,0.5], [(getPos _x select 0), (getPos _x select 1), (getPos _x select 2) + 2], 1, 1, 0];
				};
			}forEach units _x;
		};
	}forEach allGroups;
}
else
{
	["WHKHCDEBUGGER", "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
};