disableSerialization;

//hint "load";
//player setPos [1000,1000,1000];
if (lbCurSel 7531 != -1) then {
	ctrlEnable [7532, false];
	ctrlEnable [7533, false];
	ctrlEnable [7534, false];
	[clientOwner,lbText[7531, lbCurSel 7531], (((findDisplay 753) displayCtrl 7538) ctrlChecked 0), (((findDisplay 753) displayCtrl 7538) ctrlChecked 1)] remoteExec ["Werthles_fnc_MSLLoadServer",2];
} else {
	hint "No save file selected";
};

MSLPROGRESS = 0;
publicVariable "MSLPROGRESS";

[] spawn {
	private _check = true;
	while {_check} do {
		if (MSLPROGRESS == 1) then {_check = false;};
		((findDisplay 753) displayCtrl 7537) progressSetPosition MSLPROGRESS;
	};
};