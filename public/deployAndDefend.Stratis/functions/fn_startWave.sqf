/*
 * Author: yourstruly
 * Handle N-th wave.
 *
 * Arguments:
 * 0: Max AI count <NUMBER>
 * 1: AI skill <NUMBER>
 * 2: Wave time coef (number of seconds for the first wave increased by number of waves) <NUMBER>
 * 3: Objective position <POSITION>
 * 4: Wave number <NUMBER>
 *
 * Return Value:
 * -
 *
 * Example:
 * [50, 0.5, 0.5, box call TFT_fnc_addActions;
 */
params ["_aiCountCoef", "_waveTimeCoef", "_waveNum"];

//finish old wave
if(_waveNum != 1) then {
    
    ["Wave", [_waveNum-1, "ended"]] remoteExec ["BIS_fnc_showNotification", -2];
    sleep 2;
    {
        if(_x getVariable ["tft_dnd_cleanWave", true]) then {
            [10*(_waveNum-1)] remoteExec ["tft_dnd_fnc_addPoints", _x];
            ["AddPoints", [10*(_waveNum-1), "Wave survived"]] remoteExec ["BIS_fnc_showNotification", _x];
        };
    } forEach allPlayers;
    sleep 10;
};

//start new wave
["Wave", [_waveNum, "started"]] remoteExec ["BIS_fnc_showNotification", -2];

private _maxEnemies = _waveNum * _aiCountCoef;
private _timer = time + 120 + _waveTimeCoef*_waveNum*120;
private _i = 0;
dndWave = [str _waveNum, _timer];
publicVariable "dndWave";

enemiesSpawned = [];

_it = 0;
while {time < _timer} do {
    enemiesSpawned = enemiesSpawned select {({alive _x} count units _x) > 0};
    if((_it == 0) && {count enemiesSpawned < _maxEnemies}) then {
        call (selectRandom [tft_dnd_fnc_spawnAirAssault, tft_dnd_fnc_spawnAirAssault, tft_dnd_fnc_spawnAirAssault,
                            tft_dnd_fnc_spawnAirDrop, tft_dnd_fnc_spawnAirDrop, tft_dnd_fnc_spawnAirDrop,
                            tft_dnd_fnc_spawnTruck, tft_dnd_fnc_spawnTruck, tft_dnd_fnc_spawnTechnical]);
        _it = 60 + (floor random 10)*_waveNum;
    };
    sleep 1;
    _it = (_it - 1) max 0;
};

waitUntil { count (enemiesSpawned select {({(alive _x) && {(_x distance2D objectivePos) < 200}} count units _x) > 0}) < 3 };

waveFinished = true;
