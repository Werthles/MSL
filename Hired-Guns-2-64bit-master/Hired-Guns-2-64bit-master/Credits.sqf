//needs to be remoteExec
titleText ["", "BLACK OUT",5];
sleep 4;

_video = ["video\Credits.ogv"] spawn BIS_fnc_playVideo;
sleep 2;
titleText ["", "BLACK IN",1];

//wait until video is over
waitUntil {scriptDone _video};


//turn off saving again
enableSaving [false,false];