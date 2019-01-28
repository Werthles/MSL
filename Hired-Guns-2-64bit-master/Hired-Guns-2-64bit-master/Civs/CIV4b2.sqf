//MG
//Type 5
//Grade 3

_this forceAddUniform "U_O_V_Soldier_Viper_F";
_this addItemToUniform "FirstAidKit";
_this addItemToUniform "Chemlight_blue";
_this addItemToUniform "SmokeShellBlue";
_this addItemToUniform "SmokeShellRed";
_this addVest "V_PlateCarrier1_rgr_noflag_F";
for "_i" from 1 to 2 do {_this addItemToVest "130Rnd_338_Mag";};
for "_i" from 1 to 3 do {_this addItemToVest "16Rnd_9x21_Mag";};
_this addBackpack "B_ViperLightHarness_ghex_F";
for "_i" from 1 to 3 do {_this addItemToBackpack "130Rnd_338_Mag";};
_this addHeadgear "H_HelmetB_Enh_tna_F";
_this addGoggles "G_Combat_Goggles_tna_F";

_this addWeapon "MMG_02_camo_F";
_this addPrimaryWeaponItem "muzzle_snds_338_sand";
_this addPrimaryWeaponItem "acc_pointer_IR";
_this addPrimaryWeaponItem "optic_ERCO_khk_F";
_this addPrimaryWeaponItem "bipod_02_F_hex";
_this addWeapon "hgun_P07_khk_F";
_this addHandgunItem "muzzle_snds_L";
_this addWeapon "Rangefinder";

comment "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadio";
_this linkItem "ItemGPS";
_this linkItem "O_NVGoggles_ghex_F";