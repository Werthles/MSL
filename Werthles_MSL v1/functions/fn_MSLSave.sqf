disableSerialization;
ctrlEnable [7532, false];
ctrlEnable [7533, false];
ctrlEnable [7534, false];

//hint "save";
//player setPos [500,500,500];

[clientOwner, (ctrlText 7538), (((findDisplay 753) displayCtrl 7538) ctrlChecked 0), (((findDisplay 753) displayCtrl 7538) ctrlChecked 1)] remoteExec ["Werthles_fnc_MSLSaveServer",2];
MSLPROGRESS = 0;
publicVariable "MSLPROGRESS";
[] spawn {
	private _check = true;
	while {_check} do {
		if (MSLPROGRESS == 1) then {_check = false;};
		((findDisplay 753) displayCtrl 7537) progressSetPosition MSLPROGRESS;
	};
};