// ISIS allah
["killed",_this select 1] execVM "scripts\sound_allah.sqf";

waituntil {(alive player)};

if (debug_mode) then {
        _actDebug = player addAction ["Debug Console", "dlg_debug\activateDLG.sqf", [], 0,false, true, "", "true"];
};

_mrtvola = player;

waituntil {!(alive _mrtvola)};
sleep 120;
hidebody _mrtvola;
if (true) exitWith {};







