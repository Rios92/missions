//Diary
_mission = toUpper (format ["%1",getText (missionconfigfile >> "onLoadName")]);

diary_text = _mission + "<br/>" + 
format [" Date: %3.%2.%1<br/>",date select 0,date select 1,date select 2]+
format [" Location: %1<br/>",worldName]+
format [" Typ: %1<br/>",getText (missionconfigfile >> "Header" >> "gameType")]+
format [" Players: %1-%2<br/>",getNumber (missionconfigfile >> "Header" >> "minPlayers"),getNumber (missionconfigfile >> "Header" >> "maxPlayers")]+
format [" Authors: %1<br/><br/>",getText (missionconfigfile >> "author")]+
"<br/>"+
"FEATURES:<br/>"+
"- Virtual Ammobox System (VAS)<br/>"+
"- Virtual Arsenal<br/>"+
"- reviving teammates<br/>"+
"- group management<br/>"+
"- CH view distance <br/>"+
"- only pilot can fly<br/>"+
"- Pilots must be on TFT8 Teamspeak<br/>"+
"- ts3 IP: TS3.TFT8.com<br/>"+
"- gradually assigned tasks<br/>"+
"- player markers on map<br/>"+
"- vehicle/heli respawn <br/>"+
"- protected base zone  <br/>"+
"- respawn of helicopters on request <br/>"+
"<br/>"+
"THANKS:<br/>"+
"- Tonic aka TAW_Tonic for VAS<br/>"+
"- Tonic & Champ1 for CH View Distance<br/>"+
"- =BTC= Giallustio for revive script<br/>"+
"- Tophe of Östgöta Ops [OOPS] / updated by SPJESTER for vehicle respawn<br/>"+
"- Kronzky for String Functions Library<br/>"+
"- Igi_PL for his great loading box system (IgiLoad)<br/>"+
"- Tophe for House Patrol Script<br/>"+
"- Shay_gman,Spirit and Psycho for save function in MCC S4<br/>"+
"- LAMA CZ-SK Team<br/>"+
"- BIS for this great game!<br/>"+
"";

_roles = "<br/>"+
"*********************************************<br/>"+
"ROLES:<br/>"+
"*********************************************<br/>"+
"COMMANDER<br/>"+
"- cooperate all actions with all teamates (3 teams)<br/>"+
"<br/>"+
"PILOT<br/>"+
"- Pilots must be on TFT8 Teamspeak<br/>"+
"- ts3 IP: TS3.TFT8.com<br/>"+
"- transport soldiers to action<br/>"+
"<br/>"+
"SOLDIER<br/>"+
"- fulfil assigned task<br/>"+
"- follow orders of teamleader/commander<br/>"+
"<br/>"+
"*********************************************<br/>"+
"NOTES:<br/>"+
"*********************************************<br/>"+
"- deserted vehicles are automaticaly respawned after 180 seconds<br/>"+
"- deserted helicopter are not respawned <br/>"+
"- helicopters can be respawned remotly from HQ<br/>"+
"- commander can call artilery support (0-8)"+
"<br/>"+
"";

waitUntil {!isNull player};
if (logging_mode) then {["briefing.sqf",2,"creating diary record"] spawn FFS_FNC_log;};

player createDiaryRecord ["Diary", ["Roles & Notes",_roles]];
player createDiaryRecord ["Diary", ["Mission brief","On the island Altis is rising strength of radicals from Islamic states (ISIS), which have already taken control of some regions on the island. Extremists systematically kill off the inhabitants of a different faith. NATO, US and some Arab states formed a coalition and sent troops to the island. These ground forces aim to destroy terrorist organization.<br/><br/>"+
"*********************************************<br/><br/>"+
"Tasks will be assigned during mission<br/><br/>"
]];
player createDiaryRecord ["Diary", [_mission,diary_text + format ["<br/><br/>Titles: %1<br/>%2",localize "STR_FFS_TITLES"]]];

if (true) exitWith {};