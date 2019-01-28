//MG
//Type 5
//Grade 1

_this forceAddUniform "U_B_CTRG_Soldier_urb_2_F";
_this addItemToUniform "200Rnd_556x45_Box_F";
_this addVest "V_TacVestIR_blk";
_this addItemToVest "FirstAidKit";
for "_i" from 1 to 3 do {_this addItemToVest "200Rnd_556x45_Box_Red_F";};
_this addItemToVest "SmokeShellYellow";
_this addItemToVest "SmokeShellPurple";
_this addItemToVest "Chemlight_blue";
_this addHeadgear "H_Helmet_Skate";
_this addGoggles "G_Bandanna_sport";

_this addWeapon "LMG_03_F";
_this addPrimaryWeaponItem "optic_Holosight_blk_F";
_this addWeapon "Binocular";

_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadio";
_this linkItem "ItemGPS";