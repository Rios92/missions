// [unit,0,0,[]] execVM "scripts\soldierwalkguard2.sqf"

_group = group (_this select 0);
_maxRad = _this select 1;
_minRad = _this select 2;
_waypoints = _this select 3;

_countWaypoints = count _waypoints;

//if(count waypoints _group > 1)exitwith{serviceNumber = [1,format ["EXIT - %1",_group]]; publicvariable "serviceNumber";};
//serviceNumber = [1,format ["1. - %1, %2",_group,waypoints _group]]; publicvariable "serviceNumber";
 
for [{_n = 0},{_n < (_countWaypoints - 1)},{_n = _n+1}] do 
{
	_group addWaypoint [_waypoints select _n,0];
	[_group, (_n+1)] setWaypointTimeout [1,5,10];
	[_group, (_n+1)] setWaypointSpeed  "LIMITED";
	[_group, (_n+1)] setWaypointBehaviour "SAFE";
	sleep 0.05;
};

_group addWaypoint [(_waypoints select (_countWaypoints - 1)) ,0];
[_group,_countWaypoints] setWaypointType "CYCLE";

//serviceNumber = [1,format ["2. - %1, %2",_group,waypoints _group]]; publicvariable "serviceNumber";

if (true) exitWith {};

