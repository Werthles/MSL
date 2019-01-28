//Messages.sqf
//Runs on all players
//Called from all players and server
//Called from many other scripts
//Takes ID number and args and shows a hint

//pvs
private ["_hintID", "_args", "_hintArray", "_lineString", "_breakString", "_fontChange", "_fontEnd", "_header", "_footer", "_body", "_memberMoney"];

//var init
_hintID = _this select 0;
_args = _this select 1;

_hintArray = "";
_lineString = "<t color='#4C4C00' align='center'>--------------------------------------------------</t>";
_breakString = "<br/>";
_fontChange = "<t color='#CCCC99' align='center'>";
_fontEnd = "</t>";

_header = _lineString + _breakString + _fontChange;
_footer = _fontEnd + _breakString + _lineString;
_body = "";

_hintArray = _hintArray + _header;

switch (_hintID) do
{
	case 0:{//BlockRequests.sqf
		_body = "Job offers from other players are now blocked";
	};
	case 1:{//BlockRequests.sqf
		_body = "Other players can now offer you jobs";
	};
	case 2:{//CreateCiv.sqf
		_body = _args + " doesn't want to work for you!";
	};
	case 3:{//CurrentMission.sqf
		_body = "You are not currently on a job!";
	};
	case 4:{//HireCiv.sqf
		_body = _args + " is in your squad.";
	};
	case 5:{//HireCiv.sqf
		_body = _args + " is on another job.";
	};
	case 6:{//HireCiv.sqf
		_body = _args + " is asking to join your job!";
	};
	case 7:{//HireCiv.sqf
		_body = _args + " has been notified of your request!";
	};
	case 8:{//HireCiv.sqf
		_body = "Both you and " + _args + " are not on jobs.";
	};
	case 9:{//HireCiv.sqf
		_body = "Only group leaders can try to hire civilians.";
	};
	case 10:{//HirePlayer.sqf
		_body = _args + " is in your squad.";
	};
	case 11:{//HirePlayer.sqf
		_body = _args + " is on another job.";
	};
	case 12:{//HirePlayer.sqf
		_body = _args + " is asking to join your job!";
	};
	case 13:{//HirePlayer.sqf
		_body = _args + " has been informed you wish to join their team.";
	};
	case 14:{//HirePlayer.sqf
		_body = _args + " is not on a job.";
	};
	case 15:{//HirePlayer.sqf
		_body = "Only group leaders can offer missions to players.";
	};
	case 16:{//Kick.sqf
		_body = "It has been over " + str (floor(KickTimeLimit/60)) + " minutes since you started your job, so you cannot kick " + _args +". You can cancel and restart the job if necessary.";
	};
	case 17:{//Kick.sqf
		_body = _args + " is not in your squad!";
	};
	case 18:{//Kick.sqf
		_body = "You are not currently on a job.";
	};
	case 19:{//Kick.sqf
		_body = "Only squad leaders can kick squadmates.";
	};
	case 20:{//LoadMission.sqf
		_body = "You cannot accept new jobs if you are already part of a squad!";
	};
	case 21:{//LoadMission.sqf
		_body = "You cannot accept new jobs if you are already leading one!";
	};
	case 22:{//LoadMission.sqf
		_body = "Loading Job . . .";
	};
	case 23:{//Money.sqf
		_body = "T$ "+(str _args)+"000";
	};
	case 24:{//OfferMission.sqf
		_body = _args + " does not want to join any jobs right now!";
	};
	case 25:{//SpeakToNPC.sqf
		_body = "All jobs from "+_args+" have been completed!";
	};
	case 26:{//SpeakToNPC.sqf
		_body = _args + " has no interest in working for you!";
	};
	case 27:{//SpeakToNPC.sqf
		_body = _args + " is out of range! (>10m)";
	};
	case 28:{//SpeakToNPC.sqf
		_body = "You are not interacting with anyone! Point at a player/leader then press 'U' to offer/request jobs.";
	};
	case 29:{//Garage.sqf
		_body = "Exit your vehicle or become its commander.";
	};
	case 30:{//JobFinished.sqf
		_body = format["Cash Update: T$ %1%3 (%2%3)",(_args select 0),(_args select 1),"000"];
	};
	case 31:{//LoadPersonalTask.sqf
		_body = "This job is already in progress.";
	};
	case 32:{//LoadPersonalTask.sqf
		_body = "This job is already in progress, led by " + _args + ".";
	};
	case 33:{//LoadPersonalTask.sqf
		_body = "Sorry, the server is already running the maximum number of jobs (7). You can still help out on another job!";
	};
	case 34:{
		_body = "Job "+(_args select 0)+" for "+(_args select 1)+" loaded";
	};
	case 35:{
		_body = "The group leader must transport the loot. You cannot steal it from them!";
	};
	case 36:{
		_body = "Loot acquired.";
	};
	case 37:{
		_body = "Your leader will share the loot when you arrive at the cache!";
	};
	case 38:{
		_body = "Protect the loot until your leader arrives!";
	};
	case 39:{
		_body = "Get closer to the drop off point! (15m)";
	};
	case 40:{
		_body = "Your leader must take the loot from you before distributing the loot.";
	};
	case 41:{//PMLocalSetup1.sqf
		_body = "Personal job loaded.";
	};
	case 42:{//PMRewardSplit.sqf
		_body = "Loot rewards have been distributed at the job's cache.";
	};
	case 43:{//PMSetup.sqf
		_body = "You're too close to start this job! ("+(str _args)+"m)";
	};
	case 44:{//PMSetup.sqf
		_body = "Quit your current job first to start this job!";
	};
	case 45:{//SaveLocation Event
		_body = "Location saved.";
	};
	case 46:{//safezone.sqf
		_body = "You have left the Safe Spawn Zone! You will not be protected if you re-enter it!";
	};
	case 47:{//EntityKilled Event
		_body = (_args select 0)+" killed "+(_args select 1)+". Players can be kicked with enough kick votes. To vote to kick a player, got to Map -> Players.";
	};
	case 48:{//SaveMoney Event
		_body = "Cash saved.";
	};
	case 49:{//GarageStore Event
		_body = "Vehicle saved.";
	};
	case 50:{//GarageAccess Event
		_body = "You do not have a vehicle stored at this garage.";
	};
	case 51:{//GarageAccess Event
		_body = "Vehicle unstored.";
	};
	case 52:{//SaveGear Event
		_body = "Gear saved.";
	};
	case 53:{//PMEnd Event
		_body = "Total Cash: T$ " + str _memberMoney + "000";
	};
	case 54:{//QuitMission Event
		_body = "Job aborted. Group disbanded.";
	};
	case 55:{//QuitMission Event
		_body = "Job abandoned. Group left.";
	};
	case 56:{
		_body = "Get closer! You cannot see the TV from here. (>10m)";
	};
	case 57:{
		_body = "Loot acquired. Take the loot to the drop off shown.";
	};
	case 58:{
		_body = "Your previous job started less than 60 seconds ago. Please wait to start a new job!";
	};
	case 59:{
		_body = "Your previous job ended less than 60 seconds ago. Please wait to start a new job!";
	};
	case 60:{
		_body = format["Health at %1%2",ceil((1-_args)*100),"%"];
	};
	case 61:{
		_body = format["You have joined %1's team.",name _args];
	};
	case 62:{
		_body = format["%2 has killed %1.", _args select 0, _args select 1];
	};
	case 63:{
		_body = "Markers added to map.";
	};
	case 64:{
		_body = "Markers removed from map.";
	};
	case 65:{
		_body = format["You need to strengthen the Leader's position before you can relax! Complete at least 30 jobs for the Tanoan Leaders (currently %1).",_args];
	};
	case 66:{
		_body = format["%1 is sending help!",name _args];
	};
	case 67:{
		_body = format["You don't have enough money to hire people for your personal mission! (T$%1,000)",_args];
	};
	case 68:{
		_body = "You can only save your crate gear/loadout once every 60 seconds!";
	};
	case 69:{
		_body = format["GEAR NOT SAVED. Your Cache at location %1 - %2 is too full! (Max. 20 weapons plus 20 differnet types of item/magazine/backpack per cache.) Please remove some items and try again!",floor(_args select 0),floor(_args select 1)];
	};
	case 70:{
		_body = format["%1 is NOT sending help!",name _args];
	};
	default {
		_hintArray = _hintArray + _args;
	};
};

_hintArray = _hintArray + _body;
_hintArray = _hintArray + _footer;

//show hint
hint str _hintArray;
hint (parseText _hintArray);