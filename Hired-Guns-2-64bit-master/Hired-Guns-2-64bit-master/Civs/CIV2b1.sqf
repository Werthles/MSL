//AT
//Type 3
//Grade 2

_this forceAddUniform "U_I_C_Soldier_Para_4_F";
_this addItemToUniform "FirstAidKit";
_this addItemToUniform "Chemlight_blue";
_this addItemToUniform "SmokeShellRed";
_this addItemToUniform "SmokeShell";
for "_i" from 1 to 2 do {_this addItemToUniform "30Rnd_45ACP_Mag_SMG_01";};
_this addVest "V_TacChestrig_cbr_F";
_this addItemToVest "HandGrenade";
_this addItemToVest "SmokeShellGreen";
_this addItemToVest "SmokeShellYellow";
_this addItemToVest "MiniGrenade";
for "_i" from 1 to 9 do {_this addItemToVest "30Rnd_45ACP_Mag_SMG_01";};
_this addBackpack "B_Carryall_cbr";
for "_i" from 1 to 4 do {_this addItemToBackpack "NLAW_F";};
_this addHeadgear "H_HelmetB_light_desert";
_this addGoggles "G_Bandanna_tan";

_this addWeapon "SMG_01_F";
_this addPrimaryWeaponItem "optic_Holosight_blk_F";
_this addWeapon "launch_NLAW_F";

_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadio";
_this linkItem "ItemGPS";