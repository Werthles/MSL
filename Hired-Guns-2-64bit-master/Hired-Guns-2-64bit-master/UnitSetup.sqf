//UnitSetup.sqf
//Runs on all machines
//Called once at start
//Called from PMSetup.sqf

//pvs
private ["_handle"];

//Civ Towns
_handle = execVM ("units\CivTowns.sqf");
waitUntil{scriptDone _handle};

//blue 1
_handle = execVM ("units\BlueTeam1_" + str (paramsArray select 3) + ".sqf");
waitUntil{scriptDone _handle};

//blue 2
_handle = execVM ("units\BlueTeam2_" + str (paramsArray select 4) + ".sqf");
waitUntil{scriptDone _handle};

//red 1
_handle = execVM ("units\RedTeam1_" + str (paramsArray select 5) + ".sqf");
waitUntil{scriptDone _handle};

//red 2
_handle = execVM ("units\RedTeam2_" + str (paramsArray select 6) + ".sqf");
waitUntil{scriptDone _handle};

//green 1
_handle = execVM ("units\GreenTeam1_" + str (paramsArray select 7) + ".sqf");
waitUntil{scriptDone _handle};

//green 2
_handle = execVM ("units\GreenTeam2_" + str (paramsArray select 8) + ".sqf");
waitUntil{scriptDone _handle};

//red 3
_handle = execVM ("units\RedTeam3_" + str (paramsArray select 14) + ".sqf");
waitUntil{scriptDone _handle};

//blue 3
_handle = execVM ("units\BlueTeam3_" + str (paramsArray select 15) + ".sqf");
waitUntil{scriptDone _handle};

//green 3
_handle = execVM ("units\GreenTeam3_" + str (paramsArray select 16) + ".sqf");
waitUntil{scriptDone _handle};

//civilian 1
_handle = execVM ("units\CivTeam1_" + str (paramsArray select 9) + ".sqf");
waitUntil{scriptDone _handle};

//civilian 2
_handle = execVM ("units\CivTeam2_" + str (paramsArray select 10) + ".sqf");
waitUntil{scriptDone _handle};