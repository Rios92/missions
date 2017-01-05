// admin_uid.sqf

waitUntil {(getPlayerUID player) != ""};

_uid = getPlayerUID player;

switch(_uid)do {
    case "76561198041220925": // Truly
    {
    player addAction ["<t color='#900000'>Spectate</t>", "scripts\spectator\specta.sqf",[],-99,false,false,"",''];
    };
    default
    {};
};
