//PlayerMarkers.sqf

//pvs
private ["_markerArray", "_markerNum", "_mark"];

//MarkerUpdateDelay
_markerArray = [];

sleep 20;

while {true} do
{
	//clear previous markers
	{
		deleteMarker _x;
	}forEach _markerArray;

	//wipe marker list
	_markerArray = [];
	_markerNum = 0;

	//create new markers
	{
		if ((leader (group _x))==_x) then
		{
			_mark = createMarker [format["PlayerMarker%1",_markerNum],getPos _x];
			_mark setMarkerText format["%1 (%2)",name _x,count units(group _x)];
			_mark setMarkerType "n_inf";
			_mark setMarkerColor "ColorGUER";
			_markerArray append [_mark];
			_markerNum = _markerNum + 1;
		};
	}forEach allPlayers;
	sleep MarkerUpdateDelay;
};