//IntelGUI.sqf
//Runs on players
//Called by player's GUI
//Creates Intel dialog texts

disableSerialization;

//pvs
private ["_control", "_count", "_info", "_steamName", "_jobsNo", "_PMNo", "_money", "_k0", "_k1", "_k2", "_k3", "_k4", "_k5", "_k6", "_k7", "_type","_target","_name"];


//params
_control = _this select 0;
_count = count Intel;

//_info = [_target,_name,_steamName,_jobsNo,_PMNo,_money,_k0,_k1,_k2,_k3,_k4,_k5,_k6,_k7];

//set up texts
if (_count > 0) then
{
	_type = "";
    if (isPlayer (Intel select 0)) then {_type = "Player"} else {_type = "AI";};
	(_control displayCtrl 3000) ctrlSetText _type;//_target
    
	if (_count > 1) then
	{
		(_control displayCtrl 3001) ctrlSetText (Intel select 1);//_name
		(_control displayCtrl 3002) ctrlSetText (Intel select 2);//_steamName
		(_control displayCtrl 3003) ctrlSetText str (Intel select 3);//_jobsNo
		(_control displayCtrl 3004) ctrlSetText str (Intel select 4);//_PMNo
		(_control displayCtrl 3005) ctrlSetText ("T$ "+(str (Intel select 5))+"000");//_money
		(_control displayCtrl 3006) ctrlSetText str (Intel select 6);//Enemy
		(_control displayCtrl 3007) ctrlSetText str (Intel select 7);//Friendly
		(_control displayCtrl 3008) ctrlSetText str (Intel select 8);//Players
		(_control displayCtrl 3009) ctrlSetText str (Intel select 9);//Suicides
		(_control displayCtrl 3010) ctrlSetText str (Intel select 10);//Civilian
		(_control displayCtrl 3011) ctrlSetText str (Intel select 11);//Animal
		(_control displayCtrl 3012) ctrlSetText str (Intel select 12);//Car
		(_control displayCtrl 3013) ctrlSetText str (Intel select 13);//Plane
	}
	else
	{
		(_control displayCtrl 3001) ctrlSetText (name (Intel select 0));
		(_control displayCtrl 3002) ctrlSetText "N/A";
		(_control displayCtrl 3003) ctrlSetText "N/A";
		(_control displayCtrl 3004) ctrlSetText "N/A";
		(_control displayCtrl 3005) ctrlSetText "N/A";
		(_control displayCtrl 3006) ctrlSetText "N/A";
		(_control displayCtrl 3007) ctrlSetText "N/A";
		(_control displayCtrl 3008) ctrlSetText "N/A";
		(_control displayCtrl 3009) ctrlSetText "N/A";
		(_control displayCtrl 3010) ctrlSetText "N/A";
		(_control displayCtrl 3011) ctrlSetText "N/A";
		(_control displayCtrl 3012) ctrlSetText "N/A";
		(_control displayCtrl 3013) ctrlSetText "N/A";
	};
};