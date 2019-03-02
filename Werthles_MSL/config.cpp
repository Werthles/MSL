#ifndef MSLPATCHES
#define MSLPATCHES 0
#include <functions\CfgPatches.hpp>
#endif
#ifndef MSLFACTION
#define MSLFACTION 0
#include <functions\CfgFactionClasses.hpp>
#endif
#ifndef MSLVEHICLES
#define MSLVEHICLES 0
#include <functions\CfgVehicles.hpp>
#endif
#ifndef MSLFUNCTIONS
#define MSLFUNCTIONS 0
#include <functions\CfgFunctions.hpp>
#endif
#ifndef MSLRemoteExec
#define MSLRemoteExec 0
#include <functions\CfgRemoteExec.hpp>
#endif

#ifndef MSLDEFINES
#define MSLDEFINES 0
#include "defines.hpp"
#endif

class MSLDialog
{
	idd=753;
	movingEnable=true;
	onLoad = "[(_this select 0)] spawn Werthles_fnc_MSLPrep";
	colorActive[] = {0,0.7,0.3,0.7};
	class controlsBackground {
		class Mainback : MSLMissionText {
			x = 1 * GUI_GRID_W + GUI_GRID_X;
			y = 1 * GUI_GRID_H + GUI_GRID_Y;
			w = 25 * GUI_GRID_W;
			h = 21 * GUI_GRID_H;
			moving = 1;
		};
	};
	class controls 
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by mwk22, v1.063, #Kojado)
		////////////////////////////////////////////////////////

		//class MSLDialogBackground: RscFrame
		//{
		//	idc = 1800;
		//	text = "Mission Save/Load"; //--- ToDo: Localize;
		//	x = 1 * GUI_GRID_W + GUI_GRID_X;
		//	y = 1 * GUI_GRID_H + GUI_GRID_Y;
		//	w = 17 * GUI_GRID_W;
		//	h = 18 * GUI_GRID_H;
		//	colorText[] = {1,1,1,1};
		//	colorBackground[] = {1,1,1,1};
		//	colorActive[] = {1,1,1,1};
		//	sizeEx = 2 * GUI_GRID_H;
		//};
		class MSLTitle: MSLRscText
		{
			idc = 7530;
			text = "Multiplayer Save/Load";
			x = 8 * GUI_GRID_W + GUI_GRID_X;
			y = 1.4 * GUI_GRID_H + GUI_GRID_Y;
			w = 11 * GUI_GRID_W;
			h = 1.8 * GUI_GRID_H;
		};
		class MSLMissionsListbox: MSLRscListbox
		{
			idc = 7531;
			text = "one,two,three"; //--- ToDo: Localize;
			x = 2 * GUI_GRID_W + GUI_GRID_X;
			y = 6 * GUI_GRID_H + GUI_GRID_Y;
			w = 23 * GUI_GRID_W;
			h = 11.5 * GUI_GRID_H;
			sizeEx = 1 * GUI_GRID_H;
		};
		class MSLSaveButton: MSLRscButton
		{
			idc = 7532;
			text = "Save"; //--- ToDo: Localize;
			x = 2 * GUI_GRID_W + GUI_GRID_X;
			y = 3.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 5 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
			sizeEx = 1 * GUI_GRID_H;
			action = "[] spawn Werthles_fnc_MSLSave";
		};
		class MSLLoadButton: MSLRscButton
		{
			idc = 7533;
			text = "Load"; //--- ToDo: Localize;
			x = 8 * GUI_GRID_W + GUI_GRID_X;
			y = 3.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 5 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
			sizeEx = 1 * GUI_GRID_H;
			action = "[] spawn Werthles_fnc_MSLLoad";
		};
		class MSLDeleteButton: MSLRscButton
		{
			idc = 7534;
			text = "Delete"; //--- ToDo: Localize;
			x = 14 * GUI_GRID_W + GUI_GRID_X;
			y = 3.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 5 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
			action = "[] spawn Werthles_fnc_MSLDelete";
		};
		class MSLCloseButton: MSLRscButton
		{
			idc = 7535;
			text = "Close"; //--- ToDo: Localize;
			x = 20 * GUI_GRID_W + GUI_GRID_X;
			y = 3.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 5 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
			sizeEx = 1 * GUI_GRID_H;
			action = "closeDialog 0;";
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by mwk22, v1.063, #Neheze)
		////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by mwk22, v1.063, #Tiqupo)
////////////////////////////////////////////////////////

class MSLNameText: MSLRscEdit
{
	idc = 7538;
	x = 2 * GUI_GRID_W + GUI_GRID_X;
	y = 18 * GUI_GRID_H + GUI_GRID_Y;
	w = 23 * GUI_GRID_W;
	h = 1 * GUI_GRID_H;
};
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////

		class MSLOptions: MSLRscCheckbox
		{
			idc = 7536;
			x = 2 * GUI_GRID_W + GUI_GRID_X;
			y = 19.25 * GUI_GRID_H + GUI_GRID_Y;
			w = 23 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			strings[] = {"No Hidden Map Objects","Server Triggers"};
			checked_strings[] = {"Hidden Map Objects","Global Triggers"};
    		columns = 2;
			rows = 1;
		};
		
		class MSLProgressBar: MSLRscProgress
		{
			idc = 7537;
			x = 2 * GUI_GRID_W + GUI_GRID_X;
			y = 20.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 23 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////

		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////

	};
};