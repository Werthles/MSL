#define DELAY	0.15

if (get3denactionstate "ToggleMap" > 0) exitwith {}; //--- No preview in the map

disableserialization;

_ctrlGroup = param [0,controlnull,[controlnull]];
_value = param [1,-1,[0,[]]];

//--- Display init
if (isnull _ctrlGroup) exitwith {
	missionnamespace setvariable ["bis_fnc_3DENIntel_time",time + 0.2];
};

_class = ctrlclassname _ctrlGroup;
_isDelay = param [2,_class in ["Overcast","SliderTimeDay"],[true]];

if (_isDelay) then {missionnamespace setvariable ["bis_fnc_3DENIntel_" + _class,_value];};

//--- Terminate on display init
if (time < missionnamespace getvariable ["bis_fnc_3DENIntel_time",0]) exitwith {};

//--- Delay simulweather refresh to avoid scene freezing
if (_isDelay) exitwith {
	missionnamespace setvariable ["bis_fnc_3DENIntel_delay",time + DELAY];
	if (scriptdone (missionnamespace getvariable ["bis_fnc_3DENIntel_delayScript",scriptnull])) then {
		missionnamespace setvariable [
			"bis_fnc_3DENIntel_delayScript",
			(_this + [false]) spawn {
				waituntil {time > (missionnamespace getvariable ["bis_fnc_3DENIntel_delay",0])};
				_this call bis_fnc_3DENIntel;
			}
		];
	};
};

switch _class do {
	case "Fog": {
		0 setfog _value;
	};
	case "Overcast": {
		0 setovercast (missionnamespace getvariable ["bis_fnc_3DENIntel_Overcast",overcast]);
		forceweatherchange;
	};
	case "SliderTimeDay": {
		0 setovercast (missionnamespace getvariable ["bis_fnc_3DENIntel_Overcast",overcast]);
		skiptime (((missionnamespace getvariable ["bis_fnc_3DENIntel_SliderTimeDay",daytime]) / 3600) - daytime);
	};
	case "Date": {
		0 setovercast (missionnamespace getvariable ["bis_fnc_3DENIntel_Overcast",overcast]);
		_date = (missionnamespace getvariable ["bis_fnc_3DENIntel_Date",date]);
		_date set [3,date select 3];
		_date set [4,date select 4];
		setdate _date;
		_date spawn {setdate _this;};
	};
	case "Rain": {
		0 setrain _value;
	};
	case "Waves": {
		0 setwaves _value;
	};
	case "Gusts": {
		0 setgusts _value;
	};
	case "Wind": {
		0 setwindstr _value;
	};
	case "WindDir": {
		1 setwinddir _value;
	};
};