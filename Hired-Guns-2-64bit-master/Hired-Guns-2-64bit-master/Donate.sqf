//donate function
//player to GUITargetObject donation

if (isPlayer GUITargetObject) then
{
	if not (player==GUITargetObject) then
	{
		DonateVar = [player,GUITargetObject];

		publicVariableServer "DonateVar";
	}
	else
	{
		[-1,"You must select another player to donate money to!"] call Messages;
	};
}
else
{
	[-1,"You must select another player to donate money to!"] call Messages;
};