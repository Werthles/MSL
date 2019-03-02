//hint "MSLLocalUpdates";
//player setPos [500,500,500];
//_Rdate,_RwindStr
params [["_success",false,[false]],["_Rdate",date,[[]]],["_switchObject",objNull,[objNull]]];

setDate _Rdate;

selectPlayer _switchObject;
//hint "MSLLU " + (str _switchObject);

player addAction ["<t color='#FF5500'>Missions Save/Load</t>",{createdialog "MSLDialog";},[],-999,false,true,"","isServer or serverCommandAvailable ""#kick"""];