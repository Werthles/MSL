//PlayerConnected.sqf
//Runs on server
//Called by player joining
//Called automatically due to file name
//records all IDs of players connecting

//onPlayerConnected "[_id, _uid, _name] execVM ""PlayerConnected.sqf""";
private ["_date", "_ret","_uid","_name","_id"];

//var init
_id = _this select 0;
_uid = _this select 1;
_name = _this select 2;

//log players
_date = Date;
_ret = ["AllConnections", _uid, _date, _name] call iniDB_write;