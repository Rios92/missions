/*
	This functin opens the notification dialog for warnings, etc.

	Parameter:
		0: String, text to go in the display field
*/
disableSerialization;
private ["_text", "_control"];
_text = _this select 0;

createDialog "TFID_NotificationDialog";

_control = (findDisplay 1011) displayCtrl 503;
_control ctrlSetText format ["%1", _text];