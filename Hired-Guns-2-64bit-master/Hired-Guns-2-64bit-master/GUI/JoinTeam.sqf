//JoinTeam.sqf
//function file
//called by player
//runs on another player

//no pvs

if (HGRequests) then
{
	GUITargetObject = _this select 0;
	createDialog "HG_JoinTeam";
};