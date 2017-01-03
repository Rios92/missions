/*
	This functin opens the confirmation dialog for warnings, etc.

	Parameter:
		0: String, text to go in the display field
*/
disableSerialization;
private ["_text", "_control"];
_text = _this select 0;
_action1 = _this select 1;
_action2 = _this select 2;
createDialog "TFID_ConfirmDialog";

_control = (findDisplay 1012) displayCtrl 503;
_control ctrlSetText format ["%1", _text];
_control = (findDisplay 1012) displayCtrl 504;
_control buttonSetAction _action1;
_control = (findDisplay 1012) displayCtrl 505;
_control buttonSetAction _action2;