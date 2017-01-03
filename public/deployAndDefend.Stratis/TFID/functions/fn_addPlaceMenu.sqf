private ["_className", "_details", "_i"];

_className = _this select 0;
_details = [_className, "CfgVehicles"] call TFID_fnc_VAS_fetchCfgDetails;

_i = player addAction [format ["<t color='#0080FF'>Place: %1</t>", _details select 1], {[_this select 3] call TFID_fnc_placeObject;}, _className, -5, false, true, "", "(_this == _target) && {!TFID_hideActions}"];
TFID_placeActions pushBack [_i, _className];
