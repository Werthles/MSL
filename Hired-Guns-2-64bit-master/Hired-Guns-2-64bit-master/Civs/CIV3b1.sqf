//Support
//Type 4
//Grade 2

_this forceAddUniform "U_Marshal";
for "_i" from 1 to 2 do {_this addItemToUniform "FirstAidKit";};
_this addItemToUniform "SmokeShellOrange";
_this addVest "V_TacVest_gen_F";
_this addBackpack "B_Carryall_ghex_F";
for "_i" from 1 to 20 do {_this addItemToBackpack "FirstAidKit";};
for "_i" from 1 to 2 do {_this addItemToBackpack "SmokeShellYellow";};
for "_i" from 1 to 2 do {_this addItemToBackpack "SmokeShell";};
for "_i" from 1 to 2 do {_this addItemToBackpack "SmokeShellRed";};
for "_i" from 1 to 2 do {_this addItemToBackpack "SmokeShellPurple";};
for "_i" from 1 to 2 do {_this addItemToBackpack "SmokeShellOrange";};
for "_i" from 1 to 2 do {_this addItemToBackpack "SmokeShellGreen";};
for "_i" from 1 to 2 do {_this addItemToBackpack "SmokeShellBlue";};
for "_i" from 1 to 2 do {_this addItemToBackpack "HandGrenade";};
for "_i" from 1 to 2 do {_this addItemToBackpack "MiniGrenade";};
_this addItemToBackpack "I_IR_Grenade";
for "_i" from 1 to 8 do {_this addItemToBackpack "30Rnd_580x42_Mag_Tracer_F";};

_this addWeapon "arifle_CTAR_ghex_F";
_this addPrimaryWeaponItem "muzzle_snds_58_wdm_F";
_this addPrimaryWeaponItem "acc_pointer_IR";
_this addPrimaryWeaponItem "optic_Holosight_khk_F";
_this addWeapon "Binocular";

_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadio";
_this linkItem "ItemGPS";