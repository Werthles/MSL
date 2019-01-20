// execute all scripts to non-player objects

// make sure the player is in-game and available
waitUntil {!isNull player};

// execute any scripts you want to the player

player addAction ["<t color='#FF5500'>Missions Save/Load</t>",{createdialog "MSLDialog";},[],-999,false,true,"isServer or serverCommandAvailable ""#kick"""];