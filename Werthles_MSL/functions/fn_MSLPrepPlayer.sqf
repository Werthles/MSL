private ["_control", "_lbID", "_rankArray"];

//hint "Playerprep";
//player setPos [5000,5000,500];
params [["_missionNames",[],[[]]]];

lbClear 7531;
_control = findDisplay -753;
_lbID = 7531;
{
	lbAdd[_lbID,_x];
	
/* 	(_control displayCtrl _lbID) lbSetPicture [_foreachindex,getText ((_rankArray select 0) >> "texture")];
	(_control displayCtrl _lbID) lbSetTooltip [_foreachindex,getText ((_rankArray select 0) >> "displayName")];
	
	(_control displayCtrl _lbID) lbSetPictureColor [_foreachindex, [1,1,1,0.7]];
	(_control displayCtrl _lbID) lbSetPictureColorSelected [_foreachindex, [0.4,0.4,0,0.7]]; */
}forEach _missionNames;

MSLMissionNames = _missionNames;
ctrlEnable [7532, true];
ctrlEnable [7533, true];
ctrlEnable [7534, true];