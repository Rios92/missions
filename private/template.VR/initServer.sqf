_curator = (createGroup sideLogic) createUnit ["ModuleCurator_F", [0,0,0], [], 0, "NONE"]; 
_curator setVariable ["Addons", 3, true]; 
_curator setVariable ["Owner", "#adminLogged", true];

//all players
private _allHCs = entities "HeadlessClient_F";
private _allHPs = allPlayers - _allHCs;

TFT_players = [];
{
	TFT_players pushBackUnique (name _x);
} forEach _allHPs;

0 = [] execVM "log.sqf";