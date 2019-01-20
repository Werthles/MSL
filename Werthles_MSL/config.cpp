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
	idd=-3;
	movingEnable=true;
	onLoad = "[(_this select 0)] spawn Werthles_fnc_MSLPrep";
	colorActive[] = {0,0.7,0.3,0.7};
	class controlsBackground {
		class Mainback : MissionText {
			x = 1 * GUI_GRID_W + GUI_GRID_X;
			y = 1 * GUI_GRID_H + GUI_GRID_Y;
			w = 17 * GUI_GRID_W;
			h = 18 * GUI_GRID_H;
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
		class MSLTitle: RscText
		{
			idc = 1006;
			text = "Mission Save/Load";
			x = 2 * GUI_GRID_W + GUI_GRID_X;
			y = 1.4 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 1.6 * GUI_GRID_H;
		};
		class MissionsListbox: RscListbox
		{
			idc = 1500;
			text = "one,two,three"; //--- ToDo: Localize;
			x = 2 * GUI_GRID_W + GUI_GRID_X;
			y = 6 * GUI_GRID_H + GUI_GRID_Y;
			w = 15 * GUI_GRID_W;
			h = 12 * GUI_GRID_H;
			sizeEx = 1 * GUI_GRID_H;
		};
		class SaveButton: RscButton
		{
			idc = 1600;
			text = "Save"; //--- ToDo: Localize;
			x = 2 * GUI_GRID_W + GUI_GRID_X;
			y = 3.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 3 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
			sizeEx = 1 * GUI_GRID_H;
			action = "[] spawn Werthles_fnc_MSLSave";
		};
		class LoadButton: RscButton
		{
			idc = 1601;
			text = "Load"; //--- ToDo: Localize;
			x = 6 * GUI_GRID_W + GUI_GRID_X;
			y = 3.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 3 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
			sizeEx = 1 * GUI_GRID_H;
			action = "[] spawn Werthles_fnc_MSLLoad";
		};
		class DeleteButton: RscButton
		{
			idc = 1602;
			text = "Delete"; //--- ToDo: Localize;
			x = 10 * GUI_GRID_W + GUI_GRID_X;
			y = 3.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 3 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
			action = "[] spawn Werthles_fnc_MSLDelete";
		};
		class CloseButton: RscButton
		{
			idc = 1603;
			text = "Close"; //--- ToDo: Localize;
			x = 14 * GUI_GRID_W + GUI_GRID_X;
			y = 3.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 3 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
			sizeEx = 1 * GUI_GRID_H;
			action = "closeDialog 0;";
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////

	};
};