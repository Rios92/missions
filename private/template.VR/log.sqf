diag_log "S3LOG";

//log attendance
private _log = [];

//mission start date and time
_log pushBack missionStart;

//get all human players
private _allHCs = entities "HeadlessClient_F";
private _allHPs = allPlayers - _allHCs;

//admin
{
	private _adminState = admin owner _x;
	if (_adminState == 2) then {
		_log pushBack (name _x);
	};
} forEach _allHPs;

//map
_log pushBack briefingName;

//map
_log pushBack worldName;

//players
{
	TFT_players pushBackUnique (name _x);
} forEach _allHPs;
_log pushBack TFT_players;

//log to rpt
diag_log _log;