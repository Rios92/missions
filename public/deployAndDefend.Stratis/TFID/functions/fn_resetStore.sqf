disableSerialization;
private ["_display", "_control", "_entry", "_cost"];

_display = (uiNamespace getVariable "TFID_StoreDialog");

_control = _display displayCtrl 640;
_control ctrlsetText profileName;

_control = _display displayCtrl 607;
lbClear _control;

for "_i" from 0 to (count TFID_Store) do {
	_control lbAdd ((TFID_Store select _i) select 0);
};

if(lbCurSel _control >= 0) then {
    _entry = TFID_Store select (lbCurSel _control);
    _cost = if (count _entry > 0) then { _entry select 1 } else { 0 };
    
    _control = _display displayCtrl 641;
    _control ctrlsetText format ["%1", tft_dnd_points];

    _control = _display displayCtrl 642;
    _control ctrlsetText format ["%1", _cost];

    _control = _display displayCtrl 643;
    _control ctrlsetText format ["%1", tft_dnd_points-_cost];
};
