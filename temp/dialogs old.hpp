//dialogs.hpp
//Runs on all machines
//Included from description.ext
//Sets up all GUI interfaces

class HG_GUIMain
{
	idd=-1;
	movingenable=false;
	onLoad = "[(_this select 0),1000] execVM ""GUI\GUITarget.sqf""";
	onKeyDown = "[] call CloseGUI";
	class controls 
	{
		class HG_PlayerName: TargetText
		{
			idc = 1000;
			x = 0.40 * safezoneW + safezoneX;
			y = 0.91 * safezoneH + safezoneY;
			w = 0.2 * safezoneW;
			h = 0.08 * safezoneH;
		};
		class HG_InteractButton: QuadButton //top right
		{
			idc = 1601;
			text = "\a3\ui_f\data\IGUI\Cfg\Actions\talk_ca.paa";
			x = 0.55 * safezoneW + safezoneX;
			y = 0.6 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.1 * safezoneH;
			onMouseEnter = "createdialog ""HG_GUIInteract"";";
		};
		class HG_SettingsButton: QuadButton //bottom left
		{
			idc = 1602;
			text = "\a3\ui_f\data\IGUI\Cfg\Actions\repair_ca.paa";
			x = 0.35 * safezoneW + safezoneX;
			y = 0.8 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.1 * safezoneH;
			onMouseEnter = "createdialog ""HG_GUISettings"";";
		};
		class HG_StatusButton: QuadButton //bottom right
		{
			idc = 1603;
			text = "\a3\ui_f\data\map\mapcontrol\tourism_ca.paa";
			x = 0.55 * safezoneW + safezoneX;
			y = 0.8 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.1 * safezoneH;
			onMouseEnter = "createdialog ""HG_GUIStatus"";";
		};
		class HG_MissionActionsButton: QuadButton //top left
		{
			idc = 1604;
			text = "\a3\ui_f\data\GUI\Cfg\GameTypes\seize_ca.paa";
			x = 0.35 * safezoneW + safezoneX;
			y = 0.6 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.1 * safezoneH;
			onMouseEnter = "createdialog ""HG_GUIMission"";";
		};
		class HG_CloseButton: QuadButton //centre
		{
			idc = 1626;
			text = "\a3\ui_f\data\map\mapcontrol\taskiconfailed_ca.paa";
			x = 0.45 * safezoneW + safezoneX;
			y = 0.7 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.1 * safezoneH;
			tooltip = "Close Interface"; 
			action = "execVM ""GUI\CloseGui.sqf""";
			onMouseEnter = "(_this select 0) ctrlSetTextColor [0.1,0.1,1,1];";
			onMouseExit = "(_this select 0) ctrlSetTextColor [1,1,1,1];";
		};
	};
};

class HG_GUIMission //top left
{
	idd=-2;
	movingenable=false;
	onLoad = "[(_this select 0),100] execVM ""GUI\GUITarget.sqf""";
	onKeyDown = "[] call CloseGUI";
	class controls 
	{
		class HG_PlayerName: TargetText
		{
			idc = 100;
			x = 0.40 * safezoneW + safezoneX;
			y = 0.91 * safezoneH + safezoneY;
			w = 0.2 * safezoneW;
			h = 0.08 * safezoneH;
			tooltip = "Selected Player";
		};
		class HG_InteractButton: QuadButton //top right
		{
			idc = 1601;
			text = "\a3\ui_f\data\IGUI\Cfg\Actions\talk_ca.paa";
			x = 0.55 * safezoneW + safezoneX;
			y = 0.6 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.1 * safezoneH;
			onMouseEnter = "closeDialog 0";
		};
		
		class HG_SettingsButton: QuadButton //bottom left
		{
			idc = 1602;
			text = "\a3\ui_f\data\IGUI\Cfg\Actions\repair_ca.paa";
			x = 0.35 * safezoneW + safezoneX;
			y = 0.8 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.1 * safezoneH;
			onMouseEnter = "closeDialog 0";
		};
		class HG_StatusButton: QuadButton //bottom right
		{
			idc = 1603;
			text = "\a3\ui_f\data\map\mapcontrol\tourism_ca.paa";
			x = 0.55 * safezoneW + safezoneX;
			y = 0.8 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.1 * safezoneH;
			onMouseEnter = "closeDialog 0";
		};
		
		class HG_CloseButton: QuadButton //centre
		{
			idc = 1626;
			text = "\a3\ui_f\data\map\mapcontrol\taskiconfailed_ca.paa";
			x = 0.45 * safezoneW + safezoneX;
			y = 0.7 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.1 * safezoneH;
			onMouseEnter = "closeDialog 0";
		};
		class HG_MissionActionsButtonPicture: QuadSelected
		{
			idc = 1003;
			text = "\a3\ui_f\data\GUI\Cfg\GameTypes\seize_ca.paa";
			x = 0.35 * safezoneW + safezoneX;
			y = 0.6 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.1 * safezoneH;
			tooltip = "Mission Actions";
		};
		class HG_MyMission: SideButton
		{
			idc = 1613;
			text = "My Mission"; 
			x = 0.025 * safezoneW + safezoneX;
			y = 0.4 * safezoneH + safezoneY;
			w = 0.3 * safezoneW;
			h = 0.1 * safezoneH;
			tooltip = "Show current mission"; 
			action = "execVM ""GUI\CurrentMission.sqf""";
		};
		class HG_Mission: SideButton
		{
			idc = 1617;
			text = "Personal Jobs"; 
			x = 0.025 * safezoneW + safezoneX;
			y = 0.55 * safezoneH + safezoneY;
			w = 0.3 * safezoneW;
			h = 0.1 * safezoneH;
			tooltip = "Show personal jobs map";
			action = "execVM ""GUI\PersonalMissions.sqf""";
		};
		class HG_Team: SideButton
		{
			idc = 1619;
			text = "Quit Job/Team"; 
			x = 0.025 * safezoneW + safezoneX;
			y = 0.7 * safezoneH + safezoneY;
			w = 0.3 * safezoneW;
			h = 0.1 * safezoneH;
			tooltip = "Quit team or cancel mission"; 
			action = "execVM ""GUI\EndMission.sqf""";
		};
		class HG_MyTeam: SideButton
		{
			idc = 1616;
			text = "Block Requests"; 
			x = 0.025 * safezoneW + safezoneX;
			y = 0.85 * safezoneH + safezoneY;
			w = 0.3 * safezoneW;
			h = 0.1 * safezoneH;
			tooltip = "Job invites from players will be blocked"; 
			action = "execVM ""GUI\BlockRequests.sqf""";
		};
	};
};

class HG_GUISettings //bottom left
{
	idd=-3;
	movingenable=false;
	onLoad = "[(_this select 0),200] execVM ""GUI\GUITarget.sqf""";
	onKeyDown = "[] call CloseGUI";
	class controls 
	{
		class HG_PlayerName: TargetText
		{
			idc = 200;
			x = 0.40 * safezoneW + safezoneX;
			y = 0.91 * safezoneH + safezoneY;
			w = 0.2 * safezoneW;
			h = 0.08 * safezoneH;
			tooltip = "Selected Player";
		};
		class HG_MissionActionsButton: QuadButton //top left
		{
			idc = 1604;
			text = "\a3\ui_f\data\GUI\Cfg\GameTypes\seize_ca.paa";
			x = 0.35 * safezoneW + safezoneX;
			y = 0.6 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.1 * safezoneH;
			onMouseEnter = "closeDialog 0";
		};
		class HG_InteractButton: QuadButton //top right
		{
			idc = 1601;
			text = "\a3\ui_f\data\IGUI\Cfg\Actions\talk_ca.paa";
			x = 0.55 * safezoneW + safezoneX;
			y = 0.6 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.1 * safezoneH;
			onMouseEnter = "closeDialog 0";
		};
		class HG_StatusButton: QuadButton //bottom right
		{
			idc = 1603;
			text = "\a3\ui_f\data\map\mapcontrol\tourism_ca.paa";
			x = 0.55 * safezoneW + safezoneX;
			y = 0.8 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.1 * safezoneH;
			onMouseEnter = "closeDialog 0";
		};
		class HG_CloseButton: QuadButton //centre
		{
			idc = 1626;
			text = "\a3\ui_f\data\map\mapcontrol\taskiconfailed_ca.paa";
			x = 0.45 * safezoneW + safezoneX;
			y = 0.7 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.1 * safezoneH;
			onMouseEnter = "closeDialog 0";
		};
		class HG_SettingsButtonPicture: QuadSelected
		{
			idc = 1001;
			text = "\a3\ui_f\data\IGUI\Cfg\Actions\repair_ca.paa";
			x = 0.35 * safezoneW + safezoneX;
			y = 0.8 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.1 * safezoneH;
			tooltip = "Game Setup";
		};
	
		class HG_MapConditions: SideButton
		{
			idc = 1601;
			text = "Map Conditions"; 
			x = 0.025 * safezoneW + safezoneX;
			y = 0.4 * safezoneH + safezoneY;
			w = 0.3 * safezoneW;
			h = 0.1 * safezoneH;
			tooltip = "Wind direction, factions used, view distance, etc."; 
			action = "execVM ""GUI\MapConditions.sqf""";
		};/* 
		class HG_Credits: SideButton
		{
			idc = 1603;
			text = "Prologue Video"; 
			x = 0.025 * safezoneW + safezoneX;
			y = 0.55 * safezoneH + safezoneY;
			w = 0.3 * safezoneW;
			h = 0.1 * safezoneH;
			tooltip = "Short prologue video";
			action = "execVM ""GUI\Credits.sqf""";
		}; */
		class HG_Credits
		{
			access = 0; // Control access (0 - ReadAndWrite, 1 - ReadAndCreate, 2 - ReadOnly, 3 - ReadOnlyVerified)
			//idc = 1608; // Control identification (without it, the control won't be displayed)
			type = CT_HTML; // Type
			style = 98;
			default = 0; // Control selected by default (only one within a display can be used)
			blinkingPeriod = 0; // Time in which control will fade out and back in. Use 0 to disable the effect.
			
			idc = 1603;
			text = "Prologue Video"; 
			x = 0.025 * safezoneW + safezoneX;
			y = 0.55 * safezoneH + safezoneY;
			w = 0.3 * safezoneW;
			h = 0.1 * safezoneH;
			tooltip = "Short prologue video (browser)";

			colorText[] = {1,1,1,0.95}; // Text color
			colorBold[] = {1,1,1,0.95}; // <b> text color
			colorLink[] = {1,1,1,0.95}; // <a> text color
			colorLinkActive[] = {1,0.5,0,1}; // Active <a> text color
			colorPicture[] = {1,1,1,1}; // Picture color
			colorPictureBorder[] = {0,0,0,0}; // Picture border color
			colorPictureLink[] = {1,1,1,1}; // <a> picture color
			colorPictureSelected[] = {1,1,1,1}; // Active <a> picture color
			colorDisabled[] = {0,0,0,0};
			colorBackground[] = {1,1,1,0.2};
			colorBackgroundDisabled[] = {1,1,1,0.2};
			colorBackgroundActive[] = {1,1,1,0.35};
			colorFocused[] = {0,0,0,0};
			colorShadow[] = {0,0,0,0};
			colorBorder[] = {0,0,0,0};

			prevPage = "\A3\ui_f\data\gui\rsccommon\rschtml\arrow_left_ca.paa"; // Pagination arrow for previous page
			nextPage = "\A3\ui_f\data\gui\rsccommon\rschtml\arrow_right_ca.paa"; // Pagination arrow for next page

			//tooltip = "Report Bugs, Share Ideas, Donate, etc..."; // Tooltip text
			
			//filename = "a3\ui_f\data\html\Donate.html";
			filename = "html\Prologue.html";
			class P // Paragraph style
			{
				font = "PuristaBold"; // Font from CfgFontFamilies
				fontBold = "PuristaBold"; // Vold font from CfgFontFamilies
				SizeEx = 0.045; // Text size
				align = "center"; // Text align (can be "left", "center" or "right")
			};
			class H1:P{}; // Header 1 style (uses same attributes as P)
			class H2:P{}; // Header 2 style (uses same attributes as P)
			class H3:P{}; // Header 3 style (uses same attributes as P)
			class H4:P{}; // Header 4 style (uses same attributes as P)
			class H5:P{}; // Header 5 style (uses same attributes as P)
			class H6:P{}; // Header 6 style (uses same attributes as P)
		};
		class HG_WHM: SideButton
		{
			idc = 1600;
			text = "Admin Tools"; 
			x = 0.025 * safezoneW + safezoneX;
			y = 0.7 * safezoneH + safezoneY;
			w = 0.3 * safezoneW;
			h = 0.1 * safezoneH;
			tooltip = "Soon to be added!"; //Terminate HGs, global messaging, etc
			action = "execVM ""GUI\AdminTools.sqf""";
		};
		class _CT_HTML
		{
			access = 0; // Control access (0 - ReadAndWrite, 1 - ReadAndCreate, 2 - ReadOnly, 3 - ReadOnlyVerified)
			idc = 1608; // Control identification (without it, the control won't be displayed)
			type = CT_HTML; // Type
			style = 98;
			default = 0; // Control selected by default (only one within a display can be used)
			blinkingPeriod = 0; // Time in which control will fade out and back in. Use 0 to disable the effect.

			x = 0.025 * safezoneW + safezoneX;
			y = 0.85 * safezoneH + safezoneY;
			w = 0.3 * safezoneW;
			h = 0.1 * safezoneH;

			colorText[] = {1,1,1,0.95}; // Text color
			colorBold[] = {1,1,1,0.95}; // <b> text color
			colorLink[] = {1,1,1,0.95}; // <a> text color
			colorLinkActive[] = {1,0.5,0,1}; // Active <a> text color
			colorPicture[] = {1,1,1,1}; // Picture color
			colorPictureBorder[] = {0,0,0,0}; // Picture border color
			colorPictureLink[] = {1,1,1,1}; // <a> picture color
			colorPictureSelected[] = {1,1,1,1}; // Active <a> picture color
			colorDisabled[] = {0,0,0,0};
			colorBackground[] = {1,1,1,0.2};
			colorBackgroundDisabled[] = {1,1,1,0.2};
			colorBackgroundActive[] = {1,1,1,0.35};
			colorFocused[] = {0,0,0,0};
			colorShadow[] = {0,0,0,0};
			colorBorder[] = {0,0,0,0};

			prevPage = "\A3\ui_f\data\gui\rsccommon\rschtml\arrow_left_ca.paa"; // Pagination arrow for previous page
			nextPage = "\A3\ui_f\data\gui\rsccommon\rschtml\arrow_right_ca.paa"; // Pagination arrow for next page

			tooltip = "Report Bugs, Share Ideas, Donate, etc..."; // Tooltip text
			
			//filename = "a3\ui_f\data\html\Donate.html";
			filename = "html\RscFeedback2.html";
			class P // Paragraph style
			{
				font = "PuristaBold"; // Font from CfgFontFamilies
				fontBold = "PuristaBold"; // Vold font from CfgFontFamilies
				SizeEx = 0.045; // Text size
				align = "center"; // Text align (can be "left", "center" or "right")
			};
			class H1:P{}; // Header 1 style (uses same attributes as P)
			class H2:P{}; // Header 2 style (uses same attributes as P)
			class H3:P{}; // Header 3 style (uses same attributes as P)
			class H4:P{}; // Header 4 style (uses same attributes as P)
			class H5:P{}; // Header 5 style (uses same attributes as P)
			class H6:P{}; // Header 6 style (uses same attributes as P)
		};
	};
};
class HG_GUIInteract //top right
{
	idd=-4;
	movingenable=false;
	onLoad = "[(_this select 0),300] execVM ""GUI\GUITarget.sqf""";
	onKeyDown = "[] call CloseGUI";
	class controls 
	{
		class HG_PlayerName: TargetText
		{
			idc = 300;
			x = 0.40 * safezoneW + safezoneX;
			y = 0.91 * safezoneH + safezoneY;
			w = 0.2 * safezoneW;
			h = 0.08 * safezoneH;
			tooltip = "Selected Player";
		};
		class HG_MissionActionsButton: QuadButton //top left
		{
			idc = 1604;
			text = "\a3\ui_f\data\GUI\Cfg\GameTypes\seize_ca.paa";
			x = 0.35 * safezoneW + safezoneX;
			y = 0.6 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.1 * safezoneH;
			onMouseEnter = "closeDialog 0";
		};
		class HG_SettingsButton: QuadButton //bottom left
		{
			idc = 1602;
			text = "\a3\ui_f\data\IGUI\Cfg\Actions\repair_ca.paa";
			x = 0.35 * safezoneW + safezoneX;
			y = 0.8 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.1 * safezoneH;
			onMouseEnter = "closeDialog 0";
		};
		class HG_StatusButton: QuadButton //bottom right
		{
			idc = 1603;
			text = "\a3\ui_f\data\map\mapcontrol\tourism_ca.paa";
			x = 0.55 * safezoneW + safezoneX;
			y = 0.8 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.1 * safezoneH;
			onMouseEnter = "closeDialog 0";
		};
		class HG_CloseButton: QuadButton //centre
		{
			idc = 1626;
			text = "\a3\ui_f\data\map\mapcontrol\taskiconfailed_ca.paa";
			x = 0.45 * safezoneW + safezoneX;
			y = 0.7 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.1 * safezoneH;
			onMouseEnter = "closeDialog 0";
		};
		
 		class HG_InteractButtonPicture: QuadSelected
		{
			idc = 5000;
			text = "\a3\ui_f\data\IGUI\Cfg\Actions\talk_ca.paa";
			x = 0.55 * safezoneW + safezoneX;
			y = 0.6 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.1 * safezoneH;
			tooltip = "Interact Options";
		};
		class HG_RequestHiring: SideButton
		{
			idc = 1606;
			text = "Hire/Get Hired"; 
			x = 0.675 * safezoneW + safezoneX;
			y = 0.4 * safezoneH + safezoneY;
			w = 0.3 * safezoneW;
			h = 0.1 * safezoneH;
			tooltip = "Interact depending on whether or not you have a job to offer"; 
			action = "execVM ""GUI\SpeakToNPC.sqf""";
		};
		class HG_Intel: SideButton
		{
			idc = 1604;
			text = "Personal Intel";
			x = 0.675 * safezoneW + safezoneX;
			y = 0.55 * safezoneH + safezoneY;
			w = 0.3 * safezoneW;
			h = 0.1 * safezoneH;
			tooltip = "View enemy/friendly kills, jobs completed, etc.";
			action = "execVM ""GUI\Intel.sqf""";
		};
		class HG_Hire: SideButton
		{
			idc = 1607;
			text = "Kick Squad Member"; 
			x = 0.675 * safezoneW + safezoneX;
			y = 0.7 * safezoneH + safezoneY;
			w = 0.3 * safezoneW;
			h = 0.1 * safezoneH;
			tooltip = "Can only kick as squad leader"; 
			action = "execVM ""GUI\Kick.sqf""";
		};
		class HG_MoneyList: SideButton
		{
			idc = 1605;
			text = "Money List";
			x = 0.675 * safezoneW + safezoneX;
			y = 0.85 * safezoneH + safezoneY;
			w = 0.3 * safezoneW;
			h = 0.1 * safezoneH;
			tooltip = "See who's on top in Tanoa";
			action = "execVM ""GUI\ShowMoneyList.sqf""";
		};
	};
};
class HG_GUIStatus //bottom right
{
	idd=-5;
	movingenable=false;
	onLoad = "[(_this select 0),400] execVM ""GUI\GUITarget.sqf""";
	onKeyDown = "[] call CloseGUI";
	class controls 
	{
		class HG_PlayerName: TargetText
		{
			idc = 400;
			x = 0.40 * safezoneW + safezoneX;
			y = 0.91 * safezoneH + safezoneY;
			w = 0.2 * safezoneW;
			h = 0.08 * safezoneH;
			tooltip = "Selected Player";
		};
		class HG_MissionActionsButton: QuadButton //top left
		{
			idc = 1604;
			text = "\a3\ui_f\data\GUI\Cfg\GameTypes\seize_ca.paa";
			x = 0.35 * safezoneW + safezoneX;
			y = 0.6 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.1 * safezoneH;
			onMouseEnter = "closeDialog 0";
		};
		class HG_InteractButton: QuadButton //top right
		{
			idc = 1601;
			text = "\a3\ui_f\data\IGUI\Cfg\Actions\talk_ca.paa";
			x = 0.55 * safezoneW + safezoneX;
			y = 0.6 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.1 * safezoneH;
			onMouseEnter = "closeDialog 0";
		};
		class HG_SettingsButton: QuadButton //bottom left
		{
			idc = 1602;
			text = "\a3\ui_f\data\IGUI\Cfg\Actions\repair_ca.paa";
			x = 0.35 * safezoneW + safezoneX;
			y = 0.8 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.1 * safezoneH;
			onMouseEnter = "closeDialog 0";
		};
		class HG_CloseButton: QuadButton //centre
		{
			idc = 1626;
			text = "\a3\ui_f\data\map\mapcontrol\taskiconfailed_ca.paa";
			x = 0.45 * safezoneW + safezoneX;
			y = 0.7 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.1 * safezoneH;
			onMouseEnter = "closeDialog 0";
		};
		class HG_StatusButtonPicture: QuadSelected
		{
			idc = 1002;
			style = 2096;
			colorText[] = {0.1,0.1,1,1};
			text = "\a3\ui_f\data\map\mapcontrol\tourism_ca.paa";
			x = 0.55 * safezoneW + safezoneX;
			y = 0.8 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.1 * safezoneH;
			tooltip = "View Progression";
		};
		class HG_Money: SideButton
		{
			idc = 1618;
			text = "My Cash"; 
			x = 0.675 * safezoneW + safezoneX;
			y = 0.4 * safezoneH + safezoneY;
			w = 0.3 * safezoneW;
			h = 0.1 * safezoneH;
			tooltip = "Shows your current earnings"; 
			action = "execVM ""GUI\Money.sqf""";
		};
		class HG_Progress: SideButton
		{
			idc = 1611;
			text = "My Progress"; 
			x = 0.675 * safezoneW + safezoneX;
			y = 0.55 * safezoneH + safezoneY;
			w = 0.3 * safezoneW;
			h = 0.1 * safezoneH;
			tooltip = "Shows progression with your jobs"; 
			action = "execVM ""GUI\Progress.sqf""";
		};
		class HG_Garages: SideButton
		{
			idc = 1610;
			text = "My Garages"; 
			x = 0.675 * safezoneW + safezoneX;
			y = 0.7 * safezoneH + safezoneY;
			w = 0.3 * safezoneW;
			h = 0.1 * safezoneH;
			tooltip = "Marks garages containing your vehicles on the map";
			action = "execVM ""GUI\Garages.sqf""";
		};
		class HG_Crates: SideButton
		{
			idc = 1609;
			text = "My Crates"; 
			x = 0.675 * safezoneW + safezoneX;
			y = 0.85 * safezoneH + safezoneY;
			w = 0.3 * safezoneW;
			h = 0.1 * safezoneH;
			tooltip = "Marks crates containing your gear on the map"; 
			action = "execVM ""GUI\Crates.sqf""";
		};
	};
};

////////////////////////////////////////////////////////////////////////////////////////////////////////

class HG_TwoMissions
{
	idd=-6;
	movingenable=false;
	onLoad = "[(_this select 0)] execVM ""GUI\MissionInfoBoxes.sqf""";
	colorActive[] = {0,0,0,0.7};
	class controls 
	{
		class RscFrame_1801: Background
		{//background
			idc = 1801;
			x = 0.5 * GUI_GRID_W + GUI_GRID_X;
			y = 0.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 39 * GUI_GRID_W;
			h = 11.5 * GUI_GRID_H;
		};
		class RscText_1000: MissionText
		{
			idc = 1000;
			text = "Job Name";
			x = 1.5 * GUI_GRID_W + GUI_GRID_X;
			y = 1 * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1001: MissionText
		{
			idc = 1001;
			text = "Contact Progress";
			x = 1.5 * GUI_GRID_W + GUI_GRID_X;
			y = 2.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1003: MissionText
		{
			idc = 1003;
			text = "Job Type";
			x = 1.5 * GUI_GRID_W + GUI_GRID_X;
			y = 4 * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1002: MissionText
		{
			idc = 1002;
			text = "Difficulty";
			x = 1.5 * GUI_GRID_W + GUI_GRID_X;
			y = 5.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1010: MissionText
		{
			idc = 1010;
			text = "Location";
			x = 1.5 * GUI_GRID_W + GUI_GRID_X;
			y = 7 * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1004: MissionText
		{
			idc = 1004;
			text = "Description";
			x = 1.5 * GUI_GRID_W + GUI_GRID_X;
			y = 8.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1009: MissionText
		{
			idc = 1009;
			text = "Team Leader";
			x = 20 * GUI_GRID_W + GUI_GRID_X;
			y = 1 * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1008: MissionText
		{
			idc = 1008;
			text = "Target";
			x = 20 * GUI_GRID_W + GUI_GRID_X;
			y = 2.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1011: MissionText
		{
			idc = 1011;
			text = "Target Type";
			x = 20 * GUI_GRID_W + GUI_GRID_X;
			y = 4 * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1005: MissionText
		{
			idc = 1005;
			text = "Leader Cash";
			x = 20 * GUI_GRID_W + GUI_GRID_X;
			y = 5.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1006: MissionText
		{
			idc = 1006;
			text = "Squad Cash";
			x = 20 * GUI_GRID_W + GUI_GRID_X;
			y = 7 * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1007: MissionText
		{
			idc = 1007;
			text = "Squad Pay Cap On";
			x = 20 * GUI_GRID_W + GUI_GRID_X;
			y = 8.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1026: MissionText
		{
			idc = 1026;
			x = 9.5 * GUI_GRID_W + GUI_GRID_X;
			y = 1 * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1027: MissionText
		{
			idc = 1027;
			x = 9.5 * GUI_GRID_W + GUI_GRID_X;
			y = 2.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1028: MissionText
		{
			idc = 1028;
			x = 9.5 * GUI_GRID_W + GUI_GRID_X;
			y = 4 * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1029: MissionText
		{
			idc = 1029;
			x = 9.5 * GUI_GRID_W + GUI_GRID_X;
			y = 5.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1030: MissionText
		{
			idc = 1030;
			x = 9.5 * GUI_GRID_W + GUI_GRID_X;
			y = 7 * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1031b: MissionText
		{
			idc = 10312;
			x = 6.5 * GUI_GRID_W + GUI_GRID_X;
			y = 8.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 13.5 * GUI_GRID_W;
			h = 3 * GUI_GRID_H;
		};
		class RscText_1031: MissionText
		{
			idc = 1031;
			style = 528;
			x = 6.5 * GUI_GRID_W + GUI_GRID_X;
			y = 8.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 13.5 * GUI_GRID_W;
			h = 3 * GUI_GRID_H;
		};
		class RscText_1032: MissionText
		{
			idc = 1032;
			x = 28 * GUI_GRID_W + GUI_GRID_X;
			y = 1 * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1033: MissionText
		{
			idc = 1033;
			x = 28 * GUI_GRID_W + GUI_GRID_X;
			y = 2.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1037: MissionText
		{
			idc = 1037;
			x = 28 * GUI_GRID_W + GUI_GRID_X;
			y = 4 * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1034: MissionText
		{
			idc = 1034;
			x = 28 * GUI_GRID_W + GUI_GRID_X;
			y = 5.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1035: MissionText
		{
			idc = 1035;
			x = 28 * GUI_GRID_W + GUI_GRID_X;
			y = 7 * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1036: MissionText
		{
			idc = 1036;
			x = 28 * GUI_GRID_W + GUI_GRID_X;
			y = 8.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscButton_1600: MissionButton
		{
			idc = 1600;
			text = "Accept Job 1";
			x = 22 * GUI_GRID_W + GUI_GRID_X;
			y = 10.1 * GUI_GRID_H + GUI_GRID_Y;
			w = 14.5 * GUI_GRID_W;
			h = 0.7 * GUI_GRID_H;
			action = "[GUITargetObject,0] execVM ""GUI\LoadMission.sqf""";
		};
		class RscButton_1690: MissionButton
		{
			idc = 1690;
			text = "Decline Both Jobs";
			x = 22 * GUI_GRID_W + GUI_GRID_X;
			y = 10.9 * GUI_GRID_H + GUI_GRID_Y;
			w = 14.5 * GUI_GRID_W;
			h = 0.7 * GUI_GRID_H;
			action = "closeDialog 0;";
		};
		class RscFrame_1800: Background
		{//background
			idc = 1801;
			x = 0.5 * GUI_GRID_W + GUI_GRID_X;
			y = 13 * GUI_GRID_H + GUI_GRID_Y;
			w = 39 * GUI_GRID_W;
			h = 11.5 * GUI_GRID_H;
		};
		class RscText_1014: MissionText
		{
			idc = 1014;
			text = "Job Name";
			x = 1.5 * GUI_GRID_W + GUI_GRID_X;
			y = 13.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1015: MissionText
		{
			idc = 1015;
			text = "Contact Progress";
			x = 1.5 * GUI_GRID_W + GUI_GRID_X;
			y = 15 * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1016: MissionText
		{
			idc = 1016;
			text = "Job Type";
			x = 1.5 * GUI_GRID_W + GUI_GRID_X;
			y = 16.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1017: MissionText
		{
			idc = 1017;
			text = "Difficulty";
			x = 1.5 * GUI_GRID_W + GUI_GRID_X;
			y = 18 * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1018: MissionText
		{
			idc = 1018;
			text = "Location";
			x = 1.5 * GUI_GRID_W + GUI_GRID_X;
			y = 19.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1019: MissionText
		{
			idc = 1019;
			text = "Description";
			x = 1.5 * GUI_GRID_W + GUI_GRID_X;
			y = 21 * GUI_GRID_H + GUI_GRID_Y;
			w = 5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1022: MissionText
		{
			idc = 1022;
			text = "Team Leader";
			x = 20 * GUI_GRID_W + GUI_GRID_X;
			y = 13.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1020: MissionText
		{
			idc = 1020;
			text = "Target";
			x = 20 * GUI_GRID_W + GUI_GRID_X;
			y = 15 * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1021: MissionText
		{
			idc = 1021;
			text = "Target Type";
			x = 20 * GUI_GRID_W + GUI_GRID_X;
			y = 16.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1023: MissionText
		{
			idc = 1023;
			text = "Leader Cash";
			x = 20 * GUI_GRID_W + GUI_GRID_X;
			y = 18 * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1024: MissionText
		{
			idc = 1024;
			text = "Squad Cash";
			x = 20 * GUI_GRID_W + GUI_GRID_X;
			y = 19.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1025: MissionText
		{
			idc = 1025;
			text = "Squad Pay Cap On";
			x = 20 * GUI_GRID_W + GUI_GRID_X;
			y = 21 * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1038: MissionText
		{
			idc = 1038;
			x = 9.5 * GUI_GRID_W + GUI_GRID_X;
			y = 13.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1039: MissionText
		{
			idc = 1039;
			x = 9.5 * GUI_GRID_W + GUI_GRID_X;
			y = 15 * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1040: MissionText
		{
			idc = 1040;
			x = 9.5 * GUI_GRID_W + GUI_GRID_X;
			y = 16.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1041: MissionText
		{
			idc = 1041;
			x = 9.5 * GUI_GRID_W + GUI_GRID_X;
			y = 18 * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1042: MissionText
		{
			idc = 1042;
			x = 9.5 * GUI_GRID_W + GUI_GRID_X;
			y = 19.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1043b: MissionText
		{
			idc = 10432;
			colorBackground[] = {0,0,0,0};
			x = 6.5 * GUI_GRID_W + GUI_GRID_X;
			y = 21 * GUI_GRID_H + GUI_GRID_Y;
			w = 13.5 * GUI_GRID_W;
			h = 3 * GUI_GRID_H;
		};
		class RscText_1043: MissionText
		{
			idc = 1043;
			style = 528;
			x = 6.5 * GUI_GRID_W + GUI_GRID_X;
			y = 21 * GUI_GRID_H + GUI_GRID_Y;
			w = 13.5 * GUI_GRID_W;
			h = 3 * GUI_GRID_H;
		};
		class RscText_1044: MissionText
		{
			idc = 1044;
			x = 28 * GUI_GRID_W + GUI_GRID_X;
			y = 13.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1045: MissionText
		{
			idc = 1045;
			x = 28 * GUI_GRID_W + GUI_GRID_X;
			y = 15 * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1046: MissionText
		{
			idc = 1046;
			x = 28 * GUI_GRID_W + GUI_GRID_X;
			y = 16.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1047: MissionText
		{
			idc = 1047;
			x = 28 * GUI_GRID_W + GUI_GRID_X;
			y = 18 * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1048: MissionText
		{
			idc = 1048;
			x = 28 * GUI_GRID_W + GUI_GRID_X;
			y = 19.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1049: MissionText
		{
			idc = 1049;
			x = 28 * GUI_GRID_W + GUI_GRID_X;
			y = 21 * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			
		};
		class RscButton_1601: MissionButton
		{
			idc = 1601;
			text = "Accept Job 2";
			x = 22 * GUI_GRID_W + GUI_GRID_X;
			y = 22.6 * GUI_GRID_H + GUI_GRID_Y;
			w = 14.5 * GUI_GRID_W;
			h = 0.7 * GUI_GRID_H;
			action = "[GUITargetObject,1] execVM ""GUI\LoadMission.sqf""";
		};
		class RscButton_1691: MissionButton
		{
			idc = 1691;
			text = "Decline Both Jobs";
			x = 22 * GUI_GRID_W + GUI_GRID_X;
			y = 23.4 * GUI_GRID_H + GUI_GRID_Y;
			w = 14.5 * GUI_GRID_W;
			h = 0.7 * GUI_GRID_H;
			action = "closeDialog 0;";
		};
	};
};

////////////////////////////////////////////////////////////////////////////////////////////////////////

class HG_OneMission
{
	idd=-7;
	movingenable=false;
	onLoad = "[(_this select 0)] execVM ""GUI\MissionInfoBoxes.sqf""";
	colorActive[] = {0,0,0,0.7};
	class controls 
	{
		class RscFrame_1801: Background
		{//background
			idc = 1801;
			x = 0.5 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 0.5) * GUI_GRID_H + GUI_GRID_Y;
			w = 39 * GUI_GRID_W;
			h = 11.5 * GUI_GRID_H;
		};
		class RscText_1000: MissionText
		{
			idc = 1000;
			text = "Job Name";
			x = 1.5 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 1) * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1001: MissionText
		{
			idc = 1001;
			text = "Contact Progress";
			x = 1.5 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 2.5) * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1003: MissionText
		{
			idc = 1003;
			text = "Job Type";
			x = 1.5 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 4) * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1002: MissionText
		{
			idc = 1002;
			text = "Difficulty";
			x = 1.5 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 5.5) * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1010: MissionText
		{
			idc = 1010;
			text = "Location";
			x = 1.5 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 7) * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1004: MissionText
		{
			idc = 1004;
			text = "Description";
			x = 1.5 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 8.5) * GUI_GRID_H + GUI_GRID_Y;
			w = 5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1009: MissionText
		{
			idc = 1009;
			text = "Team Leader";
			x = 20 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 1) * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1008: MissionText
		{
			idc = 1008;
			text = "Target";
			x = 20 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 2.5) * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1011: MissionText
		{
			idc = 1011;
			text = "Target Type";
			x = 20 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 4) * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1005: MissionText
		{
			idc = 1005;
			text = "Leader Cash";
			x = 20 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 5.5) * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1006: MissionText
		{
			idc = 1006;
			text = "Squad Cash";
			x = 20 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 7) * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1007: MissionText
		{
			idc = 1007;
			text = "Squad Pay Cap On";
			x = 20 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 8.5) * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1026: MissionText
		{
			idc = 1026;
			x = 9.5 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 1) * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1027: MissionText
		{
			idc = 1027;
			x = 9.5 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 2.5) * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1028: MissionText
		{
			idc = 1028;
			x = 9.5 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 4) * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1029: MissionText
		{
			idc = 1029;
			x = 9.5 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 5.5) * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1030: MissionText
		{
			idc = 1030;
			x = 9.5 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 7) * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1031b: MissionText
		{
			idc = 10312;
			x = 6.5 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 8.5) * GUI_GRID_H + GUI_GRID_Y;
			w = 13.5 * GUI_GRID_W;
			h = 3 * GUI_GRID_H;
		};
		class RscText_1031: MissionText
		{
			idc = 1031;
			style = 528;
			x = 6.5 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 8.5) * GUI_GRID_H + GUI_GRID_Y;
			w = 13.5 * GUI_GRID_W;
			h = 3 * GUI_GRID_H;
		};
		class RscText_1032: MissionText
		{
			idc = 1032;
			x = 28 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 1) * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1033: MissionText
		{
			idc = 1033;
			x = 28 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 2.5) * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1037: MissionText
		{
			idc = 1037;
			x = 28 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 4) * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1034: MissionText
		{
			idc = 1034;
			x = 28 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 5.5) * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1035: MissionText
		{
			idc = 1035;
			x = 28 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 7) * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1036: MissionText
		{
			idc = 1036;
			x = 28 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 8.5) * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscButton_1600: MissionButton
		{
			idc = 1600;
			text = "Accept Job";
			x = 22 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 10.1) * GUI_GRID_H + GUI_GRID_Y;
			w = 14.5 * GUI_GRID_W;
			h = 0.7 * GUI_GRID_H;
			action = "[GUITargetObject,0] execVM ""GUI\LoadMission.sqf""";
		};
		class RscButton_1680: MissionButton
		{
			idc = 1600;
			text = "Decline Job";
			x = 22 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 10.9) * GUI_GRID_H + GUI_GRID_Y;
			w = 14.5 * GUI_GRID_W;
			h = 0.7 * GUI_GRID_H;
			action = "closeDialog 0;";
		};
	};
};

//--- Dialogs.
class HG_MoneyListGUI {
	movingEnable = 1;
	idd = 10001;
	onLoad = "_this execVM 'MoneyList.sqf'"; 
	class controlsBackground {
		class Mainback : MissionText {
			x = 6 * GUI_GRID_W + GUI_GRID_X;
			y = 8 * GUI_GRID_H + GUI_GRID_Y;
			w = 28 * GUI_GRID_W;
			h = 11 * GUI_GRID_H;
			moving = 1;
		};
	};
	class controls {
		class MoneyListTitle: MissionText
		{
			idc = 423;
			text = "Top Money Earners";
			x = 6.5 * GUI_GRID_W + GUI_GRID_X;
			y = 8.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 27 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
		};
		class listboxA : MoneyListBox {
			idc = 10002;
			x = 7 * GUI_GRID_W + GUI_GRID_X;
			y = 11 * GUI_GRID_H + GUI_GRID_Y;
			w = 26 * GUI_GRID_W;
			h = 5.5 * GUI_GRID_H;
			
			
			access = 0; // Control access (0 - ReadAndWrite, 1 - ReadAndCreate, 2 - ReadOnly, 3 - ReadOnlyVerified)

			colorBackground[] = {0.2,0.2,0.2,1}; // Fill color
			colorSelectBackground[] = {1,0.5,0,1}; // Selected item fill color
			colorSelectBackground2[] = {0,0,0,1}; // Selected item fill color (oscillates between this and colorSelectBackground)

			SizeEx = 0.035;
			
			colorText[] = {1,1,1,1}; // Text and frame color
			colorDisabled[] = {1,1,1,0.5}; // Disabled text color
			colorSelect[] = {1,1,1,1}; // Text selection color
			colorSelect2[] = {1,1,1,1}; // Text selection color (oscillates between this and colorSelect)
			colorShadow[] = {0,0,0,0.5}; // Text shadow color (used only when shadow is 1)

			pictureColor[] = {1,0.5,0,1}; // Picture color
			pictureColorSelect[] = {1,1,1,1}; // Selected picture color
			pictureColorDisabled[] = {1,1,1,0.5}; // Disabled picture color

			tooltip = "Click to View Steam Profile"; // Tooltip text
			tooltipColorShade[] = {0,0,0,1}; // Tooltip background color
			tooltipColorText[] = {1,1,1,1}; // Tooltip text color
			tooltipColorBox[] = {1,1,1,1}; // Tooltip frame color

			period = 3; // Oscillation time between colorSelect/colorSelectBackground2 and colorSelect2/colorSelectBackground when selected

			rowHeight = 1.2 * GUI_GRID_CENTER_H; // Row height
			itemSpacing = 0; // Height of empty space between items
			maxHistoryDelay = 1; // Time since last keyboard type search to reset it
			canDrag = 0; // 1 (true) to allow item dragging

			soundSelect[] = {"\A3\ui_f\data\sound\RscListbox\soundSelect",0.09,1}; // Sound played when an item is selected

			// Scrollbar configuration (applied only when LB_TEXTURES style is used)
			class ListScrollBar
			{
				width = 0; // Unknown?
				height = 0; // Unknown?
				scrollSpeed = 0.01; // Unknown?

				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa"; // Arrow
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa"; // Arrow when clicked on
				border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa"; // Slider background (stretched vertically)
				thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa"; // Dragging element (stretched vertically)

				color[] = {1,1,1,1}; // Scrollbar color
			};
		};
		class SteamProfile
		{
			access = 0; // Control access (0 - ReadAndWrite, 1 - ReadAndCreate, 2 - ReadOnly, 3 - ReadOnlyVerified)
			idc = 1668; // Control identification (without it, the control won't be displayed)
			type = CT_HTML; // Type
			style = 82;
			SizeEx = 0.03;
			default = 0; // Control selected by default (only one within a display can be used)
			blinkingPeriod = 0; // Time in which control will fade out and back in. Use 0 to disable the effect.
			x = 6.5 * GUI_GRID_W + GUI_GRID_X;
			y = 17 * GUI_GRID_H + GUI_GRID_Y;
			w = 27 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			
			colorText[] = {1,1,1,0.95}; // Text color
			colorBold[] = {1,1,1,0.95}; // <b> text color
			colorLink[] = {1,1,1,0.95}; // <a> text color
			colorLinkActive[] = {1,0.5,0,1}; // Active <a> text color
			colorPicture[] = {1,1,1,1}; // Picture color
			colorPictureBorder[] = {0,0,0,0}; // Picture border color
			colorPictureLink[] = {1,1,1,1}; // <a> picture color
			colorPictureSelected[] = {1,1,1,1}; // Active <a> picture color
			colorDisabled[] = {0,0,0,0};
			colorBackground[] = {1,1,1,0.2};
			colorBackgroundDisabled[] = {1,1,1,0.2};
			colorBackgroundActive[] = {1,1,1,0.35};
			colorFocused[] = {0,0,0,0};
			colorShadow[] = {0,0,0,0};
			colorBorder[] = {0,0,0,0};

			prevPage = "\A3\ui_f\data\gui\rsccommon\rschtml\arrow_left_ca.paa"; // Pagination arrow for previous page
			nextPage = "\A3\ui_f\data\gui\rsccommon\rschtml\arrow_right_ca.paa"; // Pagination arrow for next page

			tooltip = "Search steam profiles"; // Tooltip text
			
			filename = "html\SteamProfile.html";
			class P // Paragraph style
			{
				font = "PuristaBold"; // Font from CfgFontFamilies
				fontBold = "PuristaBold"; // Vold font from CfgFontFamilies
				SizeEx = 0.045; // Text size
				align = "center"; // Text align (can be "left", "center" or "right")
			};
			class H1:P{}; // Header 1 style (uses same attributes as P)
			class H2:P{}; // Header 2 style (uses same attributes as P)
			class H3:P{}; // Header 3 style (uses same attributes as P)
			class H4:P{}; // Header 4 style (uses same attributes as P)
			class H5:P{}; // Header 5 style (uses same attributes as P)
			class H6:P{}; // Header 6 style (uses same attributes as P)
		};
		class RscButton_1600: MissionButton
		{
			idc = 1600;
			text = "Close";
			x = 13 * GUI_GRID_W + GUI_GRID_X;
			y = 19 * GUI_GRID_H + GUI_GRID_Y;
			w = 14 * GUI_GRID_W;
			h = 3 * GUI_GRID_H;
			action = "closeDialog 0;";
		};
	};
};

/////////////////////////////////////////////////

class HG_MissionInProgress
{
	idd=-8;
	movingenable=false;
	onLoad = "[(_this select 0)] execVM ""GUI\MissionInfoBoxes.sqf""";
	colorActive[] = {0,0,0,0.7};
	class controls 
	{
		class RscFrame_1801: Background
		{//background
			idc = 1801;
			x = 0.5 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 0.5) * GUI_GRID_H + GUI_GRID_Y;
			w = 39 * GUI_GRID_W;
			h = 11.5 * GUI_GRID_H;
		};
		class RscText_1000: MissionText
		{
			idc = 1000;
			text = "Job Name";
			x = 1.5 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 1) * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1001: MissionText
		{
			idc = 1001;
			text = "Contact Progress";
			x = 1.5 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 2.5) * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1003: MissionText
		{
			idc = 1003;
			text = "Job Type";
			x = 1.5 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 4) * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1002: MissionText
		{
			idc = 1002;
			text = "Difficulty";
			x = 1.5 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 5.5) * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1010: MissionText
		{
			idc = 1010;
			text = "Location";
			x = 1.5 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 7) * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1004: MissionText
		{
			idc = 1004;
			text = "Description";
			x = 1.5 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 8.5) * GUI_GRID_H + GUI_GRID_Y;
			w = 5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1009: MissionText
		{
			idc = 1009;
			text = "Team Leader";
			x = 20 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 1) * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1008: MissionText
		{
			idc = 1008;
			text = "Target";
			x = 20 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 2.5) * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1011: MissionText
		{
			idc = 1011;
			text = "Target Type";
			x = 20 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 4) * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1005: MissionText
		{
			idc = 1005;
			text = "Leader Cash";
			x = 20 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 5.5) * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1006: MissionText
		{
			idc = 1006;
			text = "Squad Cash";
			x = 20 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 7) * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1007: MissionText
		{
			idc = 1007;
			text = "Squad Pay Cap On";
			x = 20 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 8.5) * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1026: MissionText
		{
			idc = 1026;
			x = 9.5 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 1) * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1027: MissionText
		{
			idc = 1027;
			x = 9.5 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 2.5) * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1028: MissionText
		{
			idc = 1028;
			x = 9.5 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 4) * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1029: MissionText
		{
			idc = 1029;
			x = 9.5 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 5.5) * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1030: MissionText
		{
			idc = 1030;
			x = 9.5 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 7) * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1031b: MissionText
		{
			idc = 10312;
			x = 6.5 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 8.5) * GUI_GRID_H + GUI_GRID_Y;
			w = 13.5 * GUI_GRID_W;
			h = 3 * GUI_GRID_H;
		};
		class RscText_1031: MissionText
		{
			idc = 1031;
			style = 528;
			x = 6.5 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 8.5) * GUI_GRID_H + GUI_GRID_Y;
			w = 13.5 * GUI_GRID_W;
			h = 3 * GUI_GRID_H;
		};
		class RscText_1032: MissionText
		{
			idc = 1032;
			x = 28 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 1) * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1033: MissionText
		{
			idc = 1033;
			x = 28 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 2.5) * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1037: MissionText
		{
			idc = 1037;
			x = 28 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 4) * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1034: MissionText
		{
			idc = 1034;
			x = 28 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 5.5) * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1035: MissionText
		{
			idc = 1035;
			x = 28 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 7) * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1036: MissionText
		{
			idc = 1036;
			x = 28 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 8.5) * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscButton_1600: MissionButton
		{
			idc = 1600;
			text = "Close";
			x = 22 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 10.1) * GUI_GRID_H + GUI_GRID_Y;
			w = 14.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			action = "closeDialog 0;";
		};
	};
};

/////////////////////////////////////////////////

class HG_Intel
{
	idd=-9;
	movingenable=false;
	onLoad = "[(_this select 0)] execVM ""GUI\IntelGUI.sqf""";
	colorActive[] = {0,0,0,0.7};
	class controls 
	{
		class RscFrame_1801: Background
		{//background
			idc = 1801;
			x = 0.5 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 0.5) * GUI_GRID_H + GUI_GRID_Y;
			w = 39 * GUI_GRID_W;
			h = 11.5 * GUI_GRID_H;
		};
		class RscText_1000: MissionText
		{
			idc = 1000;
			text = "Contact Type";
			x = 1.5 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 1) * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1001: MissionText
		{
			idc = 1001;
			text = "Name";
			x = 1.5 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 2.5) * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1003: MissionText
		{
			idc = 1002;
			text = "Steam Name";
			x = 1.5 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 4) * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1002: MissionText
		{
			idc = 1003;
			text = "Leader Jobs";
			x = 1.5 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 5.5) * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1010: MissionText
		{
			idc = 1004;
			text = "Personal Jobs";
			x = 1.5 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 7) * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1004: MissionText
		{
			idc = 1005;
			text = "Money";
			x = 1.5 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 8.5) * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1009: MissionText
		{
			idc = 1006;
			text = "Enemies Killed";
			x = 20 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 1) * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1008: MissionText
		{
			idc = 1007;
			text = "Friendlies Killed";
			x = 20 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 2.5) * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1011: MissionText
		{
			idc = 1008;
			text = "Players Killed";
			x = 20 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 4) * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1005: MissionText
		{
			idc = 1009;
			text = "Suicides";
			x = 20 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 5.5) * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1006: MissionText
		{
			idc = 1010;
			text = "Civilians Killed";
			x = 20 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 7) * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1007: MissionText
		{
			idc = 1011;
			text = "Animals Killed";
			x = 20 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 8.5) * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1104: MissionText
		{
			idc = 1012;
			text = "Cars Destroyed";
			x = 1.5 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 10) * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1107: MissionText
		{
			idc = 1013;
			text = "Planes Destroyed";
			x = 20 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 10) * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1026: MissionText
		{
			idc = 3000;
			x = 9.5 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 1) * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1027: MissionText
		{
			idc = 3001;
			x = 9.5 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 2.5) * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1028: MissionText
		{
			idc = 3002;
			x = 9.5 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 4) * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1029: MissionText
		{
			idc = 3003;
			x = 9.5 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 5.5) * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1030: MissionText
		{
			idc = 3004;
			x = 9.5 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 7) * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1031: MissionText
		{
			idc = 3005;
			//style = 528;
			x = 9.5 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 8.5) * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1032: MissionText
		{
			idc = 3006;
			x = 28 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 1) * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1033: MissionText
		{
			idc = 3007;
			x = 28 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 2.5) * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1037: MissionText
		{
			idc = 3008;
			x = 28 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 4) * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1034: MissionText
		{
			idc = 3009;
			x = 28 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 5.5) * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1035: MissionText
		{
			idc = 3010;
			x = 28 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 7) * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1036: MissionText
		{
			idc = 3011;
			x = 28 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 8.5) * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1131: MissionText
		{
			idc = 3012;
			//style = 528;
			x = 9.5 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 10) * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1136: MissionText
		{
			idc = 3013;
			x = 28 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 10) * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscButton_1600: MissionButton
		{
			idc = 1600;
			text = "Close";
			x = 13 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 12) * GUI_GRID_H + GUI_GRID_Y;
			w = 14 * GUI_GRID_W;
			h = 3 * GUI_GRID_H;
			action = "closeDialog 0;";
		};
		class RscButton_1620: MissionButton
		{
			idc = 1600;
			text = "Donate T$10,000";
			x = 13 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 - 2.5) * GUI_GRID_H + GUI_GRID_Y;
			w = 14 * GUI_GRID_W;
			h = 3 * GUI_GRID_H;
			action = "[] call Donate";
		};
	};
};

/////////////////////////////////////////////////

class HG_JoinTeam
{
	movingEnable = 1;
	idd = 60001;
	onLoad = "((_this select 0) displayCtrl 1403) ctrlSetText format[""Join %1's team?"",(name GUITargetObject)];";
	//(_control displayCtrl 1403) ctrlSetText format[""Join %1''s team?"",(name GUITargetObject)];//mission name
	class controls 
	{
		class Mainback : Background {
			x = 6 * GUI_GRID_W + GUI_GRID_X;
			y = 8.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 28 * GUI_GRID_W;
			h = 6.5 * GUI_GRID_H;
			moving = 1;
		};
		class RscText_1003: MissionText
		{
			idc = 1403;
			text = "Accept team invite?";
			x = 8 * GUI_GRID_W + GUI_GRID_X;
			y = 9.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 24 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscButton_1600: MissionButton
		{
			idc = 1400;
			text = "Join";
			x = 8 * GUI_GRID_W + GUI_GRID_X;
			y = 12 * GUI_GRID_H + GUI_GRID_Y;
			w = 6 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
			action = "GUITargetObject execVM ""GUI\JoinTeamGUIAccept.sqf""";
		};
		class RscButton_1601: MissionButton
		{
			idc = 1401;
			text = "Decline";
			x = 26 * GUI_GRID_W + GUI_GRID_X;
			y = 12 * GUI_GRID_H + GUI_GRID_Y;
			w = 6 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
			action = "[] call CloseGUI";
		};
	};
};

/////////////////////////////////////////////////

class HG_MapConditionsGUI
{
	idd=-9;
	movingenable=false;
	onLoad = "[(_this select 0)] execVM ""GUI\MapConditionsGUI.sqf""";
	colorActive[] = {0,0,0,0.7};
	class controls 
	{
		class RscFrame_1801: Background
		{//background
			idc = 1801;
			x = 0.5 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 0.5) * GUI_GRID_H + GUI_GRID_Y;
			w = 39 * GUI_GRID_W;
			h = 11.5 * GUI_GRID_H;
		};
		class RscText_1000: MissionText
		{
			idc = 1000;
			text = "Wind Azimuth";
			x = 1.5 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 1) * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1001: MissionText
		{
			idc = 1001;
			text = "Rain Strength";
			x = 1.5 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 2.5) * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1003: MissionText
		{
			idc = 1002;
			text = "Gusts";
			x = 1.5 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 4) * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1002: MissionText
		{
			idc = 1003;
			text = "Cloud Cover";
			x = 1.5 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 5.5) * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1010: MissionText
		{
			idc = 1004;
			text = "Fog Density";
			x = 1.5 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 7) * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1004: MissionText
		{
			idc = 1005;
			text = "Lunar Transition";
			x = 1.5 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 8.5) * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1009: MissionText
		{
			idc = 1006;
			text = "Wind Strength";
			x = 20 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 1) * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1008: MissionText
		{
			idc = 1007;
			text = "Lightning Potential";
			x = 20 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 2.5) * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1011: MissionText
		{
			idc = 1008;
			text = "Forcast Changes In";
			x = 20 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 4) * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1005: MissionText
		{
			idc = 1009;
			text = "Cloud Forcast";
			x = 20 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 5.5) * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1006: MissionText
		{
			idc = 1010;
			text = "Fog Forcast";
			x = 20 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 7) * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1007: MissionText
		{
			idc = 1011;
			text = "Sea Roughness";
			x = 20 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 8.5) * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1104: MissionText
		{
			idc = 1012;
			text = "Lunar Brighness";
			x = 1.5 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 10) * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1107: MissionText
		{
			idc = 1013;
			text = "Lunar Fullness";
			x = 20 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 10) * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1026: MissionText
		{
			idc = 3000;
			x = 9.5 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 1) * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1027: MissionText
		{
			idc = 3001;
			x = 9.5 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 2.5) * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1028: MissionText
		{
			idc = 3002;
			x = 9.5 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 4) * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1029: MissionText
		{
			idc = 3003;
			x = 9.5 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 5.5) * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1030: MissionText
		{
			idc = 3004;
			x = 9.5 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 7) * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1031: MissionText
		{
			idc = 3005;
			//style = 528;
			x = 9.5 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 8.5) * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1032: MissionText
		{
			idc = 3006;
			x = 28 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 1) * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1033: MissionText
		{
			idc = 3007;
			x = 28 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 2.5) * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1037: MissionText
		{
			idc = 3008;
			x = 28 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 4) * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1034: MissionText
		{
			idc = 3009;
			x = 28 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 5.5) * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1035: MissionText
		{
			idc = 3010;
			x = 28 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 7) * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1036: MissionText
		{
			idc = 3011;
			x = 28 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 8.5) * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1131: MissionText
		{
			idc = 3012;
			//style = 528;
			x = 9.5 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 10) * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1136: MissionText
		{
			idc = 3013;
			x = 28 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 10) * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscButton_1600: MissionButton
		{
			idc = 1600;
			text = "Close";
			x = 13 * GUI_GRID_W + GUI_GRID_X;
			y = (6.25 + 12) * GUI_GRID_H + GUI_GRID_Y;
			w = 14 * GUI_GRID_W;
			h = 3 * GUI_GRID_H;
			action = "closeDialog 0;";
		};
	};
};

/////////////////////////////////////////////////