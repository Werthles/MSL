hint "load";
//player setPos [1000,1000,1000];
if (lbCurSel 7531 != -1) then {
	ctrlEnable [7532, false];
	ctrlEnable [7533, false];
	ctrlEnable [7534, false];
	[clientOwner,lbText[7531, lbCurSel 7531]] remoteExec ["Werthles_fnc_MSLLoadServer",2];
} else {
	hint "No save file selected";
};