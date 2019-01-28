//JoinTeamGUIAccept.sqf
//runs if player accepts join team offer gui

//no pvs

closeDialog 0;
[player] join (group _this);
[61,leader (group _this)] call Messages;