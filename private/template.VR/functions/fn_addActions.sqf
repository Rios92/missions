/*
 * Author: yourstruly
 * Add certain actions to an object.
 *
 * Arguments:
 * 0: Objects to add actions to <OBJECT>
 *
 * Return Value:
 * -
 *
 * Example:
 * box call TFT_fnc_addActions;
 */
_this addAction ["<t color='#89f3ff'>Arsenal</t>", {["Open",true] spawn BIS_fnc_arsenal}, nil, 51, true, true, "", "_target distance _this < 8"];
_this addAction ["<t color='#89f3ff'>Virtual Ammobox</t>", "VAS\open.sqf", nil, 50, true, true, "", "_target distance _this < 8"];
_this addAction ["<t color='#f0a4ff'>End preparation phase</t>", {TFT_prepPhase = false; publicVariable "TFT_prepPhase"; (_this select 0) removeAction (_this select 2)}, nil, -10, false, true, "", "_target distance _this < 8"];
_this addAction ["<t color='#f0a4ff'>BFT settings</t>", {createDialog "tft_bft_settings"}, nil, -16, false, true, "", "_this distance _target < 8"];
_this addAction ["<t color='#f0a4ff'>Change Callsign</t>", {createDialog "tft_callsign_settings"}, nil, -18, false, true, "", "_this distance _target < 8"];
_this addAction ["<t color='#83ffc6'>Spectate</t>", {[_this select 1, true] call TFT_fnc_spectate}, nil, -40, false, true, "", "_this distance _target < 10"];
