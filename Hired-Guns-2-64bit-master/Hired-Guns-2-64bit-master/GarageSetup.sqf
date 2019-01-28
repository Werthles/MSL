//GarageSetup.sqf
//Runs on players
//Called from initPlayerLocal
//Creates garage triggers

private ["_trg"];
{
	_trg = createTrigger ["EmptyDetector", _x, false]; 
	_trg setTriggerArea GarageSize;
	_trg setTriggerActivation ["VEHICLE", "PRESENT", true];
	_trg triggerAttachVehicle [player];

	_trg setTriggerStatements [
		"this",
		format["NewGarage = player addaction [""<t color='#AA00FF'>Store/Access Vehicle</t>"",""Garage.sqf"",[""Garage%1""],100,True,True];",(_forEachIndex + 1)],
		"player removeAction NewGarage;"
	];
}forEach GarageLocations;