disableSerialization;
//hint "delete";
//player setPos [2000,2000,2500];
if (lbCurSel 7531 != -1) then {
	ctrlEnable [7532, false];
	ctrlEnable [7533, false];
	ctrlEnable [7534, false];
	[clientOwner,lbText[7531, lbCurSel 7531]] remoteExec ["Werthles_fnc_MSLDeleteServer",2];
} else {
	hint "No save file selected";
};