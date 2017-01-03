[] execVM "eos\OpenMe.sqf";

if(isServer) then {
    ["Initialize"] call BIS_fnc_dynamicGroups;
} else {
    ["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;
};

sleep 3;
if(hasInterface && {player getUnitTrait "derp_pilot"}) then {
    hintC "Remember, you must be on TeamSpeak to be a pilot: TS3.TFT8.COM";
};

[west, "RM" ] call BIS_fnc_addRespawnInventory;
[west, "GRN" ] call BIS_fnc_addRespawnInventory;
[west, "AR" ] call BIS_fnc_addRespawnInventory;
[west, "MAT" ] call BIS_fnc_addRespawnInventory;
[west, "TAT" ] call BIS_fnc_addRespawnInventory;
[west, "CLS" ] call BIS_fnc_addRespawnInventory;
[west, "DMR" ] call BIS_fnc_addRespawnInventory;
[west, "SP" ] call BIS_fnc_addRespawnInventory;
[west, "SC"] call BIS_fnc_addRespawnInventory;
[west, "STL" ] call BIS_fnc_addRespawnInventory;
