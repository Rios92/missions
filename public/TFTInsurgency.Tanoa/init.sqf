[] execVM "eos\OpenMe.sqf";

if(isServer) then {
    ["Initialize"] call BIS_fnc_dynamicGroups;
} else {
    ["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;
};

if(hasInterface && {player getUnitTrait "derp_pilot"}) then {
    sleep 3;
    hintC "Remember, you must be on TeamSpeak to be a pilot: TS3.TFT8.COM";
};
