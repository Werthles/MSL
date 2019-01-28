//Sum.sqf
//Function called by server
//adds all elements of an array

//pvs
private ["_sum"];

_sum = 0;
{
	_sum = _sum + _x;
}forEach _this;

_sum