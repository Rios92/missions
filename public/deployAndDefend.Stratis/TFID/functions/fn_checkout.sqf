disableSerialization;
private "_handle";
_handle = [] spawn {
	private ["_control", "_index", "_entry", "_endBal"];

	_control = (uiNamespace getVariable "TFID_StoreDialog") displayCtrl 607;

	_index = lbCurSel _control;
	if (isNil "_index" || {_index < 0}) exitWith { ["You have not selected a package!"] call TFID_fnc_openNotificationDialog; };

	_entry = TFID_Store select _index;
	if (count _entry == 0) exitWith { ["You have not selected a valid package!"] call TFID_fnc_openNotificationDialog; };

	
	_endBal = tft_dnd_points - (_entry select 1);

	if (_endBal < 0) then {
		["You do not have enough Points for this purchase!"] call TFID_fnc_openNotificationDialog;
	} else {
		["Are you sure you want to make this purchase?", format["closeDialog 1012; %1 call TFID_fnc_confirmCheckout;",_entry], "closeDialog 0;"] call TFID_fnc_openConfirmDialog;
	};
};
