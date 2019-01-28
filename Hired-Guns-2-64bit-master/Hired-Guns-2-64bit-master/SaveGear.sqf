//SaveGear.sqf
//Runs on player
//Called by player
//Called to get gear and send it to SaveGear event

//pvs
private ["_weaponsItemsCargo", "_itemCargo", "_magazineCargo", "_backpackCargo", "_playerUniform", "_playerVest", "_playerBackpack", "_playerWeaponsItems", "_playerUniformItems", "_playerVestItems", "_playerBackpackItems", "_playerMapItems", "_playerHelmet", "_playerGlasses", "_bag","_uid","_weps","_items","_mags","_backs","_good","_newWeaponsItemsCargo", "_newItemCargo", "_newMagazineCargo", "_newBackpackCargo","_y","_last","_count"];

if ((time - 60)>SaveGearTime) then
{
	SaveGearTime = time;

	//var init
	_weaponsItemsCargo = [];
	_itemCargo = [];
	_magazineCargo = [];
	_backpackCargo = [];

	//get player UID
	_uid = getPlayerUID player;

	//get player items
	_playerUniform = uniform player;
	_playerVest = vest player;
	_playerBackpack = backpack player;
	_playerWeaponsItems = weaponsItems player;
	_playerUniformItems = uniformItems player;
	_playerVestItems = vestItems player;
	_playerBackpackItems = backpackItems player;
	_playerMapItems = assignedItems player;
	_playerHelmet = headgear player;
	_playerGlasses = goggles player;

	//get crate contents
	//var init
	_weaponsItemsCargo = [];
	_itemCargo = [];
	_magazineCargo = [];
	_backpackCargo = [];
	
	{
	    _weps = [];
	    _items = [];
	    _mags = [];
	    _backs = [];
    	_newWeaponsItemsCargo = [];
    	_newItemCargo = [];
    	_newMagazineCargo = [];
    	_newBackpackCargo = [];
	    
		{
			_bag = _x select 1;
			_weps = _weps + (weaponsItemsCargo _bag);
			_items = _items + (itemCargo _bag);
			_mags = _mags + (magazineCargo _bag);
			_backs = _backs + (backpackCargo _bag);
		}forEach (everyContainer _x);
		
		_weps = _weps + (weaponsItemsCargo _x);
		_items = _items + (itemCargo _x);
		_mags = _mags + (magazineCargo _x);
		_backs = _backs + (backpackCargo _x);
		
		{
		    _y = _x;
		    _last = -1;
		    _count = 0;
		    {
		        if (_y isEqualTo _x) then
		        {
		            _last = _forEachIndex;
		            _count = _count + 1;
		        };
		    }forEach _weps;
		    if (_forEachIndex==_last) then
		    {
		        _newWeaponsItemsCargo append [[_x,_count]];
		    };
		}forEach _weps;
		{
		    _first = _items find _x;
		    if (_forEachIndex==_first) then
		    {
				_y = _x;
		        _newItemCargo append [[_x,{_y==_x} count _items]];
		    };
		}forEach _items;
		{
		    _first = _mags find _x;
		    if (_forEachIndex==_first) then
		    {
				_y = _x;
		        _newMagazineCargo append [[_x,{_y==_x} count _mags]];
		    };
		}forEach _mags;
		{
		    _first = _backs find _x;
		    if (_forEachIndex==_first) then
		    {
				_y = _x;
		        _newBackpackCargo append [[_x,{_y==_x} count _backs]];
		    };
		}forEach _backs;
		
		_weaponsItemsCargo = _weaponsItemsCargo + [_newWeaponsItemsCargo];
		_itemCargo = _itemCargo + [_newItemCargo];
		_magazineCargo = _magazineCargo + [_newMagazineCargo];
		_backpackCargo = _backpackCargo + [_newBackpackCargo];
	}forEach Boxes;
	
	//test
	/*
	_good = true;
	{
	    _weps = weaponsItemsCargo _x;
	    _items = getItemCargo _x;
	    _mags = magazineCargo _x;
	    _backs = backpackCargo _x;
	    if ((count (_weps select 0)>20) or (count (_items select 0)>20) or (count (_mags select 0)>20) or (count (_backs select 0)>20)) then
	    {
	        _good = false;
	        [69,getPos _x] call Messages;
	    }
	    else
	    {
    		_weaponsItemsCargo = _weaponsItemsCargo + [weaponsItemsCargo _x];
    		_itemCargo = _itemCargo + [itemCargo _x];
    		_magazineCargo = _magazineCargo + [magazineCargo _x];
    		_backpackCargo = _backpackCargo + [backpackCargo _x];
    		{
    			_bag = _x select 1;
    			_weaponsItemsCargo = _weaponsItemsCargo + [weaponsItemsCargo _bag];
    			_itemCargo = _itemCargo + [itemCargo _bag];
    			_magazineCargo = _magazineCargo + [magazineCargo _bag];
    			_backpackCargo = _backpackCargo + [backpackCargo _bag];
    		}forEach (everyContainer _x);
    	};
	}forEach Boxes;
    if (_good) then
    {
    */
    
	//combine gear data
	SaveGear = [[player,_uid],[_playerUniform,_playerVest,_playerBackpack,_playerWeaponsItems,_playerUniformItems,_playerVestItems,_playerBackpackItems,_playerMapItems,_playerHelmet,_playerGlasses],[_weaponsItemsCargo,_itemCargo,_magazineCargo,_backpackCargo]];

	//send server gear to save
	publicVariableServer "SaveGear";
}
else
{
	[68,nil] call Messages;
};