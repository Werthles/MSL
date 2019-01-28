//BlockRequests.sqf
//Runs on player
//Called from player's GUI
//Stops/allows other players to offer missions to the player

//no pvs

//close GUI
closeDialog 0;
sleep 0.05;
closeDialog 0;

//flip variable and display hint
if (HGRequests) then
{
	HGRequests=false;
	[0,nil] call Messages;
}
else
{
	HGRequests = true;
	[1,nil] call Messages;
};