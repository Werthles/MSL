//Marksman
//Type 2
//Grade 1

_this forceAddUniform "U_I_C_Soldier_Bandit_1_F";
_this addItemToUniform "FirstAidKit";
for "_i" from 1 to 4 do {_this addItemToUniform "10Rnd_9x21_Mag";};
_this addItemToUniform "MiniGrenade";
_this addVest "V_HarnessO_ghex_F";
_this addItemToVest "Chemlight_blue";
for "_i" from 1 to 7 do {_this addItemToVest "10Rnd_93x64_DMR_05_Mag";};
_this addItemToVest "SmokeShellGreen";
_this addItemToVest "SmokeShell";
_this addHeadgear "H_MilCap_ghex_F";

_this addWeapon "srifle_DMR_05_hex_F";
_this addPrimaryWeaponItem "optic_DMS";
_this addWeapon "hgun_Pistol_01_F";
_this addWeapon "Binocular";

_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadio";
_this linkItem "ItemGPS";