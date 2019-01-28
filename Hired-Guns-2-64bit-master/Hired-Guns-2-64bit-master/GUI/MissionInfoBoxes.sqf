//MissionInfoBoxes.sqf
//Runs on player
//Called from player's GUI
//Populates mission offers and mission info dialogs

//pvs
private ["_control", "_count", "_missionName", "_missionType", "_missionLevel"];

disableSerialization;

//no default for params
_control = _this select 0;

_count = count (MissionsInfo select 1);

//mission 2
if (_count > 0) then
{
	if ((str GUITargetObject) find "NPC" > -1) then
	{
		(MissionsInfo select 1) set [11, profileName];
	};
	(_control displayCtrl 1038) ctrlSetText ((MissionsInfo select 1) select 0);//mission name
	(_control displayCtrl 1039) ctrlSetText format["%2 - %1/10",(MissionsInfo select 1) select 1,name(missionNamespace getVariable((MissionsInfo select 1) select 12 select [0,4]))];//Contact Progress
	(_control displayCtrl 1040) ctrlSetText ((MissionsInfo select 1) select 3);//Mission Type
	(_control displayCtrl 1041) ctrlSetText ((MissionsInfo select 1) select 2);//Difficulty
	(_control displayCtrl 1042) ctrlSetText (text ((nearestLocations [((MissionsInfo select 1) select 8),["NameCityCapital","NameCity","NameVillage"],2000]) select 0));//Location
	(_control displayCtrl 1043) ctrlSetText ((MissionsInfo select 1) select 4);//Description
	(_control displayCtrl 1044) ctrlSetText ((MissionsInfo select 1) select 11);//Team Leader
	(_control displayCtrl 1045) ctrlSetText ((MissionsInfo select 1) select 9);//Target Type
	(_control displayCtrl 1046) ctrlSetText ((MissionsInfo select 1) select 10);//Target
	(_control displayCtrl 1047) ctrlSetText format["T$ %1,000",((MissionsInfo select 1) select 5)];//Leader Cash
	(_control displayCtrl 1048) ctrlSetText format["T$ %1,000",((MissionsInfo select 1) select 6)];//Squad Cash
	(_control displayCtrl 1049) ctrlSetText format["%1 Members",((MissionsInfo select 1) select 7)];//Squad Pay Cap On
};

_count = count (MissionsInfo select 0);

//mission 1 (MyOptions select 0) select 0
if (_count > 0) then
{
	if ((str GUITargetObject) find "NPC" > -1) then
	{
		(MissionsInfo select 0) set [11, profileName];
	};
	_missionName = (MissionsInfo select 0 select 12);
	if (_missionName find "PM" > -1) then
	{//personal job
		_missionType = parseNumber(_missionName select [2,1]);
		_missionLevel = parseNumber(_missionName select [4,1]);
		(_control displayCtrl 1026) ctrlSetText _missionName;//mission name
		(_control displayCtrl 1027) ctrlSetText format["Personal Job %1",MissionsInfo select 0 select 1];//Contact Progress
		(_control displayCtrl 1028) ctrlSetText (PMTypeArray select _missionType);//Mission Type
		(_control displayCtrl 1029) ctrlSetText (PMDifficultyArray select _missionLevel);//Difficulty
		(_control displayCtrl 1030) ctrlSetText (text ((nearestLocations [((MissionsInfo select 0) select 8),["NameCityCapital","NameCity","NameVillage"],2000]) select 0));//Location
		(_control displayCtrl 1031) ctrlSetText (PMDescriptions select _missionType);//Description
		(_control displayCtrl 1032) ctrlSetText name ((MissionsInfo select 0) select 11);//team leader
		(_control displayCtrl 1033) ctrlSetText "Item";//Target Type
		(_control displayCtrl 1037) ctrlSetText "Guarded";
		(_control displayCtrl 1034) ctrlSetText (PMRewardArray select _missionType select _missionLevel);//Leader Cash
		(_control displayCtrl 1035) ctrlSetText (str (PMMoneyArray select _missionLevel));//Squad Cash
		(_control displayCtrl 1036) ctrlSetText "Unlimited";//Squad Pay Cap On
	}
	else//NPC job
	{
		(_control displayCtrl 1026) ctrlSetText ((MissionsInfo select 0) select 0);//mission name
		(_control displayCtrl 1027) ctrlSetText format["%2 - %1/10",(MissionsInfo select 0) select 1,name(missionNamespace getVariable((MissionsInfo select 0) select 12 select [0,4]))];//Contact Progress
		(_control displayCtrl 1028) ctrlSetText ((MissionsInfo select 0) select 3);//Mission Type
		(_control displayCtrl 1029) ctrlSetText ((MissionsInfo select 0) select 2);//Difficulty
		(_control displayCtrl 1030) ctrlSetText (text ((nearestLocations [((MissionsInfo select 0) select 8),["NameCityCapital","NameCity","NameVillage"],2000]) select 0));//Location
		(_control displayCtrl 1031) ctrlSetText ((MissionsInfo select 0) select 4);//Description
		(_control displayCtrl 1032) ctrlSetText ((MissionsInfo select 0) select 11);//Team leader
		(_control displayCtrl 1033) ctrlSetText ((MissionsInfo select 0) select 9);//Target Type
		(_control displayCtrl 1037) ctrlSetText ((MissionsInfo select 0) select 10);//Team Leader
		(_control displayCtrl 1034) ctrlSetText format["T$ %1,000",((MissionsInfo select 0) select 5)];//Leader Cash
		(_control displayCtrl 1035) ctrlSetText format["T$ %1,000",((MissionsInfo select 0) select 6)];//Squad Cash
		(_control displayCtrl 1036) ctrlSetText format["%1 Members",((MissionsInfo select 0) select 7)];//Squad Pay Cap On
	};
};

MyOptions = +MissionsInfo;