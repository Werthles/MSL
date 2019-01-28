//PMSetup.sqf
//Runs on all machines
//Called from init.sqf
//Sets up all global variables used for PM and calls unit setup

//pvs
private ["_script", "_i", "_typeLocations", "_j", "_nextMission", "_type", "_level", "_location", "_dist", "_count"];

//b merc,b fia,b
//nato,synd,b merc
//csat,nato,synd
//csat,r fia,r fia
//csat,nato,b fia
//nato,b merc,r syd
//csat,r merc,synd
//csat,nato,synd
//csat,b merc,b mer
//tv CSAT

//Unit Global Variables
_script = execVM "UnitSetup.sqf";

//job number of job which needs all previous jobs completed first
NPCCriticalJobs = [
	[4,7,9],
	[4,7,10],
	[4,7,10],
	[4,7,10],
	[4,7,10],
	[4,7,10],
	[4,7,10],
	[4,7,10],
	[4,7,10],
	[4,7,10]
];

//wait until last unit of unitSetup.sqf is initialised
waitUntil{not(isNil "C2_CrateSupport")};

//money for job leader on completing a cash job
PMCashArray = [1000,500,250];
//gun rewards: (array select type select level select isLeader) = array of items looted
PMLootArray = [
	[//0
		[["arifle_MX_khk_F"],["arifle_MX_khk_F"]],
		
		[["arifle_MXM_khk_F"],["arifle_MXM_khk_F"]],
		
		[["arifle_MXC_khk_F"],["arifle_MXC_khk_F"]]
	],
	
	[//1
		[["LMG_Zafir_F","arifle_CTARS_blk_F","arifle_CTARS_ghex_F","arifle_CTARS_hex_F","LMG_Mk200_F","MMG_01_hex_F","MMG_01_tan_F","arifle_SPAR_02_blk_F","arifle_SPAR_02_khk_F","arifle_SPAR_02_snd_F","MMG_02_black_F","MMG_02_camo_F","MMG_02_sand_F"],["LMG_Zafir_F","arifle_CTARS_blk_F","arifle_CTARS_ghex_F","arifle_CTARS_hex_F","LMG_Mk200_F","MMG_01_hex_F","MMG_01_tan_F","arifle_SPAR_02_blk_F","arifle_SPAR_02_khk_F","arifle_SPAR_02_snd_F","MMG_02_black_F","MMG_02_camo_F","MMG_02_sand_F"]],
		
		[["arifle_AK12_F","arifle_AK12_GL_F","arifle_AKM_F","arifle_AKS_F","arifle_CTAR_blk_F","arifle_CTAR_ghex_F","","arifle_CTAR_hex_F","arifle_CTAR_GL_blk_F","arifle_CTAR_GL_ghex_F","arifle_CTAR_GL_hex_F","arifle_SPAR_01_GL_khk_F","arifle_MX_GL_khk_F"],["arifle_AK12_F","arifle_AK12_GL_F","arifle_AKM_F","arifle_AKS_F","arifle_CTAR_blk_F","arifle_CTAR_ghex_F","","arifle_CTAR_hex_F","arifle_CTAR_GL_blk_F","arifle_CTAR_GL_ghex_F","arifle_CTAR_GL_hex_F","arifle_SPAR_01_GL_khk_F","arifle_MX_GL_khk_F"]],
		
		[["hgun_P07_khk_F","hgun_P07_khk_F","hgun_P07_khk_F"],["hgun_P07_khk_F","hgun_P07_khk_F","hgun_P07_khk_F"]]
	],
	
	[//2
		[["srifle_GM6_ghex_F","srifle_GM6_camo_F","srifle_GM6_F","srifle_LRR_F","srifle_LRR_camo_F","srifle_LRR_tna_F","srifle_DMR_02_F","srifle_DMR_02_camo_F","srifle_DMR_02_sniper_F"],["srifle_GM6_ghex_F","srifle_GM6_camo_F","srifle_GM6_F","srifle_LRR_F","srifle_LRR_camo_F","srifle_LRR_tna_F","srifle_DMR_02_F","srifle_DMR_02_camo_F","srifle_DMR_02_sniper_F"]],
		
		[["srifle_DMR_05_blk_F","srifle_DMR_03_khaki_F","srifle_DMR_06_camo_F","srifle_EBR_F","srifle_DMR_01_F","arifle_SPAR_03_khk_F"],["srifle_DMR_05_blk_F","srifle_DMR_03_khaki_F","srifle_DMR_06_camo_F","srifle_EBR_F","srifle_DMR_01_F","arifle_SPAR_03_khk_F"]],
		
		[["SMG_01_F","SMG_02_F","SMG_05_F"],["SMG_01_F","SMG_02_F","SMG_05_F"]]
	],
	
	[//3
		[["launch_I_Titan_F","launch_O_Titan_ghex_F","launch_O_Titan_F","launch_B_Titan_F","launch_B_Titan_tna_F","launch_O_Titan_short_F","launch_O_Titan_short_ghex_F","launch_I_Titan_short_F","launch_B_Titan_short_F","launch_B_Titan_short_tna_F"],["launch_I_Titan_F","launch_O_Titan_ghex_F","launch_O_Titan_F","launch_B_Titan_F","launch_B_Titan_tna_F","launch_O_Titan_short_F","launch_O_Titan_short_ghex_F","launch_I_Titan_short_F","launch_B_Titan_short_F","launch_B_Titan_short_tna_F"]],
		
		[["launch_NLAW_F","launch_NLAW_F","launch_NLAW_F","launch_NLAW_F","launch_NLAW_F","launch_NLAW_F"],["launch_NLAW_F","launch_NLAW_F","launch_NLAW_F","launch_NLAW_F","launch_NLAW_F","launch_NLAW_F"]],
		
		[["launch_RPG32_F","launch_RPG32_ghex_F","launch_RPG7_F"],["launch_RPG32_F","launch_RPG32_ghex_F","launch_RPG7_F"]]
	],
	
	[//4
		[["launch_RPG7_F","launch_RPG7_F","launch_RPG7_F"],["launch_RPG7_F","launch_RPG7_F","launch_RPG7_F"]],
		
		[["launch_RPG7_F","launch_RPG7_F","launch_RPG7_F"],["launch_RPG7_F","launch_RPG7_F","launch_RPG7_F"]],
		
		[["launch_RPG7_F","launch_RPG7_F","launch_RPG7_F"],["launch_RPG7_F","launch_RPG7_F","launch_RPG7_F"]]
	],
	
	[//5
		[["arifle_ARX_blk_F","arifle_ARX_ghex_F","arifle_ARX_hex_F"],["arifle_ARX_blk_F","arifle_ARX_ghex_F","arifle_ARX_hex_F"]],
		
		[["arifle_ARX_blk_F","arifle_ARX_ghex_F","arifle_ARX_hex_F"],["arifle_ARX_blk_F","arifle_ARX_ghex_F","arifle_ARX_hex_F"]],
		
		[["arifle_ARX_blk_F","arifle_ARX_ghex_F","arifle_ARX_hex_F"],["arifle_ARX_blk_F","arifle_ARX_ghex_F","arifle_ARX_hex_F"]]
	],
	
	[//6
		[["arifle_MX_GL_khk_F","arifle_MX_GL_khk_F","arifle_MX_GL_khk_F"],["arifle_MX_GL_khk_F","arifle_MX_GL_khk_F","arifle_MX_GL_khk_F"]],
		
		[["arifle_MX_GL_khk_F","arifle_MX_GL_khk_F","arifle_MX_GL_khk_F"],["arifle_MX_GL_khk_F","arifle_MX_GL_khk_F","arifle_MX_GL_khk_F"]],
		
		[["arifle_MX_GL_khk_F","arifle_MX_GL_khk_F","arifle_MX_GL_khk_F"],["arifle_MX_GL_khk_F","arifle_MX_GL_khk_F","arifle_MX_GL_khk_F"]]
	],
	
	[//7
		[["arifle_MX_SW_khk_F","arifle_MX_SW_khk_F","arifle_MX_SW_khk_F"],["arifle_MX_SW_khk_F","arifle_MX_SW_khk_F","arifle_MX_SW_khk_F"]],
		
		[["arifle_MX_SW_khk_F","arifle_MX_SW_khk_F","arifle_MX_SW_khk_F"],["arifle_MX_SW_khk_F","arifle_MX_SW_khk_F","arifle_MX_SW_khk_F"]],
		
		[["arifle_MX_SW_khk_F","arifle_MX_SW_khk_F","arifle_MX_SW_khk_F"],["arifle_MX_SW_khk_F","arifle_MX_SW_khk_F","arifle_MX_SW_khk_F"]]
	],
	
	[//8
		[["arifle_MXM_khk_F","arifle_MXM_khk_F","arifle_MXM_khk_F"],["arifle_MXM_khk_F","arifle_MXM_khk_F","arifle_MXM_khk_F"]],
		
		[["arifle_MXM_khk_F","arifle_MXM_khk_F","arifle_MXM_khk_F"],["arifle_MXM_khk_F","arifle_MXM_khk_F","arifle_MXM_khk_F"]],
		
		[["arifle_MXM_khk_F","arifle_MXM_khk_F","arifle_MXM_khk_F"],["arifle_MXM_khk_F","arifle_MXM_khk_F","arifle_MXM_khk_F"]]
	],
	
	[//9
		[["srifle_LRR_tna_F"],["srifle_LRR_tna_F"]]
	]
];
//ammo rewards: (array select type select level select isLeader) = array of items looted
PMLootArrayAmmo = [
	[//0
		[["30Rnd_65x39_caseless_mag_Tracer"],["30Rnd_65x39_caseless_mag_Tracer"]],
		[["30Rnd_65x39_caseless_mag"],["30Rnd_65x39_caseless_mag"]],
		[["30Rnd_65x39_caseless_mag"],["30Rnd_65x39_caseless_mag"]]
	],
	
	[//1
		[["150Rnd_762x54_Box_Tracer","100Rnd_580x42_Mag_Tracer_F","100Rnd_580x42_Mag_Tracer_F","100Rnd_580x42_Mag_Tracer_F","200Rnd_65x39_cased_Box_Tracer","150Rnd_93x64_Mag","150Rnd_93x64_Mag","150Rnd_556x45_Drum_Mag_Tracer_F","150Rnd_556x45_Drum_Mag_Tracer_F","150Rnd_556x45_Drum_Mag_Tracer_F","130Rnd_338_Mag","130Rnd_338_Mag","130Rnd_338_Mag"],["150Rnd_762x54_Box_Tracer","100Rnd_580x42_Mag_Tracer_F","100Rnd_580x42_Mag_Tracer_F","100Rnd_580x42_Mag_Tracer_F","200Rnd_65x39_cased_Box_Tracer","150Rnd_93x64_Mag","150Rnd_93x64_Mag","150Rnd_556x45_Drum_Mag_Tracer_F","150Rnd_556x45_Drum_Mag_Tracer_F","150Rnd_556x45_Drum_Mag_Tracer_F","130Rnd_338_Mag","130Rnd_338_Mag","130Rnd_338_Mag"]],
		
		[["30Rnd_762x39_Mag_Green_F","30Rnd_762x39_Mag_Green_F","30Rnd_762x39_Mag_Green_F","30Rnd_545x39_Mag_F","30Rnd_580x42_Mag_F","30Rnd_580x42_Mag_F","30Rnd_580x42_Mag_F","30Rnd_580x42_Mag_F","30Rnd_580x42_Mag_F","30Rnd_580x42_Mag_F","30Rnd_556x45_Stanag","30Rnd_65x39_caseless_mag"],["30Rnd_762x39_Mag_Green_F","30Rnd_762x39_Mag_Green_F","30Rnd_762x39_Mag_Green_F","30Rnd_545x39_Mag_F","30Rnd_580x42_Mag_F","30Rnd_580x42_Mag_F","30Rnd_580x42_Mag_F","30Rnd_580x42_Mag_F","30Rnd_580x42_Mag_F","30Rnd_580x42_Mag_F","30Rnd_556x45_Stanag","30Rnd_65x39_caseless_mag"]],
		
		[["30Rnd_9x21_Green_Mag","30Rnd_9x21_Green_Mag","30Rnd_9x21_Green_Mag"],["30Rnd_9x21_Green_Mag","30Rnd_9x21_Green_Mag","30Rnd_9x21_Green_Mag"]]
	],
	
	[//2
		[["5Rnd_127x108_APDS_Mag","5Rnd_127x108_APDS_Mag","5Rnd_127x108_Mag","7Rnd_408_Mag","7Rnd_408_Mag","7Rnd_408_Mag","10Rnd_338_Mag","10Rnd_338_Mag","10Rnd_338_Mag"],["5Rnd_127x108_APDS_Mag","5Rnd_127x108_APDS_Mag","5Rnd_127x108_Mag","7Rnd_408_Mag","7Rnd_408_Mag","7Rnd_408_Mag","10Rnd_338_Mag","10Rnd_338_Mag","10Rnd_338_Mag"]],
		
		[["10Rnd_93x64_DMR_05_Mag","20Rnd_762x51_Mag","20Rnd_762x51_Mag","20Rnd_762x51_Mag","10Rnd_762x54_Mag","20Rnd_762x51_Mag"],["10Rnd_93x64_DMR_05_Mag","20Rnd_762x51_Mag","20Rnd_762x51_Mag","20Rnd_762x51_Mag","10Rnd_762x54_Mag","20Rnd_762x51_Mag"]],
		
		[["30Rnd_45ACP_Mag_SMG_01","30Rnd_9x21_Mag_SMG_02","30Rnd_9x21_Mag_SMG_02"],["30Rnd_45ACP_Mag_SMG_01","30Rnd_9x21_Mag_SMG_02","30Rnd_9x21_Mag_SMG_02"]]
	],
	
	[//3
		[["Titan_AA","Titan_AA","Titan_AA","Titan_AA","Titan_AA","Titan_AT","Titan_AT","Titan_AT","Titan_AT","Titan_AT"],["Titan_AA","Titan_AA","Titan_AA","Titan_AA","Titan_AA","Titan_AT","Titan_AT","Titan_AT","Titan_AT","Titan_AT"]],
		
		[["NLAW_F","NLAW_F","NLAW_F","NLAW_F","NLAW_F","NLAW_F"],["NLAW_F","NLAW_F","NLAW_F","NLAW_F","NLAW_F","NLAW_F"]],
		
		[["RPG32_F","RPG32_F","RPG7_F"],["RPG32_F","RPG32_F","RPG7_F"]]
	],
	
	[//4
		[["RPG32_F","RPG32_F","RPG7_F"],["RPG32_F"]],
		
		[["RPG32_F","RPG32_F"],["RPG32_F"]],
		
		[["RPG32_F"],["RPG32_F"]]
	],
	
	[//5
		[["30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green"],["30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green"]],
		
		[["30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green"],["30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green"]],
		
		[["30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green"],["30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green"]]
	],
	
	[//6
		[["3Rnd_HE_Grenade_shell","1Rnd_HE_Grenade_shell","30Rnd_65x39_caseless_mag"],["3Rnd_HE_Grenade_shell","1Rnd_HE_Grenade_shell","30Rnd_65x39_caseless_mag"]],
		
		[["3Rnd_HE_Grenade_shell","1Rnd_HE_Grenade_shell","30Rnd_65x39_caseless_mag"],["3Rnd_HE_Grenade_shell","1Rnd_HE_Grenade_shell","30Rnd_65x39_caseless_mag"]],
		
		[["3Rnd_HE_Grenade_shell","1Rnd_HE_Grenade_shell","30Rnd_65x39_caseless_mag"],["3Rnd_HE_Grenade_shell","1Rnd_HE_Grenade_shell","30Rnd_65x39_caseless_mag"]]
	],
	
	[//7
		
		[["100Rnd_65x39_caseless_mag_Tracer","100Rnd_65x39_caseless_mag","100Rnd_65x39_caseless_mag_Tracer"],["100Rnd_65x39_caseless_mag_Tracer","100Rnd_65x39_caseless_mag","100Rnd_65x39_caseless_mag_Tracer"]],
		
		[["100Rnd_65x39_caseless_mag_Tracer","100Rnd_65x39_caseless_mag","100Rnd_65x39_caseless_mag_Tracer"],["100Rnd_65x39_caseless_mag_Tracer","100Rnd_65x39_caseless_mag","100Rnd_65x39_caseless_mag_Tracer"]],
		
		[["100Rnd_65x39_caseless_mag_Tracer","100Rnd_65x39_caseless_mag","100Rnd_65x39_caseless_mag_Tracer"],["100Rnd_65x39_caseless_mag_Tracer","100Rnd_65x39_caseless_mag","100Rnd_65x39_caseless_mag_Tracer"]]
	],
	
	[//8
		[["30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag"],["30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag"]],
		
		[["30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag"],["30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag"]],
		
		[["30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag"],["30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag"]]
	],
	
	[//9
		[["7Rnd_408_Mag"],["7Rnd_408_Mag"]]
	]
];
//gun item rewards: (array select type select level select isLeader) = array of items looted
PMLootArrayItem = [
	[//0
		[["G_Aviator","optic_ERCO_khk_F"],["optic_ERCO_khk_F"]],
		
		[["G_Aviator","optic_ERCO_khk_F"],["optic_ERCO_khk_F"]],
		
		[["G_Aviator","optic_ERCO_khk_F"],
		["optic_ERCO_khk_F"]]
	],
	
	[//1
		[["bipod_03_F_blk","bipod_02_F_blk","bipod_01_F_blk","bipod_02_F_hex","bipod_01_F_khk","bipod_01_F_mtp","bipod_03_F_oli","bipod_01_F_snd","bipod_02_F_tan","muzzle_snds_338_black","muzzle_snds_338_green","muzzle_snds_338_sand","muzzle_snds_338_black","muzzle_snds_338_green","muzzle_snds_338_sand","muzzle_snds_338_black","muzzle_snds_338_green","muzzle_snds_338_sand","acc_flashlight","acc_pointer_IR","acc_flashlight","acc_pointer_IR","acc_flashlight","acc_pointer_IR","acc_flashlight","acc_pointer_IR","acc_flashlight","acc_pointer_IR","optic_ERCO_blk_F","optic_ERCO_khk_F","optic_ERCO_snd_F","optic_ERCO_blk_F","optic_ERCO_khk_F","optic_ERCO_snd_F","optic_ERCO_blk_F","optic_ERCO_khk_F","optic_ERCO_snd_F"],["bipod_01_F_khk","muzzle_snds_338_green","acc_flashlight","acc_pointer_IR","optic_ERCO_khk_F"]],
		
		[["1Rnd_SmokeOrange_Grenade_shell","1Rnd_SmokeBlue_Grenade_shell","1Rnd_SmokePurple_Grenade_shell","1Rnd_SmokeYellow_Grenade_shell","1Rnd_SmokeGreen_Grenade_shell","1Rnd_SmokeRed_Grenade_shell","1Rnd_Smoke_Grenade_shell","UGL_FlareCIR_F","UGL_FlareYellow_F","UGL_FlareRed_F","UGL_FlareGreen_F","UGL_FlareWhite_F","1Rnd_HE_Grenade_shell","1Rnd_HE_Grenade_shell","30Rnd_762x39_Mag_Green_F","acc_flashlight","acc_pointer_IR","acc_flashlight","acc_pointer_IR","acc_flashlight","acc_pointer_IR","acc_flashlight","acc_pointer_IR","acc_flashlight","acc_pointer_IR","optic_ERCO_blk_F","optic_ERCO_khk_F","optic_ERCO_snd_F","optic_ERCO_blk_F","optic_ERCO_khk_F","optic_ERCO_snd_F","optic_ERCO_blk_F","optic_ERCO_khk_F","optic_ERCO_snd_F"],["1Rnd_SmokeOrange_Grenade_shell","1Rnd_SmokeBlue_Grenade_shell","1Rnd_SmokePurple_Grenade_shell","1Rnd_SmokeYellow_Grenade_shell","1Rnd_SmokeGreen_Grenade_shell","1Rnd_SmokeRed_Grenade_shell","1Rnd_Smoke_Grenade_shell","UGL_FlareCIR_F","UGL_FlareYellow_F","UGL_FlareRed_F","UGL_FlareGreen_F","UGL_FlareWhite_F","1Rnd_HE_Grenade_shell","1Rnd_HE_Grenade_shell","30Rnd_762x39_Mag_Green_F","acc_flashlight","acc_pointer_IR","optic_ERCO_khk_F"]],
		
		[["muzzle_snds_L","muzzle_snds_L","muzzle_snds_L"],["muzzle_snds_L","muzzle_snds_L","muzzle_snds_L"]]
	],
	
	[//2
		[["optic_DMS_ghex_F","optic_LRPS_ghex_F","optic_AMS_khk","optic_SOS_khk_F","optic_KHS_hex","optic_Nightstalker","optic_tws","optic_NVS","optic_SOS","optic_LRPS_ghex_F","optic_LRPS","optic_KHS_tan","optic_KHS_old","optic_KHS_blk","optic_DMS","optic_AMS_snd","optic_AMS","bipod_03_F_blk","bipod_02_F_blk","bipod_01_F_blk","bipod_02_F_hex","bipod_01_F_khk","bipod_01_F_mtp","bipod_03_F_oli","bipod_01_F_snd","bipod_02_F_tan","muzzle_snds_338_black","muzzle_snds_338_green","muzzle_snds_338_sand","acc_flashlight","acc_pointer_IR","acc_flashlight","optic_ERCO_blk_F","optic_ERCO_khk_F","optic_ERCO_snd_F"],["optic_DMS_ghex_F","optic_LRPS_ghex_F","optic_AMS_khk","optic_SOS_khk_F","optic_KHS_hex","optic_Nightstalker","optic_tws","optic_NVS","optic_SOS","optic_LRPS_ghex_F","optic_LRPS","optic_KHS_tan","optic_KHS_old","optic_KHS_blk","optic_DMS","optic_AMS_snd","optic_AMS"]],
		
		[["optic_DMS_ghex_F","optic_LRPS_ghex_F","optic_AMS_khk","optic_SOS_khk_F","optic_KHS_hex","optic_Nightstalker","optic_tws","optic_NVS","optic_SOS","optic_LRPS_ghex_F","optic_LRPS","optic_KHS_tan","optic_KHS_old","optic_KHS_blk","optic_DMS","optic_AMS_snd","optic_AMS","bipod_03_F_blk","bipod_02_F_blk","bipod_01_F_blk","bipod_02_F_hex","bipod_01_F_khk","bipod_01_F_mtp","bipod_03_F_oli","bipod_01_F_snd","bipod_02_F_tan","muzzle_snds_338_black","muzzle_snds_338_green","muzzle_snds_338_sand","acc_flashlight","acc_pointer_IR","acc_flashlight","optic_ERCO_blk_F","optic_ERCO_khk_F","optic_ERCO_snd_F"],["optic_DMS_ghex_F","optic_LRPS_ghex_F","optic_AMS_khk","optic_SOS_khk_F","optic_KHS_hex","optic_Nightstalker","optic_tws","optic_NVS","optic_SOS","optic_LRPS_ghex_F","optic_LRPS","optic_KHS_tan","optic_KHS_old","optic_KHS_blk","optic_DMS","optic_AMS_snd","optic_AMS","bipod_03_F_blk","bipod_02_F_blk","bipod_01_F_blk","bipod_02_F_hex","bipod_01_F_khk","bipod_01_F_mtp","bipod_03_F_oli","bipod_01_F_snd","bipod_02_F_tan","muzzle_snds_338_black","muzzle_snds_338_green","muzzle_snds_338_sand","acc_flashlight","acc_pointer_IR","acc_flashlight","optic_ERCO_blk_F","optic_ERCO_khk_F","optic_ERCO_snd_F"]],
		
		[["optic_Holosight_khk_F","optic_Holosight_smg_blk_F","optic_Holosight_smg"],["optic_Holosight_khk_F","optic_Holosight_smg_blk_F","optic_Holosight_smg"]]
	],
	
	[//3
		[["HandGrenade","HandGrenade","HandGrenade"],["HandGrenade","HandGrenade","HandGrenade"]],
		
		[["HandGrenade","HandGrenade","HandGrenade"],["HandGrenade","HandGrenade","HandGrenade"]],
		
		[["HandGrenade","HandGrenade","HandGrenade"],["HandGrenade","HandGrenade","HandGrenade"]]
	],
	
	[//4
		[["SatchelCharge_Remote_Mag","IEDLandBig_Remote_Mag","IEDUrbanBig_Remote_Mag"],["SatchelCharge_Remote_Mag","IEDLandBig_Remote_Mag","IEDUrbanBig_Remote_Mag"]],
		
		[["APERSTripMine_Wire_Mag","ATMine_Range_Mag","DemoCharge_Remote_Mag","IEDLandBig_Remote_Mag","IEDUrbanBig_Remote_Mag","SLAMDirectionalMine_Wire_Mag","IEDLandSmall_Remote_Mag","IEDUrbanSmall_Remote_Mag","ClaymoreDirectionalMine_Remote_Mag","APERSTripMine_Wire_Mag","ATMine_Range_Mag","DemoCharge_Remote_Mag","IEDLandBig_Remote_Mag","IEDUrbanBig_Remote_Mag","SLAMDirectionalMine_Wire_Mag","IEDLandSmall_Remote_Mag","IEDUrbanSmall_Remote_Mag","ClaymoreDirectionalMine_Remote_Mag","APERSTripMine_Wire_Mag","ATMine_Range_Mag","DemoCharge_Remote_Mag","IEDLandBig_Remote_Mag","IEDUrbanBig_Remote_Mag","SLAMDirectionalMine_Wire_Mag","IEDLandSmall_Remote_Mag","IEDUrbanSmall_Remote_Mag","ClaymoreDirectionalMine_Remote_Mag"],["APERSTripMine_Wire_Mag","ATMine_Range_Mag","DemoCharge_Remote_Mag","IEDLandBig_Remote_Mag","IEDUrbanBig_Remote_Mag","SLAMDirectionalMine_Wire_Mag","IEDLandSmall_Remote_Mag","IEDUrbanSmall_Remote_Mag","ClaymoreDirectionalMine_Remote_Mag"]],
		
		[["DemoCharge_Remote_Mag","SatchelCharge_Remote_Mag","DemoCharge_Remote_Mag","SatchelCharge_Remote_Mag","DemoCharge_Remote_Mag","SatchelCharge_Remote_Mag"],["DemoCharge_Remote_Mag","SatchelCharge_Remote_Mag"]]
	],
	
	[//5
		[["10Rnd_50BW_Mag_F","10Rnd_50BW_Mag_F","10Rnd_50BW_Mag_F","10Rnd_50BW_Mag_F","10Rnd_50BW_Mag_F","10Rnd_50BW_Mag_F","10Rnd_50BW_Mag_F","10Rnd_50BW_Mag_F","10Rnd_50BW_Mag_F","U_I_GhillieSuit","U_I_FullGhillie_lsh","U_I_FullGhillie_sard","U_I_FullGhillie_ard","U_I_GhillieSuit","U_I_FullGhillie_lsh","U_I_FullGhillie_sard","U_I_FullGhillie_ard"],["10Rnd_50BW_Mag_F","10Rnd_50BW_Mag_F","10Rnd_50BW_Mag_F"]],
		[["10Rnd_50BW_Mag_F","10Rnd_50BW_Mag_F","10Rnd_50BW_Mag_F","10Rnd_50BW_Mag_F","10Rnd_50BW_Mag_F","10Rnd_50BW_Mag_F","10Rnd_50BW_Mag_F","10Rnd_50BW_Mag_F","10Rnd_50BW_Mag_F","O_NVGoggles_ghex_F","O_NVGoggles_hex_F","O_NVGoggles_urb_F","NVGogglesB_blk_F","NVGogglesB_grn_F","NVGogglesB_gry_F","NVGoggles_OPFOR","NVGoggles","NVGoggles_INDEP","NVGoggles_tna_F","Laserdesignator_02_ghex_F","Laserdesignator_02","Laserdesignator_01_khk_F","Laserdesignator_03","Laserdesignator","Rangefinder","Laserbatteries","Laserbatteries","Laserbatteries","Laserbatteries","Laserbatteries","Laserbatteries","Laserbatteries","Laserbatteries","I_IR_Grenade","I_IR_Grenade","I_IR_Grenade","I_IR_Grenade","Chemlight_yellow","Chemlight_red","Chemlight_green","Chemlight_blue","H_HelmetO_ViperSP_ghex_F","H_HelmetO_ViperSP_hex_F"],["O_NVGoggles_ghex_F","O_NVGoggles_hex_F","O_NVGoggles_urb_F","NVGogglesB_blk_F","NVGogglesB_grn_F","NVGogglesB_gry_F","NVGoggles_OPFOR","NVGoggles","NVGoggles_INDEP","NVGoggles_tna_F","H_HelmetO_ViperSP_ghex_F","H_HelmetO_ViperSP_hex_F"]],
		
		[["U_I_Wetsuit","U_I_Wetsuit","U_I_Wetsuit","H_HelmetSpecO_ghex_F","H_Beret_gen_F","H_Booniehat_tna_F","H_HelmetB_tna_F","H_HelmetCrew_O_ghex_F","H_HelmetLeaderO_ghex_F","H_HelmetB_Enh_tna_F","H_HelmetB_Light_tna_F","H_MilCap_gen_F","H_MilCap_ghex_F","H_MilCap_tna_F","H_HelmetO_ghex_F","H_Helmet_Skate","H_HelmetB_TI_tna_F","H_Bandanna_khk","H_Beret_blk","10Rnd_50BW_Mag_F","10Rnd_50BW_Mag_F","10Rnd_50BW_Mag_F","10Rnd_50BW_Mag_F","10Rnd_50BW_Mag_F","10Rnd_50BW_Mag_F","10Rnd_50BW_Mag_F","10Rnd_50BW_Mag_F","10Rnd_50BW_Mag_F"],["10Rnd_50BW_Mag_F","10Rnd_50BW_Mag_F","10Rnd_50BW_Mag_F"]]
	],
	
	[
		[["Item_optic_ACO_grn","Item_optic_ACO_grn","Item_optic_ACO_grn"],["Item_optic_ACO_grn","Item_optic_ACO_grn","Item_optic_ACO_grn"]],
		
		[["Item_optic_ACO_grn","Item_optic_ACO_grn","Item_optic_ACO_grn"],["Item_optic_ACO_grn","Item_optic_ACO_grn","Item_optic_ACO_grn"]],
		
		[["Item_optic_ACO_grn","Item_optic_ACO_grn","Item_optic_ACO_grn"],["Item_optic_ACO_grn","Item_optic_ACO_grn","Item_optic_ACO_grn"]]
	],
	
	[
		[["Item_optic_ACO_grn","Item_optic_ACO_grn","Item_optic_ACO_grn"],["Item_optic_ACO_grn","Item_optic_ACO_grn","Item_optic_ACO_grn"]],
		
		[["Item_optic_ACO_grn","Item_optic_ACO_grn","Item_optic_ACO_grn"],["Item_optic_ACO_grn","Item_optic_ACO_grn","Item_optic_ACO_grn"]],
		
		[["Item_optic_ACO_grn","Item_optic_ACO_grn","Item_optic_ACO_grn"],["Item_optic_ACO_grn","Item_optic_ACO_grn","Item_optic_ACO_grn"]]
	],
	
	[
		[["Item_optic_ACO_grn","Item_optic_ACO_grn","Item_optic_ACO_grn"],["Item_optic_ACO_grn","Item_optic_ACO_grn","Item_optic_ACO_grn"]],
		
		[["Item_optic_ACO_grn","Item_optic_ACO_grn","Item_optic_ACO_grn"],["Item_optic_ACO_grn","Item_optic_ACO_grn","Item_optic_ACO_grn"]],
		
		[["Item_optic_ACO_grn","Item_optic_ACO_grn","Item_optic_ACO_grn"],["Item_optic_ACO_grn","Item_optic_ACO_grn","Item_optic_ACO_grn"]]
	],
	
	[
		[["H_HelmetO_ViperSP_ghex_F"],["H_HelmetO_ViperSP_ghex_F"]]
	]
];
//backpack rewards: (array select type select level select isLeader) = array of items looted
PMLootArrayBackpack = [
	[//0
		[["B_AssaultPack_blk"],["B_AssaultPack_blk"]],
		
		[["B_AssaultPack_tna_F"],["B_AssaultPack_tna_F"]],
		
		[["B_AssaultPack_sgg"],["B_AssaultPack_sgg"]]
	],
	
	[//1
		[["B_AssaultPack_mcamo"],["B_AssaultPack_mcamo"]],
		
		[["B_AssaultPack_khk"],["B_AssaultPack_khk"]],
		
		[["B_AssaultPack_ocamo"],["B_AssaultPack_ocamo"]]
	],
	
	[//2
		[["B_AssaultPack_rgr"],["B_AssaultPack_rgr"]],
		
		[["B_AssaultPack_dgtl"],["B_AssaultPack_dgtl"]],
		
		[["B_AssaultPack_cbr"],["B_AssaultPack_cbr"]]
	],
	
	[//3
		[["I_AT_01_weapon_F","I_AA_01_weapon_F","I_HMG_01_support_F","I_HMG_01_support_F"],["I_AT_01_weapon_F","I_AA_01_weapon_F","I_HMG_01_support_F","I_HMG_01_support_F"]],
		
		[["B_Bergen_hex_F"],["B_Bergen_hex_F"]],
		
		[["B_Bergen_dgtl_F"],["B_Bergen_dgtl_F"]]
	],
	
	[//4
		[["I_Mortar_01_weapon_F","I_Mortar_01_support_F","I_Mortar_01_weapon_F","I_Mortar_01_support_F","I_Mortar_01_weapon_F","I_Mortar_01_support_F","I_Mortar_01_weapon_F","I_Mortar_01_support_F","I_Mortar_01_weapon_F","I_Mortar_01_support_F"],["I_Mortar_01_weapon_F","I_Mortar_01_support_F"]],
		
		[["B_Bergen_mcamo_F"],["B_Bergen_mcamo_F"]],
		
		[["B_Bergen_tna_F"],["B_Bergen_tna_F"]]
	],
	
	[//5
		[["B_ViperLightHarness_blk_F","B_ViperLightHarness_ghex_F","B_ViperLightHarness_blk_F","B_ViperLightHarness_ghex_F","B_ViperLightHarness_blk_F","B_ViperLightHarness_ghex_F","B_ViperLightHarness_blk_F","B_ViperLightHarness_ghex_F","B_ViperLightHarness_blk_F","B_ViperLightHarness_ghex_F","I_UAV_01_backpack_F","B_Static_Designator_01_weapon_F","B_Parachute","I_UAV_01_backpack_F","B_Static_Designator_01_weapon_F","B_Parachute","I_UAV_01_backpack_F","B_Static_Designator_01_weapon_F","B_Parachute","I_UAV_01_backpack_F","B_Static_Designator_01_weapon_F","B_Parachute","I_UAV_01_backpack_F","B_Static_Designator_01_weapon_F"],["B_ViperLightHarness_blk_F","B_ViperLightHarness_ghex_F"]],
		
		[["B_ViperLightHarness_hex_F","B_ViperLightHarness_khk_F","B_ViperLightHarness_oli_F"],["B_ViperLightHarness_hex_F","B_ViperLightHarness_khk_F","B_ViperLightHarness_oli_F"]],
		
		[["B_ViperHarness_blk_F","B_ViperHarness_ghex_F","B_ViperHarness_hex_F"],["B_ViperHarness_khk_F","B_ViperHarness_oli_F"]]
	],
	
	[//6
		[["B_Carryall_ghex_F"],["B_Carryall_ghex_F"]],
		
		[["B_Carryall_ghex_F"],["B_Carryall_ghex_F"]],
		
		[["B_Carryall_ghex_F"],["B_Carryall_ghex_F"]]
	],
	
	[//7
		[["B_FieldPack_ghex_F"],["B_FieldPack_ghex_F"]],
		
		[["B_FieldPack_ghex_F"],["B_FieldPack_ghex_F"]],
		
		[["B_FieldPack_ghex_F"],["B_FieldPack_ghex_F"]]
	],
	
	[//8
		[["B_FieldPack_ghex_F"],["B_FieldPack_ghex_F"]],
		
		[["B_FieldPack_ghex_F"],["B_FieldPack_ghex_F"]],
		
		[["B_FieldPack_ghex_F"],["B_FieldPack_ghex_F"]]
	],
	
	[//9
		[["B_ViperHarness_blk_F"],["B_ViperHarness_blk_F"]]
	]
];
//car rewards: (array select type select level select isLeader) = array of items looted
PMLootArrayVehicle = [
	[[["I_G_Quadbike_01_F","I_G_Quadbike_01_F","I_G_Quadbike_01_F"],["I_G_Quadbike_01_F","I_G_Quadbike_01_F","I_G_Quadbike_01_F"]],[["I_G_Quadbike_01_F","I_G_Quadbike_01_F","I_G_Quadbike_01_F"],["I_G_Quadbike_01_F","I_G_Quadbike_01_F","I_G_Quadbike_01_F"]],[["I_G_Quadbike_01_F","I_G_Quadbike_01_F","I_G_Quadbike_01_F"],["I_G_Quadbike_01_F","I_G_Quadbike_01_F","I_G_Quadbike_01_F"]]],
	
	[[["I_G_Quadbike_01_F","I_G_Quadbike_01_F","I_G_Quadbike_01_F"],["I_G_Quadbike_01_F","I_G_Quadbike_01_F","I_G_Quadbike_01_F"]],[["I_G_Quadbike_01_F","I_G_Quadbike_01_F","I_G_Quadbike_01_F"],["I_G_Quadbike_01_F","I_G_Quadbike_01_F","I_G_Quadbike_01_F"]],[["I_G_Quadbike_01_F","I_G_Quadbike_01_F","I_G_Quadbike_01_F"],["I_G_Quadbike_01_F","I_G_Quadbike_01_F","I_G_Quadbike_01_F"]]],
	
	[[["I_G_Quadbike_01_F","I_G_Quadbike_01_F","I_G_Quadbike_01_F"],["I_G_Quadbike_01_F","I_G_Quadbike_01_F","I_G_Quadbike_01_F"]],[["I_G_Quadbike_01_F","I_G_Quadbike_01_F","I_G_Quadbike_01_F"],["I_G_Quadbike_01_F","I_G_Quadbike_01_F","I_G_Quadbike_01_F"]],[["I_G_Quadbike_01_F","I_G_Quadbike_01_F","I_G_Quadbike_01_F"],["I_G_Quadbike_01_F","I_G_Quadbike_01_F","I_G_Quadbike_01_F"]]],
	
	[[["I_G_Quadbike_01_F","I_G_Quadbike_01_F","I_G_Quadbike_01_F"],["I_G_Quadbike_01_F","I_G_Quadbike_01_F","I_G_Quadbike_01_F"]],[["I_G_Quadbike_01_F","I_G_Quadbike_01_F","I_G_Quadbike_01_F"],["I_G_Quadbike_01_F","I_G_Quadbike_01_F","I_G_Quadbike_01_F"]],[["I_G_Quadbike_01_F","I_G_Quadbike_01_F","I_G_Quadbike_01_F"],["I_G_Quadbike_01_F","I_G_Quadbike_01_F","I_G_Quadbike_01_F"]]],
	
	[[["I_G_Quadbike_01_F","I_G_Quadbike_01_F","I_G_Quadbike_01_F"],["I_G_Quadbike_01_F","I_G_Quadbike_01_F","I_G_Quadbike_01_F"]],[["I_G_Quadbike_01_F","I_G_Quadbike_01_F","I_G_Quadbike_01_F"],["I_G_Quadbike_01_F","I_G_Quadbike_01_F","I_G_Quadbike_01_F"]],[["I_G_Quadbike_01_F","I_G_Quadbike_01_F","I_G_Quadbike_01_F"],["I_G_Quadbike_01_F","I_G_Quadbike_01_F","I_G_Quadbike_01_F"]]],
	
	[[["I_G_Quadbike_01_F","I_G_Quadbike_01_F","I_G_Quadbike_01_F"],["I_G_Quadbike_01_F","I_G_Quadbike_01_F","I_G_Quadbike_01_F"]],[["I_G_Quadbike_01_F","I_G_Quadbike_01_F","I_G_Quadbike_01_F"],["I_G_Quadbike_01_F","I_G_Quadbike_01_F","I_G_Quadbike_01_F"]],[["I_G_Quadbike_01_F","I_G_Quadbike_01_F","I_G_Quadbike_01_F"],["I_G_Quadbike_01_F","I_G_Quadbike_01_F","I_G_Quadbike_01_F"]]],
	
	[[["I_MRAP_03_hmg_F","O_MRAP_02_hmg_F","O_MRAP_02_hmg_F"],["I_MRAP_03_hmg_F","O_MRAP_02_hmg_F","O_MRAP_02_hmg_F"]],[["I_G_Offroad_01_armed_F","B_CTRG_LSV_01_light_F","O_T_LSV_02_armed_F"],["I_G_Offroad_01_armed_F","B_CTRG_LSV_01_light_F","O_T_LSV_02_armed_F"]],[["C_Hatchback_01_sport_F","B_T_LSV_01_unarmed_F","O_T_LSV_02_unarmed_F"],["C_Hatchback_01_sport_F","B_T_LSV_01_unarmed_F","O_T_LSV_02_unarmed_F"]]],
	
	[[["O_Boat_Armed_01_hmg_F","O_T_Boat_Armed_01_hmg_F","B_T_Boat_Armed_01_minigun_F"],["O_Boat_Armed_01_hmg_F","O_T_Boat_Armed_01_hmg_F","B_T_Boat_Armed_01_minigun_F"]],[["I_C_Boat_Transport_02_F","I_SDV_01_F","C_Boat_Civil_01_F"],["I_C_Boat_Transport_02_F","I_SDV_01_F","C_Boat_Civil_01_F"]],[["O_Lifeboat","I_G_Boat_Transport_01_F","C_Scooter_Transport_01_F"],["O_Lifeboat","I_G_Boat_Transport_01_F","C_Scooter_Transport_01_F"]]],
	
	[[["O_Heli_Attack_02_F","O_Heli_Light_02_F","B_Heli_Light_01_armed_F"],["O_Heli_Attack_02_F","O_Heli_Light_02_F","B_Heli_Light_01_armed_F"]],[["O_T_VTOL_02_infantry_F","O_T_VTOL_02_vehicle_F","B_T_VTOL_01_armed_F"],["O_T_VTOL_02_infantry_F","O_T_VTOL_02_vehicle_F","B_T_VTOL_01_armed_F"]],[["I_Heli_light_03_unarmed_F","O_Heli_Light_02_unarmed_F","B_Heli_Light_01_F"],["I_Heli_light_03_unarmed_F","O_Heli_Light_02_unarmed_F","B_Heli_Light_01_F"]]],
	
	[[["O_MBT_02_cannon_F"],["O_MRAP_02_hmg_F"]]]
];
//arrays of groups to call upon for PM enemies
PMUnitArrays = [
	[//mission type
		//mission level
		[[G1_SquadLead,G1_TeamLead,G1_Medic,G1_Rifleman,G1_Rifleman,G1_Rifleman,G1_Rifleman,G1_Rifleman],[G1_Officer,G1_SquadLead,G1_TeamLead,G1_AutoRifleman,G1_AA,G1_AT,G1_Medic,G1_Rifleman],[G1_ArmedCar2,G1_Grenadier,G1_Engineer,G1_Medic,G1_Rifleman,G1_Rifleman,G1_Rifleman,G1_Rifleman]],
		//mission level
		[[G1_SquadLead,G1_TeamLead,G1_Medic,G1_Rifleman,G1_Rifleman,G1_Rifleman,G1_Rifleman,G1_Rifleman],[G1_Officer,G1_SquadLead,G1_TeamLead,G1_AutoRifleman,G1_AA,G1_AT,G1_Medic,G1_Rifleman],[G1_ArmedCar2,G1_Grenadier,G1_Engineer,G1_Medic,G1_Rifleman,G1_Rifleman,G1_Rifleman,G1_Rifleman]],
		//mission level
		[[G1_SquadLead,G1_TeamLead,G1_Medic,G1_Rifleman,G1_Rifleman,G1_Rifleman,G1_Rifleman,G1_Rifleman],[G1_Officer,G1_SquadLead,G1_TeamLead,G1_AutoRifleman,G1_AA,G1_AT,G1_Medic,G1_Rifleman],[G1_ArmedCar2,G1_Grenadier,G1_Engineer,G1_Medic,G1_Rifleman,G1_Rifleman,G1_Rifleman,G1_Rifleman]]
	],
	[
		[[B1_OFFICER,B1_SLEAD,B1_TLEAD,B1_AUTO,B1_ASSAUTO,B1_ASSAUTO,B1_ASSAUTO,B1_ASSAUTO],[B1_VEH_LITE2,B1_SLEAD,B1_TLEAD,B1_AUTO,B1_MEDIC,B1_ENG,B1_GREN,B1_RIFLEMAN],[B1_OFFICER,B1_SLEAD,B1_TLEAD,B1_MEDIC,B1_GREN,B1_REPAIR,B1_RIFLEMAN,B1_EXPLOSIVE]],
		
		[[R3_OFFICER,R3_P_MEDIC,R3_P_UGL,R3_P_RIFLE1,R3_P_RIFLE2,R3_P_RIFLE3,R3_P_MG,R3_P_EXP],[R3_OFFICER,R3_P_MEDIC,R3_P_MISSILE,R3_P_RIFLE1,R3_P_RIFLE2,R3_P_RIFLE3,R3_P_MG,R3_P_EXP],[R3_OFFICER,R3_P_MEDIC,R3_P_UGL,R3_P_RIFLE1,R3_P_RIFLE2,R3_P_RIFLE3,R3_P_MG,R3_P_EXP]],
		
		[[G3_SquadLead,G3_TeamLead,G3_Lite,G3_Lite,G3_Lite,G3_Lite,G3_Lite,G3_Lite],[G3_SquadLead,G3_TeamLead,G3_Medic,G3_Grenadier,G3_Marksman,G3_AA,G3_AT,G3_Engineer],[G3_SquadLead,G3_TeamLead,G3_Rifleman,G3_Rifleman,G3_Rifleman,G3_Rifleman,G3_Rifleman,G3_Rifleman]]
	],
	[
		[[R1_OFFICER,R1_SLEAD,R1_TLEAD,R1_MEDIC,R1_RIFLEMAN,R1_RAT,R1_GREN,R1_UAVOP],[R1_SF_TLEAD,R1_SF_SNIPER,R1_SF_SNIPERJ,R1_SF_SPOTTER,R1_SF_MARKSMAN,R1_SF_MEDIC,R1_SF_SCOUT,R1_SF_SCOUTAT],[R1_SLEAD,R1_TLEAD,R1_REPAIR,R1_VEH_LITE2,R1_RIFLEMAN,R1_RAT,R1_AT,R1_AA]],
		
		[[B1_SLEAD,B1_TLEAD,B1_MARKSMAN,B1_MEDIC,B1_ENG,B1_EXPLOSIVE,B1_GREN,B1_RIFLEMAN],[B1_SF_SCOUTTL,B1_SF_SNIPER,B1_SF_SNIPERJ,B1_SF_SPOTTER,B1_SF_SCOUTAT,B1_SF_SCOUT,B1_SF_MARKSMAN,B1_SF_DEMO],[B1_SLEAD,B1_TLEAD,B1_MARKSMAN,B1_MEDIC,B1_ENG,B1_EXPLOSIVE,B1_GREN,B1_RIFLEMAN]],
		
		[[R3_B_RIFLE1,R3_B_RIFLE2,R3_B_RIFLE3,R3_B_MG,R3_B_MISSILE,R3_B_UGL,R3_B_MEDIC,R3_B_MINES],[R3_B_RIFLE1,R3_B_RIFLE2,R3_B_RIFLE3,R3_B_MG,R3_B_MISSILE,R3_B_UGL,R3_B_MEDIC,R3_B_MINES],[R3_B_RIFLE1,R3_B_RIFLE2,R3_B_RIFLE3,R3_B_MG,R3_B_MISSILE,R3_B_UGL,R3_B_MEDIC,R3_B_MINES]]
	],
	[
		[[R1_SLEAD,R1_TLEAD,R1_RAT,R1_ASSAT,R1_ASSAA,R1_MEDIC,R1_RIFLEMAN,R1_GREN],[R1_SLEAD,R1_TLEAD,R1_AA,R1_AT,R1_ASSAA,R1_ASSAA,R1_ASSAT,R1_ASSAT],[R1_SLEAD,R1_TLEAD,R1_RAT,R1_ASSAT,R1_AA,R1_AT,R1_AA,R1_AT]],
		
		[[G1_SquadLead,G1_TeamLead,G1_AT,G1_AutoRifleman,G1_Medic,G1_Grenadier,G1_Rifleman,G1_Ammo],[G1_SquadLead,G1_TeamLead,G1_AT,G1_AT,G1_AT,G1_AT,G1_AT,G1_AT],[G1_SquadLead,G1_TeamLead,G1_Rifleman,G1_Rifleman,G1_Rifleman,G1_Rifleman,G1_Rifleman,G1_Rifleman]],
		
		[[G1_SquadLead,G1_TeamLead,G1_AT,G1_AutoRifleman,G1_Medic,G1_Grenadier,G1_Rifleman,G1_Ammo],[G1_SquadLead,G1_TeamLead,G1_AT,G1_AT,G1_AT,G1_AT,G1_AT,G1_AT],[G1_SquadLead,G1_TeamLead,G1_Rifleman,G1_Rifleman,G1_Rifleman,G1_Rifleman,G1_Rifleman,G1_Rifleman]]
	],
	[
		[[R1_EXP,R1_EXP,R1_EXP,R1_EXP,R1_EXP,R1_EXP,R1_EXP,R1_EXP],[R1_OFFICER,R1_SLEAD,R1_TLEAD,R1_EXP,R1_EXP,R1_EXP,R1_EXP,R1_EXP],[R1_OFFICER,R1_SLEAD,R1_TLEAD,R1_EXP,R1_MEDIC,R1_AUTO,R1_ASSAUTO,R1_GREN]],
		
		[[B1_EXPLOSIVE,B1_EXPLOSIVE,B1_EXPLOSIVE,B1_EXPLOSIVE,B1_EXPLOSIVE,B1_EXPLOSIVE,B1_EXPLOSIVE,B1_EXPLOSIVE],[B1_EXPLOSIVE,B1_EXPLOSIVE,B1_EXPLOSIVE,B1_EXPLOSIVE,B1_EXPLOSIVE,B1_EXPLOSIVE,B1_EXPLOSIVE,B1_EXPLOSIVE],[B1_SLEAD,B1_TLEAD,B1_RIFLEMAN,B1_MEDIC,B1_ENG,B1_AUTO,B1_GREN,B1_EXPLOSIVE]],
		
		[[G1_SquadLead,G1_TeamLead,G1_Medic,G1_Engineer,G1_Grenadier,G1_Rifleman,G1_Rifleman,G1_Engineer],[G1_SquadLead,G1_TeamLead,G1_Medic,G1_Repair,G1_Rifleman,G1_Lite,G1_Grenadier,G1_Rifleman],[G1_Officer,G1_SquadLead,G1_TeamLead,G1_Medic,G1_Engineer,G1_Grenadier,G1_Rifleman,G1_Lite]]
	],
	[
		[[B1_SF_SNIPERJ,B1_SF_SNIPERJ,B1_SF_SNIPERJ,B1_SF_SNIPERJ,B1_SF_SNIPERJ,B1_SF_SNIPERJ,B1_SF_SNIPERJ,B1_SF_SNIPERJ],[B1_SF_SNIPER,B1_SF_SNIPER,B1_SF_SNIPER,B1_SF_SNIPER,B1_SF_SNIPER,B1_SF_SNIPER,B1_SF_SNIPER,B1_SF_SNIPER],[B1_SLEAD,B1_TLEAD,B1_RIFLEMAN,B1_MEDIC,B1_AUTO,B1_ENG,B1_GREN,B1_EXPLOSIVE]],
		
		[[G1_Officer,G1_SquadLead,G1_TeamLead,G1_Medic,G1_Spotter,G1_Engineer,G1_AutoRifleman,G1_Rifleman],[G1_SquadLead,G1_TeamLead,G1_Medic,G1_Rifleman,G1_Rifleman,G1_Rifleman,G1_Rifleman,G1_Rifleman],[G1_Spotter,G1_Spotter,G1_Spotter,G1_Spotter,G1_Spotter,G1_Spotter,G1_Spotter,G1_Spotter]],
		
		[[R3_P_RIFLE1,R3_P_RIFLE2,R3_P_RIFLE3,R3_P_MISSILE,R3_P_MEDIC,R3_P_MG,R3_P_UGL,R3_P_EXP],[R3_B_RIFLE1,R3_B_RIFLE2,R3_B_RIFLE3,R3_B_MG,R3_B_MISSILE,R3_B_UGL,R3_B_MEDIC,R3_B_MINES],[G2_SquadLead,G2_TeamLead,G2_Rifleman,G2_Medic,G2_Diver,G2_DiverExp,G2_Diver,G2_DiverExp]]
	],
	[
		[[R1_OFFICER,R1_SLEAD,R1_TLEAD,R1_MEDIC,R1_AUTO,R1_CREW,R1_RIFLEMAN,R1_VEH_CAR],[R1_OFFICER,R1_SLEAD,R1_TLEAD,R1_MEDIC,R1_GREN,R1_CREW,R1_RIFLEMAN,R1_VEH_QUAD],[R1_OFFICER,R1_SLEAD,R1_TLEAD,R1_MEDIC,R1_GREN,R1_CREW,R1_RIFLEMAN,R1_VEH_LITE2]],
		
		[[G2_Officer,G2_SquadLead,G2_TeamLead,G2_Rifleman,G2_Medic,G2_Grenadier,G2_Lite,G2_ArmedCar2],[G2_Officer,G2_SquadLead,G2_TeamLead,G2_Rifleman,G2_Medic,G2_Grenadier,G2_Lite,G2_ArmedCar2],[G2_Officer,G2_SquadLead,G2_TeamLead,G2_Rifleman,G2_Medic,G2_Grenadier,G2_Lite,G2_ArmedCar2]],
		
		[[R3_B_RIFLE1,R3_B_RIFLE2,R3_B_RIFLE3,R3_B_MINES,R3_B_MINES,R3_B_MINES,R3_B_MINES,R3_CAR],[R3_B_RIFLE1,R3_B_RIFLE2,R3_B_RIFLE3,R3_B_MINES,R3_B_MINES,R3_B_MINES,R3_B_MINES,R3_CAR],[R3_B_RIFLE1,R3_B_RIFLE2,R3_B_RIFLE3,R3_B_MINES,R3_B_MINES,R3_B_MINES,R3_B_MINES,R3_CAR]]
	],
	[
		[[R1_SF_DLEAD,R1_SF_DEXP,R1_SF_DIVER,R1_SF_DIVER,R1_SF_DIVER,R1_SF_DIVER,R1_SF_DIVER,R1_SF_DIVER],[R1_SF2_TLEAD,R1_SF2_RAT,R1_SF2_MEDIC,R1_SF2_OP,R1_SF2_MARKSMAN,R1_SF2_JTAC,R1_SF2_DEMO,R1_SF2_OP],[R1_SF_TLEAD,R1_SF_MARKSMAN,R1_SF_SCOUT,R1_SF_SCOUTAT,R1_SF_SNIPER,R1_SF_SNIPERJ,R1_SF_SPOTTER,R1_SF_JTAC]],
		
		[[B1_SF_DIVERTL,B1_SF_DIVER,B1_SF_DIVEREXP,B1_SF_DIVER,B1_SF_DIVER,B1_SF_DIVER,B1_SF_DIVER,B1_SF_DIVER],[B1_SF_SCOUTTL,B1_SF_SCOUT,B1_SF_PARA,B1_SF_DEMO,B1_SF_JTAC,B1_SF_MARKSMAN,B1_SF_SCOUTAT,B1_SF_SNIPER],[B1_OFFICER,B1_SLEAD,B1_TLEAD,B1_RIFLEMAN,B1_MEDIC,B1_AMMO,B1_GUN1,B1_EXPLOSIVE]],
		
		[[R3_B_RIFLE1,R3_B_RIFLE2,R3_B_RIFLE3,R3_B_MG,R3_B_UGL,R3_B_MISSILE,R3_B_MEDIC,R3_B_MINES],[R3_P_RIFLE1,R3_P_RIFLE2,R3_P_RIFLE3,R3_P_MEDIC,R3_P_MG,R3_P_UGL,R3_P_EXP,R3_P_MISSILE],[R3_B_MINES,R3_B_MINES,R3_B_MINES,R3_B_MINES,R3_B_MINES,R3_B_MINES,R3_B_MINES,R3_CAR]]
	],
	[
		[[R1_HELIPILOT,R1_HELICREW,R1_HELICREW,R1_HELICREW,R1_HELICREW,R1_HELICREW,R1_HELICREW,R1_HELICREW],[R1_OFFICER,R1_SLEAD,R1_TLEAD,R1_MEDIC,R1_ENG,R1_EXP,R1_AUTO,R1_MARKSMAN],[R1_CREW,R1_CREW,R1_CREW,R1_CREW,R1_CREW,R1_CREW,R1_CREW,R1_CREW]],
		
		[[G1_Pilot,G1_Pilot,G1_Pilot,G1_Pilot,G1_Pilot,G1_Pilot,G1_Pilot,G1_Pilot],[G1_Officer,G1_SquadLead,G1_TeamLead,G1_Medic,G1_Rifleman,G1_Grenadier,G1_Marksman,G1_Engineer],[G1_Officer,G1_SquadLead,G1_TeamLead,G1_Medic,G1_Rifleman,G1_Grenadier,G1_Marksman,G1_Engineer]],
		
		[[G1_Pilot,G1_Pilot,G1_Pilot,G1_Pilot,G1_Pilot,G1_Pilot,G1_Pilot,G1_Pilot],[G1_Officer,G1_SquadLead,G1_TeamLead,G1_Medic,G1_Rifleman,G1_Grenadier,G1_Marksman,G1_Engineer],[G1_Officer,G1_SquadLead,G1_TeamLead,G1_Medic,G1_Rifleman,G1_Grenadier,G1_Marksman,G1_Engineer]]
	],
	[
		[[R1_PLANE1,R1_AMMO,R1_ASSAUTO,R1_ASSGUN1,R1_ASSGUN2,R1_ASSAA,R1_ASSAT,R1_AUTO,R1_MEDIC,R1_CREW,R1_ENG,R1_EXP,R1_GREN,R1_GUN1,R1_GUN2,R1_GUN3,R1_HELICREW,R1_HELIPILOT,R1_MARKSMAN,R1_AA,R1_AT,R1_OFFICER,R1_PARA,R1_PILOT,R1_REPAIR,R1_RIFLEMAN,R1_RAT,R1_SLEAD,R1_TLEAD,R1_UAVOP],[R1_PLANE1,R1_AMMO,R1_ASSAUTO,R1_ASSGUN1,R1_ASSGUN2,R1_ASSAA,R1_ASSAT,R1_AUTO,R1_MEDIC,R1_CREW,R1_ENG,R1_EXP,R1_GREN,R1_GUN1,R1_GUN2,R1_GUN3,R1_HELICREW,R1_HELIPILOT,R1_MARKSMAN,R1_AA,R1_AT,R1_OFFICER,R1_PARA,R1_PILOT,R1_REPAIR,R1_RIFLEMAN,R1_RAT,R1_SLEAD,R1_TLEAD,R1_UAVOP],[R1_PLANE1,R1_AMMO,R1_ASSAUTO,R1_ASSGUN1,R1_ASSGUN2,R1_ASSAA,R1_ASSAT,R1_AUTO,R1_MEDIC,R1_CREW,R1_ENG,R1_EXP,R1_GREN,R1_GUN1,R1_GUN2,R1_GUN3,R1_HELICREW,R1_HELIPILOT,R1_MARKSMAN,R1_AA,R1_AT,R1_OFFICER,R1_PARA,R1_PILOT,R1_REPAIR,R1_RIFLEMAN,R1_RAT,R1_SLEAD,R1_TLEAD,R1_UAVOP]]
	]
];
//side of PM Enemy
PMSidesArray = [
	[EAST,EAST,EAST],
	[EAST,EAST,EAST],
	[EAST,EAST,EAST],
	[EAST,EAST,EAST],
	[EAST,EAST,EAST],
	[EAST,EAST,EAST],
	[EAST,EAST,EAST],
	[EAST,EAST,EAST],
	[EAST,EAST,EAST],
	[EAST]
];
//number of groups per job
PMloopArray = [9,6,3];
//array of ranks given to units
PMRankArray = [
	["CAPTAIN","LIEUTENANT","SERGEANT","CORPORAL","CORPORAL","SERGEANT","CORPORAL","CORPORAL"],
	["LIEUTENANT","SERGEANT","CORPORAL","CORPORAL","PRIVATE","SERGEANT","CORPORAL","PRIVATE"],
	["SERGEANT","CORPORAL","PRIVATE","PRIVATE","PRIVATE","CORPORAL","PRIVATE","PRIVATE"]
];
//skill min,range of extra
PMSkillArrays = [
	[0.4,0.2],
	[0.3,0.2],
	[0.1,0.1]
];
//min amount of ammo, range of extra
PMAmmoArrays = [
	[1,0.5],
	[0.8,0.3],
	[0.6,0.1]
];
//number of units spawning in each group, chance of further units (max 8)
PMUnitNumbersArrays = [
	[4, 0.4],
	[3, 0.3],
	[2, 0.2]
];
//area over which PM takes place, (marker and unit waypoints)
PMRadii = [600,400,200];

//array of loot locations by PM type and level
PMLocations = [
	[getMarkerPos "PM0", getMarkerPos "PM0_1", getMarkerPos "PM0_2"],
	[getMarkerPos "PM1", getMarkerPos "PM1_1", getMarkerPos "PM1_2"],
	[getMarkerPos "PM2", getMarkerPos "PM2_1", getMarkerPos "PM2_2"],
	[getMarkerPos "PM3", getMarkerPos "PM3_1", getMarkerPos "PM3_2"],
	[getMarkerPos "PM4", getMarkerPos "PM4_1", getMarkerPos "PM4_2"],
	[getMarkerPos "PM5", getMarkerPos "PM5_1", getMarkerPos "PM5_2"],
	[getMarkerPos "PM6", getMarkerPos "PM6_1", getMarkerPos "PM6_2"],
	[getMarkerPos "PM7", getMarkerPos "PM7_1", getMarkerPos "PM7_2"],
	[getMarkerPos "PM8", getMarkerPos "PM8_1", getMarkerPos "PM8_2"],
	[getMarkerPos "PM9"]//TV CSAT
];
//array of cache locations by PM type and level
PMLootDropOffs = [
	[getMarkerPos "X0", getMarkerPos "Y0", getMarkerPos "Z0"],
	[getMarkerPos "X1", getMarkerPos "Y1", getMarkerPos "Z1"],
	[getMarkerPos "X2", getMarkerPos "Y2", getMarkerPos "Z2"],
	[getMarkerPos "X3", getMarkerPos "Y3", getMarkerPos "Z3"],
	[getMarkerPos "X4", getMarkerPos "Y4", getMarkerPos "Z4"],
	[getMarkerPos "X5", getMarkerPos "Y5", getMarkerPos "Z5"],
	[getMarkerPos "X6", getMarkerPos "Y6", getMarkerPos "Z6"],
	[getMarkerPos "X7", getMarkerPos "Y7", getMarkerPos "Z7"],
	[getMarkerPos "X8", getMarkerPos "Y8", getMarkerPos "Z8"],
	[getMarkerPos "PM9_1"]
];
//string description of job reward for the leader
PMRewardArray = [
	["T$ 1,000,000","T$ 500,000","T$ 250,000"],
	["Automatic Weapons","Rifles","Handguns"],
	["Sniper Rifles","Marksman Rifles","SMGs"],
	["AA and AT Javelins","PMCL Rocket Launcher","Single Use RPG"],
	["Mortars","Mines","Explosive Charges"],
	["Protective Clothing, Guile Suits, UAVs, etc.","NVGs, Rangefinders, IR Grenades etc.","Backbacks, Headgear, Wetsuites etc."],
	["APC","Armed Personel Vehicle","Light Personel Vehicle"],
	["Armed Boat","SDV","Dingy"],
	["Armed Helicopter","CAS Plane","Civilian Helicopter"],
	["Freedom from CSAT Tyranny"]
];
//picture displayed in map view on mouse hover
PMOverviewImages = [
	"images\Dollar.jpg",
	"A3\ui_f\data\GUI\Cfg\Hints\Automatic_ca.paa",
	"A3\ui_f\data\GUI\Cfg\Hints\Sniper_ca.paa",
	"A3\ui_f\data\GUI\Cfg\Hints\AmmoType_CA.paa",
	"A3\ui_f\data\GUI\Cfg\Hints\IEDs_CA.paa",
	"A3\ui_f\data\GUI\Cfg\Hints\Gear_ca.paa",
	"A3\ui_f\data\GUI\Cfg\Hints\VehicleCommanding_CA.paa",
	"A3\ui_f\data\GUI\Cfg\Hints\SDV_ca.paa",
	"A3\ui_f\data\map\vehicleicons\iconplane_ca.paa",
	"A3\ui_f\data\GUI\Cfg\Hints\Thirdperson_ca.paa"
];
//Description of job shown in PM map and diary
PMDescriptions = [
	"Find and steal the cash near this location. Expect resistance.",
	"Locate and raid the nearby weapons cache. Expect resistance.",
	"Loot the specialist weapons from this cache. Expect resistance.",
	"Rocket launchers can be found near this location. Expect resistance.",
	"Explosive devices could be looted from here. Expect resistance.",
	"Various kinds of personal gear is known to be nearby. Expect resistance.",
	"A useful land vehicle is just asking to be stolen. Expect resistance.",
	"Steal the boats or SDVs would be kept here. Expect resistance.",
	"Planes and helicopters are still here to be taken. Expect resistance.",
	"Got good enough friends in Tanoa to relax? Your break won't last long. Final mission for control of Tanoa."
];
//larger map icons for tougher tasks
PMIconSizes = [1.2, 0.9, 0.6];
//Cost to the leader of hiring each squad member, players receive this amount
PMMoneyArray = [200,100,50];
//Where opening PM map will show
PMDefaultMapPos = [7122.63,7399.72,0];
//String for mission type in mission title
PMTypeArray = [
	"Cash Raid",
	"Weapons Raid",
	"Special Weapons Raid",
	"Rockets Raid",
	"Explosives Raid",
	"Equipment Raid",
	"Commandeer A Land Vehicle",
	"Commandeer A Sea Vehicle",
	"Commandeer An Air Vehicle",
	"Watch TV"
];
//String for difficulty in mission title
PMDifficultyArray = ["Stronger","Capable","Soft"];
//random time enemies sit at waypoints
PMWaypointTimeout = [60, 120, 180];

//Build data into array of missions for the PM map
PersonalMissionArray = []; //list of missions
{
	_i =+ _forEachIndex;
	_typeLocations = _x;
	{
		_j = _forEachIndex;
		_nextMission = [];
		_nextMission set [0, _x]; //mission position in format [x,y,y] or [x,y]
		_nextMission set [1, {
			if (count CurrentMission < 1) then
			{
				_type = _this select 9 select 0;
				_level = _this select 9 select 1;
				_location = PMLocations select _type select _level;
				_dist = (PMRadii select _level) + 300;
				if (_type == 9) then
				{
				    Progress=[];
				    SendProgress = [player,player];
					publicVariableServer "SendProgress";
				    waitUntil{count(Progress)>0};
				    _count = Progress call DeepSum;
				    if (_count<30) then
				    {
				        [65,_count] call Messages;
				    }
				    else
				    {
    					if (player distance _location < 11) then
    					{
    						PersonalMission = +(_this select 9);
    						{
    							if (str _x == str (PersonalMission select 2)) then
    							{
    								PersonalMission set [2,_x];
    							};
    						}forEach allUnits;
    						missionStartTime = time;
    						PersonalMission set [3,missionStartTime];
    						publicVariableServer "PersonalMission";
    					}
    					else
    					{//too far from TV
    						[56,nil] call Messages;
    					};
    				};
				}
				else
				{
					if ((player distance _location) > _dist) then
					{
						PersonalMission = +(_this select 9);
						{
							if (str _x == str (PersonalMission select 2)) then
							{
								PersonalMission set [2,_x];
							};
						}forEach allUnits;
						missionStartTime = time;
						PersonalMission set [3,missionStartTime];
						publicVariableServer "PersonalMission";
					}
					else
					{//too close
						[43,_dist] call Messages;
					};
				};
			}
			else
			{//quit current
				[44,nil] call Messages;
			};
		}]; //expression executed when user clicks on mission icon
		_nextMission set [2, (PMTypeArray select _i) + ": " + (PMDifficultyArray select _j) + " Target"]; //mission name
		_nextMission set [3, (PMDescriptions select _i) +"<br/>Hiring Cost: T$ " + (str (PMMoneyArray select _j)) + ",000 Per Member<br/>Reward: " + (PMRewardArray select _i select _j) + " For Each Member<br/>Location: " + format["%1",(text ((nearestLocations [_x,["NameCityCapital","NameCity","NameVillage"],2000]) select 0))]]; //short description
		_nextMission set [4, profileName + "'s Job"]; //name of mission's player
		_nextMission set [5, PMOverviewImages select _i]; //path to overview image
		_nextMission set [6, PMIconSizes select _j]; //size multiplier, 1 means default size
		_nextMission set [7, [_i, _j, player]]; //parameters for the -on click- code; referenced from the script as (_this select 9)
		PersonalMissionArray append [_nextMission];
	}forEach _x;
}forEach PMLocations;