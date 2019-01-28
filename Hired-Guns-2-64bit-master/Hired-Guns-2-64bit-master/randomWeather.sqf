//randomWeather.sqf
//Runs on all machines
//Called on player when player joins
//Called from init.sqf

// Initial Server Weather Setup
private ["_randOvercast", "_randRain", "_randFog", "_randWindE", "_randWindN", "_date", "_hour"];
if(isServer) then {

// Set initial weather values based on parameter choice.  Make sure the # in the select below matches what # in the order of parameters (starting with 0) your initialWeather class is defined in the description.ext
initialWeather = 7;  
 switch (initialWeather) do{
    case 1: {forecastOvercast = 0;forecastRain = 0;forecastFog = 0;forecastWindE = 1;forecastWindN = 1;};            // Clear
    case 2: {forecastOvercast = .45;forecastRain = .45;forecastFog = 0;forecastWindE = 2;forecastWindN = 2;};    // Overcast
    case 3: {forecastOvercast = .70;forecastRain = .70;forecastFog = .05;forecastWindE = 3;forecastWindN = 3;};    // Light Rain
    case 4: {forecastOvercast = 1;forecastRain = 1;forecastFog = .05;forecastWindE = 4;forecastWindN = 4;};        // Heavy Rain
    case 5: {forecastOvercast = .75;forecastRain = .10;forecastFog = .30;forecastWindE = 1;forecastWindN = 1;};    // Light Fog
    case 6: {forecastOvercast = .85;forecastRain = .20;forecastFog = .50;forecastWindE = 0;forecastWindN = 0;};    // Heavy Fog
    case 7: {forecastOvercast = random(1);forecastRain = random(1);forecastFog = 0;forecastWindE = (random(14)-7);forecastWindN = (random(14)-7);};    // Random
};//forecastFog = random(0.2);

// Set up variable to track server weather updates.
    serverWeather = 0;

// Broadcast initial weather settings that were set based on parameter choice.   
    publicVariable "forecastOvercast";
    publicVariable "forecastRain";
    publicVariable "forecastFog";
    publicVariable "forecastWindE";
    publicVariable "forecastWindN";
    publicVariable "serverWeather";
};

// Server and Client weather set based on initial weather parameter values.

waitUntil {!isnil "serverWeather"};
    skiptime -24;
    86400 setOvercast forecastOvercast;
    86400 setFog forecastFog;
    86400 setRain forecastRain;
    setWind [forecastWindE,forecastWindN,true];
    skipTime 24;
    simulWeatherSync;  
    
    
// Server Loop to create a new weather forecast every 15 minutes.    
if(isServer) then {
    while {serverWeather >= 0} do {  // This will always be true and it will run as long as server runs.
    
    randOCorRain = random (2);  // Pick a random number between 0 and 2 to update Overcast or Rain this cycle since you can't to both.  If random value is Less than or equal to 1 Overcast will be updated this cycle, if value is greater than 1, update rain this cycle.
        
     // Configure weather settings on server to match next 15 minute weather forecast.
        900 setFog forecastFog;
        if (randOCorRain <= 1) then {
        900 setOvercast forecastOvercast;} else {
        900 setRain forecastRain;};
        sleep 900;
        setWind [forecastWindE,forecastWindN,true];

// Create random numbers for next forecast.
    _randOvercast = (round((random(0.2)-0.1)*100))/100;
    _randRain = (round((random(0.2)-0.1)*100))/100;
    _randFog = (round((random(0.1)-0.05)*100))/100;
    _randWindE = (round((random(1)-0.5)*100))/100;
    _randWindN = (round((random(1)-0.5)*100))/100;

// Create next random overcast level and keep it between 0 and 1
    forecastOvercast = forecastOvercast + _randOvercast;
    if (forecastOvercast > 1) then {forecastOvercast = forecastOvercast - (2*_randOvercast)};
    if (forecastOvercast < 0) then {forecastOvercast = forecastOvercast + (abs(2*_randOvercast))};

// Create next random rain level and keep it between 0 and 1
    forecastRain = forecastRain + _randRain;
    if (forecastRain > 1) then {forecastRain = forecastRain - (2*_randRain)};
    if (forecastRain < 0) then {forecastRain = forecastRain + (abs(2*_randRain))};

// Create next random fog level and keep between 0 and 0.5
    forecastFog = forecastFog + _randFog;
    if (forecastFog > 0.5) then {forecastFog = forecastFog - (2*_randFog)};
    if (forecastFog < 0) then {forecastFog = forecastFog + (abs(2*_randFog))};
    
// Create next random E-W Wind level and keep between -10 and 10
    forecastWindE = forecastWindE + _randWindE;
    if (forecastWindE > 10) then {forecastWindE = forecastWindE - (2*_randWindE)};
    if (forecastWindE < -10) then {forecastWindE = forecastWindE + (abs(2*_randWindE))};
    
// Create next random N-S Wind level and keep between -10 and 10
    forecastWindN = forecastWindN + _randWindN;
    if (forecastWindN > 10) then {forecastWindN = forecastWindN - (2*_randWindN)};
    if (forecastWindN < -10) then {forecastWindN = forecastWindN + (abs(2*_randWindN))};
    
// Increment variable to track updates to server weather
    serverWeather = serverWeather + 1;

   
// Broadcast server weather forecast information to clients.
    publicVariable "forecastOvercast";
    publicVariable "forecastRain";
    publicVariable "forecastFog";
    publicVariable "forecastWindE";
    publicVariable "forecastWindN";
    publicVariable "serverWeather";
    publicVariable "randOCorRain";
    };
};

if (!isServer) then {
// Client Weather forecast loop.

// Set up counter on client to compare local client weather serverWeather counter.
    clientWeather = 0;

// Run a continuous loop on the client to look for updated weather values from the server every 10 seconds.
    while {clientWeather >= 0} do {
        sleep 10;

     // If client Weather is older than the server weather, set client 15 minute weather forecast to match server.
        if (clientWeather < serverWeather) then {
		
		
		////////////////////////////////////////////////
		// change time [year, month, day, hour, minute]
		_date = date;
		_hour = _date select 3;
		if (_hour>21 or _hour < 7) then
		{
			setDate [_date select 0,_date select 1,(_date select 2) + 1, 7,_date select 4]
		};
		////////////////////////////////////////////////
		
		
		
     // Set clientWeather counter to match serverWeather counter so local client weather will not update until next server weather update.
        clientWeather = clientWeather + 1;
        

     // Set 15 minute forecast for the client.
        900 setFog forecastFog;
        if (randOCorRain <= 1) then {
        900 setOvercast forecastOvercast;} else {
        900 setRain forecastRain;};
        sleep 900;
        setWind [forecastWindE,forecastWindN,true];
        };
    };
};  