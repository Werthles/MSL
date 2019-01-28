//AddBreifings.sqf
//Runs on all players
//Called from server/player
//Called by JobFinished.sqf and initPlayerLocal.sqf

//pvs
private ["_newPlayer", "_i", "_NPC", "_NPCName", "_shortDescription", "_j", "_SD", "_missionNumber", "_NPCNumber"];

_newPlayer = _this select 0;
waitUntil{!isNil "descriptionArray"};
if (_newPlayer) then
{
	player createDiarySubject ["HG2","Job Progress"];
	for [{_i=9}, {_i>-1}, {_i=_i-1}] do
	{
		_NPC = missionNamespace getVariable format["NPC%1",_i];
		_NPCName = name _NPC;
		_shortDescription = "";
		for [{_j=0}, {_j<10}, {_j=_j+1}] do
		{
			if (((Progress select _i) select _j) > 0) then
			{
				//_SD = [_NPC,_j] call GetShortDescription;
				_SD = descriptionArray select _i select _j;
				_shortDescription = _shortDescription + "<br/><br/>" + "Job " + str (_j + 1) + "<br/>" + _SD + " (x" + (str ((Progress select _i) select _j)) +")";
			};
		};
		
		player createDiaryRecord ["HG2",[_NPCName,"<font color='#0d4f0d' face='PuristaBold' size=20>Jobs previously completed for " + _NPCName + "</font>
			<font color='#0d4f0d' face='PuristaBold' size=12>" + _shortDescription + "</font>"]];
	};
}
else
{
	_NPC = _this select 1;
	_missionNumber = (_this select 2);
	_NPCName = name _NPC;
	_NPCNumber = parseNumber(_NPCName select [3,1]);
	//_shortDescription = [_NPC,_missionNumber] call GetShortDescription; 
	_shortDescription = descriptionArray select _NPCNumber select _missionNumber;
	
	player createDiaryRecord ["HG2",[_NPCName,"<font color='#CC0000' face='PuristaBold' size=12>Job " + str (_missionNumber + 1) + " - COMPLETED<br/>"+ _shortDescription]];
};