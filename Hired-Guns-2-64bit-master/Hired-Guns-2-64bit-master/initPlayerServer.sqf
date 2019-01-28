//initPlayerServer.sqf
//Runs on server
//Called a when player JIPs and on mission start
//Logs all connections

//pvs
private ["_joiner", "_date", "_ret","_uid","_name"];

//var init
_joiner = _this select 0;
_uid = getPlayerUID _joiner;
_name = name _joiner;
_date = date;

//log players
_ret = ["AllConnections", _uid, _date, _name] call iniDB_write;