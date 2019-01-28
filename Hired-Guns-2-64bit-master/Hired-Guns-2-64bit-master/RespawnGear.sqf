//RespawnGear.sqf
//Runs on player
//Called by player
//Called from Respawn mission event or on first connect from GearSetup.sqf

//private["_i"];

//Player - Hired Gun Default, set player's gear
removeAllWeapons player;
removeAllItems player;
removeAllAssignedItems player;
removeUniform player;
removeVest player;
removeBackpack player;
removeHeadgear player;
removeGoggles player;
player forceAddUniform "U_IG_Guerilla1_1";
player addItemToUniform "FirstAidKit";
for "_i" from 1 to 3 do {player addItemToUniform "11Rnd_45ACP_Mag";};
player addVest "V_Rangemaster_belt";
player addItemToVest "HandGrenade";
player addItemToVest "SmokeShellOrange";
player addItemToVest "SmokeShellPurple";
for "_i" from 1 to 2 do {player addItemToVest "11Rnd_45ACP_Mag";};
player addItemToVest "SmokeShellGreen";
player addItemToVest "SmokeShell";
player addHeadgear "H_Hat_camo";
player addWeapon "hgun_Pistol_heavy_01_F";
player addHandgunItem "muzzle_snds_acp";
player addHandgunItem "optic_MRD";
player addWeapon "Binocular";
player linkItem "ItemMap";
player linkItem "ItemCompass";
player linkItem "ItemWatch";
player linkItem "ItemRadio";
player linkItem "ItemGPS";

//save gear
execVM "SaveGear.sqf";