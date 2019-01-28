//OfferMission.sqf
//Runs on player
//Called from another player
//Called from HirePlayer.sqf
//Shows dialog if player has requests on, else tells requester

//pvs
private ["_handle", "_other"];

//if requests are allowed
if (HGRequests) then
{
	MissionsInfo = [_this select 0,[]];
	GUITargetObject = _this select 1;
	_handle=createdialog "HG_OneMission";
}
else
{//requests blocked
	_other = _this select 1;
	[24,profileName] remoteExec ["Messages",_other];
};