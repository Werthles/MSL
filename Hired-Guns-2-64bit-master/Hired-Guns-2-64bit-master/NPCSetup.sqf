//NPCSetup.sqf
//Runs on all machines
//Called from al machines
//Called from init.sqf
//Makes sure all NPCs look right

//private["_i"];
/* NPC List
0. Old Man
1. Cult Man
2. Entrepreneur
3. Drug Man 1 land
4. Slave Man
5. Mine Man
6. Market Man
7. Lottery Man
8. Drug Man 2 Sea
9. Drug Man 3 Air
*/
NPC0 setIdentity "NPC0";
NPC1 setIdentity "NPC1";
NPC2 setIdentity "NPC2";
NPC3 setIdentity "NPC3";
NPC4 setIdentity "NPC4";
NPC5 setIdentity "NPC5";
NPC6 setIdentity "NPC6";
NPC7 setIdentity "NPC7";
NPC8 setIdentity "NPC8";
NPC9 setIdentity "NPC9";
//NPC faces
NPC0 setFace "GreekHead_A3_04";
NPC0 setSpeaker "Male01ENGB";
[NPC0,"GryffinRegiment"] call bis_fnc_setUnitInsignia;
NPC1 setFace "WhiteHead_03";
NPC1 setSpeaker "Male01ENGB";
[NPC1,"Curator"] call bis_fnc_setUnitInsignia;
NPC2 setFace "AfricanHead_01";
NPC2 setSpeaker "Male01ENGB";
[NPC2,"TFAegis"] call bis_fnc_setUnitInsignia;
NPC3 setFace "WhiteHead_15";
NPC3 setSpeaker "Male01ENGB";
[NPC3,"TFAegis"] call bis_fnc_setUnitInsignia;
NPC4 setFace "AsianHead_A3_01";
NPC4 setSpeaker "Male01ENGB";
NPC5 setFace "PersianHead_A3_03";
NPC5 setSpeaker "Male01ENGB";
[NPC5,"MANW"] call bis_fnc_setUnitInsignia;
NPC6 setFace "AfricanHead_03";
NPC6 setSpeaker "Male01ENGB";
[NPC6,"BI"] call bis_fnc_setUnitInsignia;
NPC7 setFace "AfricanHead_02";
NPC7 setSpeaker "Male01ENGB";
NPC8 setFace "PersianHead_A3_01";
NPC8 setSpeaker "Male01ENGB";
[NPC8,"TFAegis"] call bis_fnc_setUnitInsignia;
NPC9 setFace "WhiteHead_04";
NPC9 setSpeaker "Male01ENGB";
[NPC9,"111thID"] call bis_fnc_setUnitInsignia;

if (isServer) then
{
	//Old Man NPC0
	removeAllWeapons NPC0;
	removeAllItems NPC0;
	removeAllAssignedItems NPC0;
	removeUniform NPC0;
	removeVest NPC0;
	removeBackpack NPC0;
	removeHeadgear NPC0;
	removeGoggles NPC0;
	NPC0 forceAddUniform "U_BG_Guerilla2_2";
	for "_i" from 1 to 2 do {NPC0 addItemToUniform "11Rnd_45ACP_Mag";};
	NPC0 addVest "V_BandollierB_ghex_F";
	for "_i" from 1 to 3 do {NPC0 addItemToVest "5Rnd_127x108_Mag";};
	NPC0 addGoggles "G_Aviator";
	NPC0 addWeapon "srifle_GM6_ghex_F";
	NPC0 addPrimaryWeaponItem "optic_LRPS_ghex_F";
	NPC0 addWeapon "launch_RPG7_F";
	NPC0 addWeapon "hgun_Pistol_heavy_01_F";
	NPC0 addHandgunItem "muzzle_snds_acp";
	NPC0 addHandgunItem "optic_MRD";
	NPC0 addWeapon "Binocular";
	NPC0 linkItem "ItemRadio";


	//NPC1 Cult Man
	removeAllWeapons NPC1;
	removeAllItems NPC1;
	removeAllAssignedItems NPC1;
	removeUniform NPC1;
	removeVest NPC1;
	removeBackpack NPC1;
	removeHeadgear NPC1;
	removeGoggles NPC1;
	NPC1 forceAddUniform "U_C_Scientist";
	NPC1 addItemToUniform "16Rnd_9x21_Mag";
	NPC1 addHeadgear "H_StrawHat";
	NPC1 addGoggles "G_Squares";
	NPC1 addWeapon "hgun_PDW2000_F";
	NPC1 addPrimaryWeaponItem "muzzle_snds_L";
	NPC1 addPrimaryWeaponItem "optic_LRPS";
	NPC1 addWeapon "hgun_P07_F";
	NPC1 addHandgunItem "muzzle_snds_L";
	NPC1 linkItem "ItemMap";
	NPC1 linkItem "ItemCompass";
	NPC1 linkItem "ItemWatch";
	NPC1 linkItem "ItemRadio";
	NPC1 linkItem "ItemGPS";


	//NPC3 Drug Man
	removeAllWeapons NPC3;
	removeAllItems NPC3;
	removeAllAssignedItems NPC3;
	removeUniform NPC3;
	removeVest NPC3;
	removeBackpack NPC3;
	removeHeadgear NPC3;
	removeGoggles NPC3;
	NPC3 forceAddUniform "U_BG_Guerilla3_1";
	for "_i" from 1 to 3 do {NPC3 addItemToUniform "9Rnd_45ACP_Mag";};
	NPC3 addVest "V_Chestrig_khk";
	NPC3 addItemToVest "200Rnd_65x39_cased_Box";
	NPC3 addBackpack "B_Carryall_khk";
	for "_i" from 1 to 2 do {NPC3 addItemToBackpack "200Rnd_65x39_cased_Box";};
	NPC3 addHeadgear "H_Bandanna_khk";
	NPC3 addWeapon "LMG_Mk200_F";
	NPC3 addPrimaryWeaponItem "acc_flashlight";
	NPC3 addPrimaryWeaponItem "optic_Holosight_smg";
	NPC3 addWeapon "hgun_ACPC2_F";
	NPC3 linkItem "ItemRadio";

	//NPC2 Investor
	removeAllWeapons NPC2;
	removeAllItems NPC2;
	removeAllAssignedItems NPC2;
	removeUniform NPC2;
	removeVest NPC2;
	removeBackpack NPC2;
	removeHeadgear NPC2;
	removeGoggles NPC2;
	NPC2 forceAddUniform "U_BG_Guerilla2_1";
	for "_i" from 1 to 3 do {NPC2 addItemToUniform "16Rnd_9x21_Mag";};
	NPC2 addVest "V_Chestrig_blk";
	for "_i" from 1 to 3 do {NPC2 addItemToVest "30Rnd_65x39_caseless_green";};
	NPC2 addBackpack "B_AssaultPack_blk";
	NPC2 addItemToBackpack "RPG32_F";
	NPC2 addGoggles "G_Bandanna_sport";
	NPC2 addWeapon "arifle_Katiba_F";
	NPC2 addPrimaryWeaponItem "muzzle_snds_H";
	NPC2 addPrimaryWeaponItem "acc_pointer_IR";
	NPC2 addPrimaryWeaponItem "optic_DMS";
	NPC2 addWeapon "launch_RPG32_F";
	NPC2 addWeapon "hgun_Rook40_F";
	NPC2 addHandgunItem "muzzle_snds_L";
	NPC2 addWeapon "Binocular";
	NPC2 linkItem "ItemRadio";

	//NPC4 Slave Man
	removeAllWeapons NPC4;
	removeAllItems NPC4;
	removeAllAssignedItems NPC4;
	removeUniform NPC4;
	removeVest NPC4;
	removeBackpack NPC4;
	removeHeadgear NPC4;
	removeGoggles NPC4;
	NPC4 forceAddUniform "U_I_G_resistanceLeader_F";
	for "_i" from 1 to 3 do {NPC4 addItemToUniform "30Rnd_45ACP_Mag_SMG_01";};
	NPC4 addBackpack "B_Respawn_Sleeping_bag_brown_F";
	NPC4 addHeadgear "H_Bandanna_sand";
	NPC4 addGoggles "G_Bandanna_tan";
	NPC4 addWeapon "SMG_01_F";
	NPC4 addPrimaryWeaponItem "optic_ACO_grn";
	NPC4 linkItem "ItemRadio";

	//NPC5 Mine Man
	removeAllWeapons NPC5;
	removeAllItems NPC5;
	removeAllAssignedItems NPC5;
	removeUniform NPC5;
	removeVest NPC5;
	removeBackpack NPC5;
	removeHeadgear NPC5;
	removeGoggles NPC5;
	NPC5 forceAddUniform "U_B_T_Soldier_F";
	for "_i" from 1 to 3 do {NPC5 addItemToUniform "30Rnd_556x45_Stanag";};
	NPC5 addVest "V_PlateCarrier2_blk";
	NPC5 addBackpack "B_AssaultPack_blk";
	NPC5 addHeadgear "H_Beret_blk";
	NPC5 addGoggles "G_Spectacles";
	NPC5 addWeapon "arifle_SPAR_01_GL_blk_F";
	NPC5 addPrimaryWeaponItem "muzzle_snds_M";
	NPC5 addPrimaryWeaponItem "acc_pointer_IR";
	NPC5 addPrimaryWeaponItem "optic_LRPS";
	NPC5 addWeapon "hgun_Rook40_F";
	NPC5 addHandgunItem "muzzle_snds_L";
	NPC5 addWeapon "Laserdesignator";
	NPC5 linkItem "ItemRadio";

	//NPC6 Market Man
	removeAllWeapons NPC6;
	removeAllItems NPC6;
	removeAllAssignedItems NPC6;
	removeUniform NPC6;
	removeVest NPC6;
	removeBackpack NPC6;
	removeHeadgear NPC6;
	removeGoggles NPC6;
	NPC6 forceAddUniform "U_Rangemaster";
	for "_i" from 1 to 2 do {NPC6 addItemToUniform "16Rnd_9x21_Mag";};
	NPC6 addVest "V_PlateCarrier1_blk";
	NPC6 addItemToVest "16Rnd_9x21_Mag";
	for "_i" from 1 to 3 do {NPC6 addItemToVest "30Rnd_9x21_Mag";};
	NPC6 addBackpack "B_FieldPack_blk";
	NPC6 addItemToBackpack "RPG32_F";
	NPC6 addHeadgear "H_Hat_brown";
	NPC6 addWeapon "SMG_02_F";
	NPC6 addPrimaryWeaponItem "acc_flashlight";
	NPC6 addPrimaryWeaponItem "optic_Aco_smg";
	NPC6 addWeapon "launch_RPG32_F";
	NPC6 addWeapon "hgun_P07_F";
	NPC6 addWeapon "Binocular";
	NPC6 linkItem "ItemRadio";

	//NPC7 Lottery Man
	removeAllWeapons NPC7;
	removeAllItems NPC7;
	removeAllAssignedItems NPC7;
	removeUniform NPC7;
	removeVest NPC7;
	removeBackpack NPC7;
	removeHeadgear NPC7;
	removeGoggles NPC7;
	NPC7 forceAddUniform "U_Marshal";
	NPC7 addHeadgear "H_Hat_brown";
	NPC7 addGoggles "G_Shades_Black";
	NPC7 addWeapon "Rangefinder";
	NPC7 linkItem "ItemRadio";

	//NPC8 Drug Man 3
	removeAllWeapons NPC8;
	removeAllItems NPC8;
	removeAllAssignedItems NPC8;
	removeUniform NPC8;
	removeVest NPC8;
	removeBackpack NPC8;
	removeHeadgear NPC8;
	removeGoggles NPC8;
	NPC8 forceAddUniform "U_O_Wetsuit";
	for "_i" from 1 to 13 do {NPC8 addItemToUniform "20Rnd_556x45_UW_mag";};
	NPC8 addVest "V_RebreatherIR";
	NPC8 addBackpack "B_AssaultPack_rgr";
	for "_i" from 1 to 26 do {NPC8 addItemToBackpack "20Rnd_556x45_UW_mag";};
	NPC8 addHeadgear "H_StrawHat_dark";
	NPC8 addGoggles "G_O_Diving";
	NPC8 addWeapon "arifle_SDAR_F";
	NPC8 addWeapon "Binocular";
	NPC8 linkItem "NVGoggles_OPFOR";
	NPC8 linkItem "ItemRadio";

	//NPC9 Drug Man 4
	removeAllWeapons NPC9;
	removeAllItems NPC9;
	removeAllAssignedItems NPC9;
	removeUniform NPC9;
	removeVest NPC9;
	removeBackpack NPC9;
	removeHeadgear NPC9;
	removeGoggles NPC9;
	NPC9 forceAddUniform "U_B_PilotCoveralls";
	for "_i" from 1 to 3 do {NPC9 addItemToUniform "11Rnd_45ACP_Mag";};
	for "_i" from 1 to 2 do {NPC9 addItemToUniform "30Rnd_65x39_caseless_green";};
	NPC9 addVest "V_TacVest_blk";
	NPC9 addItemToVest "30Rnd_65x39_caseless_green";
	NPC9 addHeadgear "H_MilCap_blue";
	NPC9 addGoggles "G_Aviator";
	NPC9 addWeapon "arifle_Katiba_C_F";
	NPC9 addPrimaryWeaponItem "optic_ACO_grn";
	NPC9 addWeapon "hgun_Pistol_heavy_01_F";
	NPC9 addHandgunItem "muzzle_snds_acp";
	NPC9 addHandgunItem "optic_MRD";
	NPC9 addWeapon "Binocular";
	NPC9 linkItem "ItemRadio";
};