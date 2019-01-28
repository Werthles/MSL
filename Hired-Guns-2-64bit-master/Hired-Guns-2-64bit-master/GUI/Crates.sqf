//Crates.sqf
//Runs on player
//Called from player's GUI
//To show items saved in crates

//pvs
private ["_markerName", "_marker"];

//close GUI
closeDialog 0;
sleep 0.05;
closeDialog 0;

if (isNil "CrateItems") then
{
    CrateItems = true;
    CrateMarkers = [];
}
else
{
    CrateItems = !CrateItems;
};

if ((count CrateMarkers) == 0) then
{
    {
		_markerName = "";
        if (count(weaponsItemsCargo _x)>0 or count(itemCargo _x)>0 or count(magazineCargo _x)>0 or count(backpackCargo _x)>0) then
        {
            _markerName = format["Gear%1",_x];
            _marker = createMarkerLocal [_markerName, (getPos _x) vectorAdd [0,5,0]];
            _marker setMarkerShapeLocal "ICON";
            _marker setMarkerTypeLocal "mil_arrow";
            _marker setMarkerDirLocal 180;
            _marker setMarkerSizeLocal [0.6, 0.6];
            _marker setMarkerColorLocal "ColorRed";
            _marker setMarkerTextLocal "Stored Gear";
        }
        else
        {
            _markerName = "";
        };
        CrateMarkers pushBack _markerName;
    }forEach Boxes;
    [63,nil] call Messages;
}
else
{
    {
        deleteMarkerLocal _x;
    }forEach CrateMarkers;
    CrateMarkers = [];
    [64,nil] call Messages;
};