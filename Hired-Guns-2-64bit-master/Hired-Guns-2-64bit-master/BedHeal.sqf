//var init
_caller = _this select 1;

//pvs
private ["_caller", "_pain"];

_pain = damage _caller;
[60,_pain] call Messages;

while {_pain>0} do
{
	_pain = _pain - 0.01;
	_caller setDamage _pain;
	sleep 0.1;
	_pain = damage _caller;
	[60,_pain] call Messages;
};