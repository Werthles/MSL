//TaxiSetup.sqf
//Runs on server, then on players if required
//Called once when the machine itself joins
//Called from initServer.sqf, maybe initPlayerLocal.sqf

//pvs
private ["_newTask1", "_newTask2", "_newTask4", "_newTask3", "_newTask5", "_newTask6", "_veh"];

//Check mission parameters
if (TaxisOn==1) then
{//create taxi tasks
	_newTask1 = [resistance,"TAXI",["Jump in the back of a taxi.","Get A Taxi (Optional)",""],objNull,"CREATED",100,false,"taxi",false] call BIS_fnc_taskCreate;
	_newTask2 = [resistance,["TAXI0","TAXI"],["Get a lift to the Old Man.","Taxi To The Old Man",""],TAXI,"CREATED",100,false,"taxi",false] call BIS_fnc_taskCreate;
	_newTask4 = [resistance,["TAXI1","TAXI"],["Get a lift to the Slave Commander.","Taxi To The Slave Commander",""],TAXI1,"CREATED",100,false,"taxi",false] call BIS_fnc_taskCreate;
	//_newTask3 = [resistance,["TAXI2","TAXI"],["Get a lift to Tanoan Narcotics - Land.","Taxi To Tanoan Narcotics - Land",""],TAXI2,"CREATED",100,false,"taxi",false] call BIS_fnc_taskCreate;
	_newTask5 = [resistance,["TAXI3","TAXI"],["Get a lift to the Mine Supervisor.","Taxi To The Mine Supervisor",""],TAXI3,"CREATED",100,false,"taxi",false] call BIS_fnc_taskCreate;
	_newTask6 = [resistance,["TAXI4","TAXI"],["Get a lift around all of Tanoa's airports.","Air Taxi",""],Plane,"CREATED",100,false,"taxi",false] call BIS_fnc_taskCreate;
}
else
{//if taxi missions turned off, delete all taxis and crew
	if (isServer) then
	{
		{
			_veh = _x;
			{
				_veh deleteVehicleCrew _x;
			} forEach crew _veh;
			deleteVehicle _veh;
		}forEach [TAXI,TAXI1,TAXI2,TAXI3,Plane];
	};
};