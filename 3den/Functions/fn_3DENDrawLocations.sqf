_show = [_this,0,!(uinamespace getvariable ["bis_fnc_3DENDrawLocations_show",false]),[true]] call bis_fnc_param;
uinamespace setvariable ["bis_fnc_3DENDrawLocations_show",_show];

if (isnil {missionnamespace getvariable "bis_fnc_3DENDrawLocations_drawHandler"}) then {
	missionnamespace setvariable [
		"bis_fnc_3DENDrawLocations_drawHandler",
		addmissioneventhandler [
			"draw3d",
			{
				if (uinamespace getvariable ["bis_fnc_3DENDrawLocations_show",false]) then {
					{
						_pos = locationposition _x;
						_pos set [2,0];
						drawicon3d [
							"\a3\3DEN\Data\Displays\Display3DEN\PanelLeft\location_ca.paa",
							[1,1,1,1],
							_pos,
							2,
							2,
							0,
							"",
							2
						];
						drawicon3d [
							"#(argb,8,8,3)color(0,0,0,1)",
							[1,1,1,1],
							_pos,
							0,
							-0.5,
							0,
							text _x,
							2
						];
					} foreach nearestlocations [position get3dencamera,["nameVillage","nameCity","nameCityCapital"],2000];
				};
			}
		]
	];
};