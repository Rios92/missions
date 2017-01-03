private _group = createGroup east;

for "_i" from 0 to 4 do {
    _unit = _group createUnit [selectRandom ["O_G_Soldier_AR_F", "O_G_medic_F", "O_G_Soldier_GL_F", "O_G_Soldier_M_F", "O_G_Soldier_LAT_F", "O_G_Soldier_F"], getMarkerPos "ai_spawn", [], 0, "NONE"];
    _unit setskill ["aimingAccuracy", aiSkill];
	_unit setskill ["aimingSpeed", aiSkill];
    _unit addEventHandler ["killed", { [] remoteExec ["tft_dnd_fnc_onEntityKilledLocal", _this select 1]; }];
};

_group
