//Rifleman
//Type 1
//Grade 3

_this forceAddUniform "U_O_V_Soldier_Viper_F";
for "_i" from 1 to 2 do {_this addItemToUniform "16Rnd_9x21_Mag";};
_this addItemToUniform "Chemlight_blue";
_this addItemToUniform "Laserbatteries";
_this addVest "V_PlateCarrier2_rgr_noflag_F";
_this addItemToVest "FirstAidKit";
for "_i" from 1 to 2 do {_this addItemToVest "30Rnd_556x45_Stanag";};
for "_i" from 1 to 2 do {_this addItemToVest "16Rnd_9x21_Mag";};
_this addItemToVest "1Rnd_SmokeRed_Grenade_shell";
_this addItemToVest "UGL_FlareRed_F";
_this addBackpack "B_ViperLightHarness_ghex_F";
_this addItemToBackpack "RPG7_F";
_this addItemToBackpack "IEDUrbanBig_Remote_Mag";
_this addItemToBackpack "SmokeShellPurple";
_this addItemToBackpack "SmokeShellBlue";
_this addItemToBackpack "SmokeShellOrange";
_this addItemToBackpack "MiniGrenade";
for "_i" from 1 to 2 do {_this addItemToBackpack "HandGrenade";};
for "_i" from 1 to 3 do {_this addItemToBackpack "1Rnd_HE_Grenade_shell";};
for "_i" from 1 to 10 do {_this addItemToBackpack "30Rnd_556x45_Stanag_Tracer_Green";};
_this addHeadgear "H_HelmetB_Enh_tna_F";
_this addGoggles "G_Balaclava_TI_G_tna_F";

_this addWeapon "arifle_SPAR_01_GL_khk_F";
_this addPrimaryWeaponItem "muzzle_snds_m_khk_F";
_this addPrimaryWeaponItem "acc_flashlight";
_this addPrimaryWeaponItem "optic_ERCO_khk_F";
_this addWeapon "launch_RPG7_F";
_this addWeapon "hgun_P07_khk_F";
_this addHandgunItem "muzzle_snds_L";
_this addWeapon "Laserdesignator_01_khk_F";

_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadio";
_this linkItem "ItemGPS";