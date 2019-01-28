//DeepSum.sqf
//Sums all numbers in double layered arrays
private["_sum"];

_sum = 0;
{
	{
		_sum = _sum + _x;
	}forEach _x;
}forEach _this;

_sum