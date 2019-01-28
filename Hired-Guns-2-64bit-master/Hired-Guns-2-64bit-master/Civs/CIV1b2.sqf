//Marksman
//Type 2
//Grade 3

_this forceAddUniform "U_B_T_FullGhillie_tna_F";
_this addItemToUniform "FirstAidKit";
_this addItemToUniform "Chemlight_blue";
_this addItemToUniform "SmokeShellPurple";
_this addItemToUniform "MiniGrenade";
_this addItemToUniform "SmokeShellOrange";
for "_i" from 1 to 2 do {_this addItemToUniform "16Rnd_9x21_Mag";};
_this addItemToUniform "7Rnd_408_Mag";
_this addItemToUniform "30Rnd_9x21_Mag";
_this addVest "V_PlateCarrier2_rgr_noflag_F";
_this addItemToVest "SmokeShellOrange";
for "_i" from 1 to 9 do {_this addItemToVest "7Rnd_408_Mag";};
_this addItemToVest "30Rnd_9x21_Mag";

_this addWeapon "srifle_LRR_tna_F";
_this addPrimaryWeaponItem "optic_LRPS_tna_F";
_this addWeapon "hgun_P07_khk_F";
_this addHandgunItem "muzzle_snds_L";
_this addWeapon "Rangefinder";

_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadio";
_this linkItem "ItemGPS";