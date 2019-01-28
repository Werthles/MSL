//Credits.sqf
//Runs on player
//Called from player's GUI
//Shows into video with texts

//pvs
private ["_video"];

//close GUI
closeDialog 0;
sleep 0.05;
closeDialog 0;

//play video
//_video = ["video\Credits.ogv"] spawn BIS_fnc_playVideo;

//wait until video is over
//waitUntil {scriptDone _video};

//turn off saving again
//enableSaving [false,false];

[] call Credits;