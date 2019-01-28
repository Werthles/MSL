//GetPlayerMission.sqf
//Runs on another player
//Called from player
//Sends CurrentMission to requester

//pvs
private ["_owner"];

_owner = _this select 0;

//send CurrentMission
SendCurrent = +CurrentMission;
_owner publicVariableClient "SendCurrent";