//hint "Playerdelete";
//player setPos [2000,2000,2500];

params [["_success",false,[false]],["_output","Unknown Error",["Unknown Error"]]];

if (_success) then {
	//hint "Delete Success: " + _output;
} else {
	//hint "Delete Failure: " + _output;
};

[clientOwner] remoteExec ["Werthles_fnc_MSLPrepServer",2];