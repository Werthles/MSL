//intro.sqf
//Runs on players
//Called from player on joining HG2
//Called from onPreloadFinished in initPlayerLocal.sqf or onPlayerRespawn.sqf
//Short camera pan to player, with welcome to new players

//pvs
private ["_respawn", "_view", "_cam", "_handle", "_profNam"];

_respawn = _this select 0;

//camera start pos
_view = (getPos player) vectorAdd ((((mountainPeak vectorDiff (getPos player)) vectorMultiply (1/(mountainPeak vectorDistance (getPos player)))) vectorMultiply 1000) vectorMultiply -1);
_view set [2,400];

_cam = "camera" CamCreate _view;
_cam camCommand "inertia on";
_cam CamSetTarget player;
_cam CameraEffect ["Internal","Back"];
_cam CamCommit 0;

if !(daytime >=5 or daytime<=21) then
{
	camUseNVG true;
};

_cam CamSetPos ((getPos player) vectorAdd [0,0,1.5]);

titleText ["", "BLACK IN",5];

if not (_respawn) then {cutText ["Strengthen the leaders of Tanoa to be able to fight against a CSAT invasion.","PLAIN DOWN"];};

sleep 2;

if not (_respawn) then {titleRsc["introImage", "PLAIN", 2];};

_cam CamCommit 8; //15
sleep 3;

if not (_respawn) then {cutText ["Take jobs from leaders by meeting with them.", "PLAIN DOWN"];};

sleep 4.85; //14.8

if not (_respawn) then {cutText ["Point, press ""U"" and select ""Hire/Get Hired"" to build/join teams and request jobs.","PLAIN DOWN"];};
		
_cam CameraEffect ["Terminate","Back"];
CamDestroy _cam;

enableSaving [false,false];

//get around target bug?
//_handle=createdialog "HG_GUIMain";
//closeDialog 0;
//closeDialog 0;
if not (_respawn) then
{
	sleep 15;

	//Welcome Message
	_profNam = profileName;
	if (_profNam == "") then
	{
		_profNam = "";
	} else 
	{
		_profNam = " " + _profNam + ",";
	};
	["Welcome To","Hired Guns 2","By Werthles"] spawn BIS_fnc_infoText;
};