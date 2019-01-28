//Garages.sqf
//Runs on player
//Called from player GUI
//To show stored vehicles

//pvs
private ["_markerName", "_garageName", "_marker"];

//close GUI
closeDialog 0;
sleep 0.05;
closeDialog 0;

if (isNil "GarageItems") then
{
    GarageItems = true;
    GarageMarkers = [];
}
else
{
    GarageItems = !GarageItems;
};

if ((count GarageMarkers) == 0) then
{
    //var init
    GarageIntel = [];
    
    //get details from server
    //false = one unit
    GetGarageIntel = [player];
    publicVariableServer "GetGarageIntel";
    
    //wait for server's info
    waitUntil{(count GarageIntel) > 0};

    {
		_markerName = "";
        if not ((GarageIntel select _forEachIndex) == "") then
        {
            _markerName = format["Vehicle%1",_x];
			_garageName = format["Garage%1",_x];
            _marker = createMarkerLocal [_markerName, (getMarkerPos _garageName) vectorAdd [0,5,0]];
            _marker setMarkerShapeLocal "ICON";
            _marker setMarkerTypeLocal "mil_arrow";
            _marker setMarkerDirLocal 180;
            _marker setMarkerSizeLocal [0.6, 0.6];
            _marker setMarkerColorLocal "ColorRed";
            _marker setMarkerTextLocal "Stored Vehicle";
        }
        else
        {
            _markerName = "";
        };
        GarageMarkers pushBack _markerName;
    }forEach[1,2,3,4,5,6,7,8,9,10];
    [63,nil] call Messages;
}
else
{
    {
        deleteMarkerLocal _x;
    }forEach GarageMarkers;
    GarageMarkers = [];
    [64,nil] call Messages;
};