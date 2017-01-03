disableSerialization;
private ["_display", "_control", "_index", "_entry", "_endBal", "_items"];

_display = (uiNamespace getVariable "TFID_StoreDialog");
_control = _display displayCtrl 607;

_index = lbCurSel _control;
if (!isNil "_index" && {_index > -1}) then {
	_entry = TFID_Store select _index;
	_control = _display displayCtrl 608;
	lbClear _control;

	_items = _entry select 2;
    if (typeName _items != "ARRAY") then { _items = [_items]; };

    {
        _details = [_x] call TFID_fnc_VAS_fetchCfgDetails;
        _displayName = _details select 1;
        _picture = _details select 2;
        _control lbAdd _displayName;
        _control lbSetPicture [(lbSize _control)-1,(_picture)];
        _control lbSetData [(lbSize _control)-1,(_x)]; //Data for index is classname
    } forEach _items;

	_endBal = tft_dnd_points - (_entry select 1);

	_control = _display displayCtrl 641;
	_control ctrlsetText format ["%1", tft_dnd_points];

	_control = _display displayCtrl 642;
	_control ctrlsetText format ["%1", _entry select 1];

	_control = _display displayCtrl 643;
	_control ctrlsetText format ["%1", _endBal];
};
