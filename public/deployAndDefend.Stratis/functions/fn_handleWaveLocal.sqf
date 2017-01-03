disableSerialization;
(_this select 1) params ["_waveNum", "_timer"];

private _display = uiNamespace getVariable "TFID_ScoreDialog";
private _control = _display displayCtrl 1504;

(_display displayCtrl 1502) ctrlsetText format["%1/%2", _waveNum, "Waves" call BIS_fnc_getParamValue];
(_display displayCtrl 1506) ctrlsetText (str tft_dnd_points);

_timer = _timer - 1;
[_timer] spawn {
    disableSerialization;
    params ["_timer"];
    private _control = (uiNamespace getVariable "TFID_ScoreDialog") displayCtrl 1504;
    while {time < _timer} do {
        _control ctrlsetText ([_timer - time, "MM:SS"] call BIS_fnc_secondsToString);
        sleep 1;
    };
};

_control ctrlsetText "";
