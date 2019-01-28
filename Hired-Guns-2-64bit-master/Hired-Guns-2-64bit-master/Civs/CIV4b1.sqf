//MG
//Type 5
//Grade 2

_this forceAddUniform "U_B_CTRG_Soldier_F";
_this addItemToUniform "FirstAidKit";
_this addItemToUniform "Chemlight_blue";
_this addItemToUniform "SmokeShellBlue";
_this addItemToUniform "SmokeShellRed";
for "_i" from 1 to 5 do {_this addItemToUniform "10Rnd_9x21_Mag";};
_this addVest "V_TacVestIR_blk";
for "_i" from 1 to 2 do {_this addItemToVest "150Rnd_93x64_Mag";};
_this addBackpack "B_FieldPack_ghex_F";
for "_i" from 1 to 2 do {_this addItemToBackpack "150Rnd_93x64_Mag";};
_this addHeadgear "H_HelmetCrew_B";
_this addGoggles "G_Bandanna_sport";

_this addWeapon "MMG_01_hex_F";
_this addPrimaryWeaponItem "optic_ERCO_snd_F";
_this addPrimaryWeaponItem "bipod_02_F_hex";
_this addWeapon "hgun_Pistol_01_F";
_this addWeapon "Binocular";

_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadio";
_this linkItem "ItemGPS";