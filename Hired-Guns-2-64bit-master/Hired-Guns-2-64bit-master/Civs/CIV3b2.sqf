//Support
//Type 4
//Grade 3

_this forceAddUniform "U_C_Scientist";
for "_i" from 1 to 2 do {_this addItemToUniform "FirstAidKit";};
_this addItemToUniform "SmokeShellOrange";
_this addVest "V_PlateCarrierSpec_blk";
for "_i" from 1 to 3 do {_this addItemToVest "20Rnd_650x39_Cased_Mag_F";};
_this addBackpack "B_Bergen_mcamo_F";
for "_i" from 1 to 30 do {_this addItemToBackpack "FirstAidKit";};
for "_i" from 1 to 3 do {_this addItemToBackpack "SmokeShellYellow";};
for "_i" from 1 to 3 do {_this addItemToBackpack "SmokeShell";};
for "_i" from 1 to 3 do {_this addItemToBackpack "SmokeShellRed";};
for "_i" from 1 to 3 do {_this addItemToBackpack "SmokeShellPurple";};
for "_i" from 1 to 3 do {_this addItemToBackpack "SmokeShellOrange";};
for "_i" from 1 to 3 do {_this addItemToBackpack "SmokeShellGreen";};
for "_i" from 1 to 3 do {_this addItemToBackpack "SmokeShellBlue";};
for "_i" from 1 to 3 do {_this addItemToBackpack "HandGrenade";};
for "_i" from 1 to 3 do {_this addItemToBackpack "MiniGrenade";};
_this addItemToBackpack "I_IR_Grenade";
for "_i" from 1 to 6 do {_this addItemToBackpack "20Rnd_650x39_Cased_Mag_F";};

_this addWeapon "srifle_DMR_07_ghex_F";
_this addPrimaryWeaponItem "muzzle_snds_H_khk_F";
_this addPrimaryWeaponItem "optic_LRPS_ghex_F";
_this addWeapon "Binocular";

_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadio";
_this linkItem "ItemGPS";