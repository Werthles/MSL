waitUntil {!isNull player};
player addAction ["<t color='#FF5500'>Missions Save/Load</t>",{createdialog "MSLDialog";},[],-999,false,true,"","isServer or serverCommandAvailable ""#kick"""];


//if server, set up 
if (isServer) then
{
	_inidbiSAVELIST = ["new", "SAVELIST"] call OO_INIDBI;
	["write", ["FileListFile", "Message", "Do not remove"]] call _inidbiSAVELIST;
	["delete", _inidbiSAVELIST] call OO_INIDBI;
};
 