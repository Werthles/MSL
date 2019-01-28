//Rifleman
//Type 1
//Grade 1

_this forceAddUniform "U_I_C_Soldier_Bandit_3_F";
_this addItemToUniform "FirstAidKit";
for "_i" from 1 to 2 do {_this addItemToUniform "10Rnd_9x21_Mag";};
_this addItemToUniform "SmokeShellRed";
_this addItemToUniform "30Rnd_762x39_Mag_Green_F";
_this addVest "V_TacChestrig_oli_F";
for "_i" from 1 to 3 do {_this addItemToVest "30Rnd_762x39_Mag_F";};
for "_i" from 1 to 3 do {_this addItemToVest "30Rnd_762x39_Mag_Green_F";};
_this addItemToVest "Chemlight_blue";
_this addItemToVest "MiniGrenade";
_this addItemToVest "IEDUrbanSmall_Remote_Mag";
_this addHeadgear "H_Cap_grn";
_this addGoggles "G_Bandanna_beast";

_this addWeapon "arifle_AKM_F";
_this addWeapon "hgun_Pistol_01_F";
_this addWeapon "Rangefinder";

_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadio";
_this linkItem "ItemGPS";
