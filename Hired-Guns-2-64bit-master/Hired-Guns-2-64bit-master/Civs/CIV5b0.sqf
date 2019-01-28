//AA
//Type 6
//Grade 1

_this forceAddUniform "U_I_C_Soldier_Bandit_5_F";
_this addItemToUniform "FirstAidKit";
for "_i" from 1 to 2 do {_this addItemToUniform "30Rnd_9x21_Mag_SMG_02";};
_this addItemToUniform "Chemlight_blue";
_this addVest "V_BandollierB_ghex_F";
for "_i" from 1 to 6 do {_this addItemToVest "30Rnd_9x21_Mag_SMG_02";};
_this addItemToVest "HandGrenade";
_this addItemToVest "SmokeShellGreen";
_this addItemToVest "SmokeShellYellow";
_this addBackpack "B_FieldPack_cbr";
for "_i" from 1 to 2 do {_this addItemToBackpack "RPG32_F";};
for "_i" from 1 to 2 do {_this addItemToBackpack "RPG32_HE_F";};
_this addGoggles "G_Bandanna_khk";

_this addWeapon "SMG_05_F";
_this addWeapon "launch_RPG32_ghex_F";

_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadio";
_this linkItem "ItemGPS";