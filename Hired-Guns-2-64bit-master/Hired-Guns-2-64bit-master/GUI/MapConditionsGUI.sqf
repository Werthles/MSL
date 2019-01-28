//MapConditionsGUI.sqf
//Runs on players
//Called by player's GUI
//Creates MapConditionsGUI dialog texts

disableSerialization;

//pvs
private ["_control"];

//params
_control = _this select 0;

//windDir azimuth
//rain 0-1
//gusts 0-1
//overcast 0-1
//fog 0-1
//sunOrMoon 0-1
//windStr m/s?
//lightnings 0-1
//nextWeatherChange seconds
//overcastForecast 0-1
//fogForecast 0-1
//waves 0-1
//moonIntensity 0-1
//moonPhase date 0-1

(_control displayCtrl 3000) ctrlSetText format["%1",round(windDir)];//windDir azimuth
(_control displayCtrl 3001) ctrlSetText format["%1%2",round(100*rain),"%"];//rain 0-1
(_control displayCtrl 3002) ctrlSetText format["%1%2",round(100*gusts),"%"];//gusts 0-1
(_control displayCtrl 3003) ctrlSetText format["%1%2",round(100*overcast),"%"];//overcast 0-1
(_control displayCtrl 3004) ctrlSetText format["%1%2",round(100*fog),"%"];//fog 0-1
(_control displayCtrl 3005) ctrlSetText format["%1%2",round(100-100*sunOrMoon),"%"];//sunOrMoon 0-1
(_control displayCtrl 3006) ctrlSetText format["%1 m/s",round(windStr)];//windStr m/s?
(_control displayCtrl 3007) ctrlSetText format["%1%2",round(100*lightnings),"%"];//lightnings 0-1
(_control displayCtrl 3008) ctrlSetText format["%1 minutes",ceil(nextWeatherChange/60)];//nextWeatherChange seconds
(_control displayCtrl 3009) ctrlSetText format["%1%2",round(100*overcastForecast),"%"];//overcastForecast 0-1
(_control displayCtrl 3010) ctrlSetText format["%1%2",round(100*fogForecast),"%"];//fogForecast 0-1
(_control displayCtrl 3011) ctrlSetText format["%1%2",round(100*waves),"%"];//waves 0-1
(_control displayCtrl 3012) ctrlSetText format["%1%2",round(100*moonIntensity),"%"];//moonIntensity 0-1
(_control displayCtrl 3013) ctrlSetText format["%1%2",round(100*(moonPhase date)),"%"];//moonPhase date 0-1