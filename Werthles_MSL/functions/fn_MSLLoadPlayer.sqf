params [["_success",false,[false]],["_output","Unknown Error",["Unknown Error"]]];

if (_success) then {
	hint "Load Success: " + _output;
} else {
	hint "Load Failure: " + _output;
	//player setPos [1000,1000,1000];
};