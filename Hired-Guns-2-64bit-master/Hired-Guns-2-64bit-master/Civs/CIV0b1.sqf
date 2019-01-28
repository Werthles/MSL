//Rifleman
//Type 1
//Grade 2

_this forceAddUniform "U_I_C_Soldier_Para_1_F";
for "_i" from 1 to 3 do {_this addItemToUniform "16Rnd_9x21_Mag";};
_this addItemToUniform "Chemlight_blue";
_this addItemToUniform "SmokeShellYellow";
_this addItemToUniform "SmokeShellOrange";
_this addItemToUniform "HandGrenade";
_this addVest "V_PlateCarrier1_rgr_noflag_F";
_this addItemToVest "FirstAidKit";
_this addItemToVest "UGL_FlareRed_F";
for "_i" from 1 to 5 do {_this addItemToVest "30Rnd_580x42_Mag_F";};
for "_i" from 1 to 5 do {_this addItemToVest "30Rnd_580x42_Mag_Tracer_F";};
for "_i" from 1 to 5 do {_this addItemToVest "1Rnd_HE_Grenade_shell";};
_this addItemToVest "1Rnd_SmokeRed_Grenade_shell";
_this addItemToVest "1Rnd_SmokePurple_Grenade_shell";
_this addHeadgear "H_HelmetB_Enh_tna_F";
_this addGoggles "G_Combat_Goggles_tna_F";

_this addWeapon "arifle_CTAR_GL_ghex_F";
_this addPrimaryWeaponItem "optic_Arco_ghex_F";
_this addWeapon "hgun_P07_khk_F";
_this addHandgunItem "muzzle_snds_L";
_this addWeapon "Laserdesignator_03";

_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadio";
_this linkItem "ItemGPS";