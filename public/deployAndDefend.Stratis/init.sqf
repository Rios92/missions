#define OBJECTIVES_NUMBER 15 //change only if added more defend markers

[missionNamespace, ["AR_Inv",3,3]]  call BIS_fnc_addRespawnInventory;
[missionNamespace, ["CLS_Inv",3,3]] call BIS_fnc_addRespawnInventory;
[missionNamespace, ["GRN_Inv",3,3]] call BIS_fnc_addRespawnInventory;
[missionNamespace, ["DMR_Inv",3,3]] call BIS_fnc_addRespawnInventory;
[missionNamespace, ["AT_Inv",3,3]]  call BIS_fnc_addRespawnInventory;

if (isServer) then {
    for "_i" from 1 to OBJECTIVES_NUMBER do {
        _mark = format["defend%1", _i];
        _mark setMarkerAlpha 0;
    };

    private _objNum = (floor random OBJECTIVES_NUMBER) + 1;
    objective = format["defend%1", _objNum];
    aiSpawns = [format["%1_ai1", objective], format["%1_ai2", objective], format["%1_ai3", objective]];

    spawnPos = getMarkerPos format["defend%1_spawn", _objNum];
    spawnPos set [2,0];
    publicVariable "spawnPos";

    objectivePos = getMarkerPos objective;
    objectivePos set [2,0];
    publicVariable "objectivePos";

    task_defend_module setPos objectivePos;
    helipads = nearestObjects [objectivePos, ["Land_HelipadEmpty_F"], 300];
    aiSkill = ("AISkill" call BIS_fnc_getParamValue)/10;
    
    objective setMarkerAlpha 75;
    "respawn_west" setMarkerPos spawnPos;
    
    objectiveSize = (getMarkerSize objective) select 0;
    publicVariable "objectiveSize";

    waitUntil {((getPos (allPlayers select 0)) distance2D objectivePos) < objectiveSize};
    
    oef = addMissionEventHandler ["EachFrame",{
        if(time % 10) then {
            {
                if(count units _x == 0) then {deleteGroup _x};
            } forEach allGroups;
        };
        if({!(_x getVariable ["BIS_revive_incapacitated", false]) && {alive _x} && {_x distance2D objectivePos <= objectiveSize}} count allPlayers == 0) then {
            removeMissionEventHandler ["onEachFrame", oef];
            [] spawn {
                ["task_defend", "FAILED", true] remoteExec ["BIS_fnc_taskSetState"];
                sleep 12;
                "everyonelost" call BIS_fnc_endMissionServer;
            };
        };
    }];

    [] spawn {
        for "_i" from 1 to ("Waves" call BIS_fnc_getParamValue) do {
            waveFinished = false;
            ["AICount" call BIS_fnc_getParamValue, "WaveTime" call BIS_fnc_getParamValue, _i] call tft_dnd_fnc_startWave;
            waitUntil {waveFinished};
        };
        
        ["task_defend", "SUCCEEDED", true] remoteExec ["BIS_fnc_taskSetState"];
        sleep 12;
        "everyonewon" call BIS_fnc_endMissionServer;
    };
} else {
    tft_dnd_points = 0;
    tft_dnd_timer = 0;
    TFID_hideActions = false;
    TFID_placeActions = [];
    TFID_Store = [ //Display name, cost, items/object
        ["Rifleman Ammo(8)", 10, ["30Rnd_65x39_caseless_mag_Tracer", "30Rnd_65x39_caseless_mag_Tracer", "30Rnd_65x39_caseless_mag_Tracer","30Rnd_65x39_caseless_mag_Tracer", "30Rnd_65x39_caseless_mag_Tracer", "30Rnd_65x39_caseless_mag_Tracer", "30Rnd_65x39_caseless_mag_Tracer", "30Rnd_65x39_caseless_mag_Tracer"]],
        ["Rifleman Ammo(4)", 5, ["30Rnd_65x39_caseless_mag_Tracer", "30Rnd_65x39_caseless_mag_Tracer", "30Rnd_65x39_caseless_mag_Tracer", "30Rnd_65x39_caseless_mag_Tracer"]],
        ["LMG Ammo(6)", 15, ["200Rnd_65x39_cased_Box_Tracer", "200Rnd_65x39_cased_Box_Tracer", "200Rnd_65x39_cased_Box_Tracer", "200Rnd_65x39_cased_Box_Tracer", "200Rnd_65x39_cased_Box_Tracer", "200Rnd_65x39_cased_Box_Tracer"]],
        ["LMG Ammo(3)", 10, ["200Rnd_65x39_cased_Box_Tracer", "200Rnd_65x39_cased_Box_Tracer", "200Rnd_65x39_cased_Box_Tracer"]],
        ["Marksman Ammo(8)", 10, ["20Rnd_762x51_Mag", "20Rnd_762x51_Mag", "20Rnd_762x51_Mag", "20Rnd_762x51_Mag", "20Rnd_762x51_Mag", "20Rnd_762x51_Mag", "20Rnd_762x51_Mag", "20Rnd_762x51_Mag"]],
        ["Marksman Ammo(4)", 5, ["20Rnd_762x51_Mag", "20Rnd_762x51_Mag", "20Rnd_762x51_Mag", "20Rnd_762x51_Mag"]],
        ["GL Rounds", 10, ["1Rnd_HE_Grenade_shell", "1Rnd_HE_Grenade_shell", "1Rnd_HE_Grenade_shell", "1Rnd_HE_Grenade_shell", "1Rnd_HE_Grenade_shell", "1Rnd_HE_Grenade_shell", "1Rnd_HE_Grenade_shell", "1Rnd_HE_Grenade_shell"]],
        ["Grenades", 10, ["HandGrenade", "HandGrenade", "HandGrenade", "HandGrenade", "HandGrenade"]],
        ["Medical Supplies", 10, ["FirstAidKit", "FirstAidKit", "FirstAidKit", "FirstAidKit","FirstAidKit", "FirstAidKit","FirstAidKit", "FirstAidKit","FirstAidKit", "FirstAidKit"]],
        ["ARCO Optic", 10, ["optic_Arco"]],
        ["RCO Optic", 10, ["optic_Hamr"]],
        ["Rangefinder", 10, ["Rangefinder"]],
        ["PCML Rockets", 10, ["NLAW_F", "NLAW_F", "NLAW_F"]],
        ["Mine Kit", 8, ["APERSTripMine_Wire_Mag", "APERSTripMine_Wire_Mag", "APERSMine_Range_Mag", "APERSMine_Range_Mag"]],
        ["Recon Kit", 15, ["B_UavTerminal", "B_UAV_01_backpack_F"]],
        ["Medic Kit", 10, ["Medikit"]],
        ["Static HMG", 50, "B_HMG_01_high_F"],
        ["Static GMG", 50, "B_GMG_01_high_F"],
        ["Mortar", 50, "B_Mortar_01_F"],
        ["Static Titan AA", 50, "B_static_AA_F"],
        ["Sand Bag Fence", 2, "Land_BagFence_Long_F"],
        ["H-Barrier Block", 5, "Land_HBarrier_1_F"],
        ["Sand Bag Bunker", 30, "Land_BagBunker_Small_F"],
        ["H-Barrier/Sand Bag Tower", 30, "Land_BagBunker_Tower_F"]
    ];

    waitUntil {!isNil "objectivePos" && !isNil "spawnPos"};
    sleep 1;

    player setPos spawnPos;
    
    isOutside = false;
    addMissionEventHandler ["EachFrame",{
        if((player distance2D objectivePos > objectiveSize) && {!isOutside}) then {
            isOutside = true;
            ["LeavingArea"] call BIS_fnc_showNotification;
        };
        if((player distance2D objectivePos < objectiveSize) && {isOutside}) then {
            isOutside = false;
            ["BackInArea"] call BIS_fnc_showNotification;
        };
    }];

    player addAction ["<t color='#FF8000'>Open Store</t>", {createDialog "StoreDialog";}];
    1000 cutRsc ["TFID_ScoreDialog","PLAIN"];
    "dndWave" addPublicVariableEventHandler { _this call tft_dnd_fnc_handleWaveLocal; };
    if(!isNil "dndWave") then { ["", dndWave] call tft_dnd_fnc_handleWaveLocal; };

    player addEventHandler ["Respawn", {
        _player = _this select 0;
        _player setVariable ["tft_dnd_cleanWave", true, true];
        _player addAction ["<t color='#FF8000'>Open Store</t>", {createDialog "StoreDialog";}];
        1000 cutRsc ["TFID_ScoreDialog","PLAIN"];
        ["", dndWave] call tft_dnd_fnc_handleWaveLocal;
    }];
    player addEventHandler ["Killed", {
        (_this select 0) setVariable ["tft_dnd_cleanWave", false, true];
    }];
};
