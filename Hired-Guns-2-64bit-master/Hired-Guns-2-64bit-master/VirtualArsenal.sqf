//Virtual Ammo
waitUntil{time>10};
sleep 10;
["AmmoboxInit",[player,false,{false}]] spawn BIS_fnc_arsenal;
//[player,["arifle_MX_F","arifle_MX_SW_F","arifle_MXC_F"],false] call BIS_fnc_addVirtualWeaponCargo;
[player,["arifle_AKS_F","arifle_MX_F"],false] call BIS_fnc_addVirtualWeaponCargo;
[player,["30Rnd_545x39_Mag_Tracer_Green_F","30Rnd_65x39_caseless_mag_Tracer"],false] call BIS_fnc_addVirtualMagazineCargo;
//[player,["optic_ACO_grn"],false] call BIS_fnc_addVirtualItemCargo;
[player,["B_AssaultPack_khk"],false] call BIS_fnc_addVirtualBackpackCargo;
{
	_x addAction ["<t color='#E79600'>Basic Supplies (Non-Saving)<t/>","[""Open"",[nil,player,player]] spawn BIS_fnc_arsenal;",[],200,true,true];
}forEach [W0,W1,W2,W3,W4,W5,W6,W7,W8,W9];