params ["_className"];

TFID_hideActions = true;

TFID_placedObject = _className createVehicle [0,0,0];
TFID_placedObject allowDamage false;
TFID_placedObject attachTo [player, [0,4,1]];

TFID_actionConfirm = player addAction ["<t color='#01DF01'>Place Object</t>", {[_this select 3] call TFID_fnc_confirmPlace;}, _className];
TFID_actionCancel  = player addAction ["<t color='#FF0000'>Cancel Place</t>", {[_this select 3] call TFID_fnc_cancelPlace; }, player];

TFID_placeEH = player addEventHandler ["Killed", {_player call TFID_fnc_cancelPlace;}];
