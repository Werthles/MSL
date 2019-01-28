//AT
//Type 3
//Grade 3

_this forceAddUniform "U_BG_Guerilla2_1";
_this addItemToUniform "FirstAidKit";
_this addItemToUniform "Chemlight_blue";
_this addItemToUniform "SmokeShell";
_this addItemToUniform "SmokeShellYellow";
_this addItemToUniform "30Rnd_9x21_Mag_SMG_02_Tracer_Red";
_this addVest "V_PlateCarrier1_rgr_noflag_F";
for "_i" from 1 to 4 do {_this addItemToVest "30Rnd_9x21_Mag_SMG_02_Tracer_Red";};
_this addItemToVest "MiniGrenade";
_this addBackpack "B_Bergen_tna_F";
for "_i" from 1 to 3 do {_this addItemToBackpack "Titan_AT";};
_this addHeadgear "H_HelmetSpecB_sand";
_this addGoggles "G_Bandanna_tan";

_this addWeapon "SMG_02_F";
_this addPrimaryWeaponItem "optic_Holosight_smg_blk_F";
_this addWeapon "launch_B_Titan_short_tna_F";

_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadio";
_this linkItem "ItemGPS";