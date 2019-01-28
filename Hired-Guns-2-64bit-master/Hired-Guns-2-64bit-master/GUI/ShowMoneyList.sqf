//ShowMoneyList.sqf
//Runs on player
//Called from player's GUI Money List
//Opens moneylist dialog

//no pvs

//close dialogs
closeDialog 0;
sleep 0.01;
closeDialog 0;

//create moneylist dialog
createDialog "HG_MoneyListGUI";