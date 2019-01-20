//build modules
class CfgVehicles
{
	class Logic;
	class Module_F: Logic
	{
		class ArgumentsBaseUnits
		{
			class Units;
		};
		class ModuleDescription
		{
			class AnyBrain;
		};
	};
	
	class Werthles_moduleWHM: Module_F
	{
		author = "Werthles";
		// Standard object definitions
		scope = 2; // Editor visibility; 2 will show it in the menu, 1 will hide it.
		displayName = "WH Setup Module"; // Name displayed in the menu
		icon = "\Werthles_WHK\data\iconWHM_ca.paa"; // Map icon. Delete this entry to use the default icon
		category = "Werthles_Headless"; //Multiplayer

		// Name of function triggered once conditions are met
		function = "Werthles_fnc_moduleWHM";
		// Execution priority, modules with lower number are executed first. 0 is used when the attribute is undefined
		functionPriority = 1;
		// 0 for server only execution, 1 for remote execution on all clients upon mission start, 2 for persistent execution
		isGlobal = 2;
		// 1 for module waiting until all synced triggers are activated
		isTriggerActivated = 1;
		// 1 if modules is to be disabled once it's activated (i.e., repeated trigger activation won't work)
		isDisposable = 0;

		// Menu displayed when the module is placed or double-clicked on by Zeus
		//curatorInfoType = "RscDisplayAttributemoduleWHM";

		// Module arguments
		class Arguments: ArgumentsBaseUnits
		{
			// Arguments shared by specific module type (have to be mentioned in order to be placed on top)
			class Units: Units
			{
				displayName = "HCs to be used"; // Argument label
				description = "Synchronise HCs for WHM use. No syncs - all HC used. HCs MUST connect BEFORE loading to briefing/module activation!";
				defaultValue = -666;
			};
			class Repeating
  			{
				displayName = "Recurrent AI checks"; // Argument label
				description = "Repeated checks for non-HC controlled units, or a one time check"; // Tooltip description
				typeName = "BOOL"; // Value type, can be "NUMBER", "STRING" or "BOOL"
				defaultValue = true; // Default text filled in the input box
				// When no 'values' are defined, input box is displayed instead of listbox
			};
			class Wait
  			{
				displayName = "Time between repeats";
				description = "How often WHK should begin checks for non-HC controlled units";
				typeName = "NUMBER";
				defaultValue = 30;
			};
			class Debug
			{
				displayName = "Access to debug for all"; // Argument label
				description = "Allow everyone to view debug mode, or just admins"; // Tooltip description
				typeName = "BOOL"; // Value type, can be "NUMBER", "STRING" or "BOOL"
				defaultValue = false;
			};
			class Advanced
			{
				displayName = "Advanced balancing"; // Argument label
				description = "Advanced balances units on HCs, simple alternates HCs"; // Tooltip description
				typeName = "BOOL"; // Value type, can be "NUMBER", "STRING" or "BOOL"
				defaultValue = true;
			};
			class Delay
			{
				displayName = "Start delay";
				description = "Time (seconds) to wait before beginning checks";
				typeName = "NUMBER";
				defaultValue = 30;
			};
			class Pause
			{
				displayName = "Syncing pause";
				description = "Time (seconds) between each group being transferred to HC control; fast setup risks errors";
				typeName = "NUMBER";
				defaultValue = 3;
			};
			class Report
			{
				displayName = "Setup report"; // Argument label
				description = "Shows report after initial HC transfers"; // Tooltip description
				typeName = "BOOL"; // Value type, can be "NUMBER", "STRING" or "BOOL"
				defaultValue = true;
			};
			class Ignores
			{
				displayName = "Units to be ignored";
				description = "Any whole/part unit/group/synced-module name/type not for HCs. Separate with commas, e.g.: BRAVOSQUAD,man,B_Heli_,enemygroupnumber";
				typeName = "STRING";
				defaultValue = ""; // Default text filled in the input box
				// When no 'values' are defined, input box is displayed instead of listbox
			};
			class NoDebug
			{
				displayName = "Debug"; // Argument label
				description = "When disabled, players cannot gain access to debug!"; // Tooltip description
				typeName = "BOOL"; // Value type, can be "NUMBER", "STRING" or "BOOL"
				defaultValue = true;
			};
			class DebugOnly
			{
				displayName = "Debug only"; // Argument label
				description = "Only the WHM debug locality counts will be functional"; // Tooltip description
				typeName = "BOOL"; // Value type, can be "NUMBER", "STRING" or "BOOL"
				defaultValue = false;
			};
			class UseServer
			{
				displayName = "Put AI on server"; // Argument label
				description = "Splits AI among the server as well as HCs"; // Tooltip description
				typeName = "BOOL"; // Value type, can be "NUMBER", "STRING" or "BOOL"
				defaultValue = false;
			};
		};

		// Module description. Must inherit from base class, otherwise pre-defined entities won't be available
		class ModuleDescription: ModuleDescription
		{
			description = "This module allows headless clients to automatically control AI, according to the setup parameters."; // Short description, will be formatted as structured text
			sync[] = {"HeadlessClient_F","HeadlessClient_F","HeadlessClient_F","HeadlessClient_F","HeadlessClient_F"}; // Array of synced entities (can contain base classes)
			duplicate = 0; // Multiple entities of this type can be synced
			class HeadlessClient_F
			{
				description[] = { // Multi-line descriptions are supported
					"Headless Client (HC)",
					"HCs must be set as playable.",
					"HCs must be given a unique name."
				};
				position = 0; // Position is taken into effect
				direction = 0; // Direction is taken into effect
				optional = 1; // Synced entity is optional
				duplicate = 1; // Multiple entities of this type can be synced
			};
		};
	};
	
	class Werthles_moduleWHIgnore: Module_F
	{
		author = "Werthles";
		// Standard object definitions
		scope = 2; // Editor visibility; 2 will show it in the menu, 1 will hide it.
		displayName = "WH Ignore Module"; // Name displayed in the menu
		icon = "\Werthles_WHK\data\iconWHIgnore_ca.paa"; // Map icon. Delete this entry to use the default icon
		category = "Werthles_Headless";
		// 1 for module waiting until all synced triggers are activated
		isTriggerActivated = 0;

		// Menu displayed when the module is placed or double-clicked on by Zeus
		//curatorInfoType = "RscDisplayAttributemoduleWHIgnore";

		// Module arguments
		class Arguments: ArgumentsBaseUnits
		{
			// Arguments shared by specific module type (have to be mentioned in order to be placed on top)
			class Units: Units
			{
				displayName = "Units to be ignored"; // Argument label
				description = "";
				defaultValue = -666;
			};
		};

		// Module description. Must inherit from base class, otherwise pre-defined entities won't be available
		class ModuleDescription: ModuleDescription
		{
			description = "Synchronise units to this to keep them controlled by the server.<br/>Can be used instead of or in addition to the ignore list in the WH Setup Module.<br/>Sometimes useful when custom scripts affect units.<br/>Any unit and attached group synced to the module will not be controlled by the headless client."; // Short description, will be formatted as structured text
			sync[] = {"IgnoredUnitsA","IgnoredUnitsB","IgnoredUnitsC","IgnoredUnitsD"}; // Array of synced entities (can contain base classes)
			displayName = "WH Ignore Module"; // Custom name
			icon = "\Werthles_WHK\data\iconWHIgnore_ca.paa"; // Custom icon (can be file path or CfgVehicleIcons entry)
			position = 0; // Position is taken into effect
			direction = 0; // Direction is taken into effect
			optional = 1; // Synced entity is optional
			duplicate = 1; // Multiple entities of this type can be synced

			class IgnoredUnitsA
			{
				description = "Any unit not to be controlled by headless clients.<br/>All units in its group will remain controlled by the server.";
				displayName = "Any Unit"; // Custom name
				icon = "iconMan"; // Custom icon (can be file path or CfgVehicleIcons entry)
				position = 0; // Position is taken into effect
				direction = 0; // Direction is taken into effect
				optional = 0; // Synced entity is optional
				duplicate = 1; // Multiple entities of this type can be synced
				side = 1; // Custom side (will determine icon color)
			};
			class IgnoredUnitsB
			{
				description = "Any unit not to be controlled by headless clients.<br/>All units in its group will remain controlled by the server.";
				displayName = "Any Unit"; // Custom name
				icon = "iconMan"; // Custom icon (can be file path or CfgVehicleIcons entry)
				position = 0; // Position is taken into effect
				direction = 0; // Direction is taken into effect
				optional = 0; // Synced entity is optional
				duplicate = 1; // Multiple entities of this type can be synced
				side = 2; // Custom side (will determine icon color)
			};
			class IgnoredUnitsC
			{
				description = "Any unit not to be controlled by headless clients.<br/>All units in its group will remain controlled by the server.";
				displayName = "Any Unit"; // Custom name
				icon = "iconMan"; // Custom icon (can be file path or CfgVehicleIcons entry)
				position = 0; // Position is taken into effect
				direction = 0; // Direction is taken into effect
				optional = 0; // Synced entity is optional
				duplicate = 1; // Multiple entities of this type can be synced
				side = 3; // Custom side (will determine icon color)
			};
			class IgnoredUnitsD
			{
				description = "Any unit not to be controlled by headless clients.<br/>All units in its group will remain controlled by the server.";
				displayName = "Any Unit"; // Custom name
				icon = "iconMan"; // Custom icon (can be file path or CfgVehicleIcons entry)
				position = 0; // Position is taken into effect
				direction = 0; // Direction is taken into effect
				optional = 0; // Synced entity is optional
				duplicate = 1; // Multiple entities of this type can be synced
				side = 0; // Custom side (will determine icon color)
			};
		};
	};
};