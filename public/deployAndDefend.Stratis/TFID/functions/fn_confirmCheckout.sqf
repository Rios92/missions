params ["", "_cost", "_items"];

if (typeName _items == "ARRAY") then {
	[_items] spawn TFID_fnc_spawnStoreCrate;
} else {
	[_items] spawn TFID_fnc_addPlaceMenu;
};

[-_cost] call tft_dnd_fnc_addPoints;
[] call TFID_fnc_resetStore;
