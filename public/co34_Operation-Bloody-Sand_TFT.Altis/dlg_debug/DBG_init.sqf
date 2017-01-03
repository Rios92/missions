//            DEBUG CONSOLE
//
// ---------- configuration ---------------
// #include "dlg_debug\dlg_debug.hpp"	//debug console >> description.ext
// _actDebug = player addAction ["Debug Console", "dlg_debug\activateDLG.sqf", [], 0,false, true, "", "true"];
//  profileNamespace setVariable ["FFS_DBG_v1", nil]; profileNamespace getVariable "FFS_DBG_v1"
// ----------------------------------------
// execution: createdialog "stra_debug";

if (_this == "load") then {
	{
		_tempVar=profileNamespace getVariable (_x select 0);
		if (isnil "_tempVar") then {ctrlsettext [_x select 1,""]; } else {ctrlsettext [_x select 1,profileNamespace getVariable (_x select 0)];};
		_tempVar=nil;
	} forEach [["FFS_DBG_v1",316011],["FFS_DBG_v2",316021],["FFS_DBG_v3",316031],["FFS_DBG_v4",316041],["FFS_DBG_c1",316101],["FFS_DBG_c2",316102],["FFS_DBG_c3",316103],["FFS_DBG_c4",316104],["FFS_DBG_c5",316105],["FFS_DBG_c6",316106],["FFS_DBG_c7",316107]];

	while {stra_debug_run} do {
		if (ctrltext 316011 != "") then {ctrlsettext [316012, format ["%1",call compile (ctrltext 316011)]];};
		if (ctrltext 316021 != "") then {ctrlsettext [316022, format ["%1",call compile (ctrltext 316021)]];};
		if (ctrltext 316031 != "") then {ctrlsettext [316032, format ["%1",call compile (ctrltext 316031)]];};
		if (ctrltext 316041 != "") then {ctrlsettext [316042, format ["%1",call compile (ctrltext 316041)]];};
		sleep 0.1;
	};
};
if (_this == "unload") then {
	profileNamespace setVariable ["FFS_DBG_v1", (ctrlText 316011)];
	profileNamespace setVariable ["FFS_DBG_v2", (ctrlText 316021)];
	profileNamespace setVariable ["FFS_DBG_v3", (ctrlText 316031)];
	profileNamespace setVariable ["FFS_DBG_v4", (ctrlText 316041)];
	
	profileNamespace setVariable ["FFS_DBG_c1", (ctrlText 316101)];
	profileNamespace setVariable ["FFS_DBG_c2", (ctrlText 316102)];
	profileNamespace setVariable ["FFS_DBG_c3", (ctrlText 316103)];
	profileNamespace setVariable ["FFS_DBG_c4", (ctrlText 316104)];
	profileNamespace setVariable ["FFS_DBG_c5", (ctrlText 316105)];
	profileNamespace setVariable ["FFS_DBG_c6", (ctrlText 316106)];
	profileNamespace setVariable ["FFS_DBG_c7", (ctrlText 316107)];
};