//register functions
class CfgFunctions
{
	class Werthles
	{
		class Werthles_MultiplayerSaveLoad
		{
			//tag = "Werthles";
			// call the function upon mission start, after objects are initialized.
			file = "\Werthles_MSL\functions";
			class MSLpostInit
			{
				postInit = 1;
			};
			class MSLDelete{};
			class MSLLoad{};
			class MSLPrep{};
			class MSLSave{};
			class MSLDeleteServer{};
			class MSLLoadServer{};
			class MSLPrepServer{};
			class MSLSaveServer{};
			class MSLDeletePlayer{};
			class MSLLoadPlayer{};
			class MSLPrepPlayer{};
			class MSLSavePlayer{};
		};
	};
};