//Marksman
//Type 2
//Grade 2

_this forceAddUniform "U_O_T_Sniper_F";
_this addItemToUniform "FirstAidKit";
for "_i" from 1 to 3 do {_this addItemToUniform "16Rnd_9x21_Mag";};
_this addItemToUniform "Chemlight_blue";
_this addItemToUniform "SmokeShellPurple";
_this addItemToUniform "MiniGrenade";
_this addVest "V_PlateCarrier1_rgr_noflag_F";
for "_i" from 1 to 11 do {_this addItemToVest "20Rnd_762x51_Mag";};
_this addItemToVest "SmokeShellOrange";

_this addWeapon "srifle_DMR_03_woodland_F";
_this addPrimaryWeaponItem "optic_AMS_khk";
_this addWeapon "hgun_P07_khk_F";
_this addHandgunItem "muzzle_snds_L";
_this addWeapon "Rangefinder";

_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadio";
_this linkItem "ItemGPS";