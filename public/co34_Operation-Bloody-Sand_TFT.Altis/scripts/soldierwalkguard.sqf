_group = group (_this select 0);
_maxRad = _this select 1;
_minRad = _this select 2;
_center = _this select 3; 

//if(count waypoints _group > 1)exitwith{serviceNumber = [1,format ["EXIT - %1",_group]]; publicvariable "serviceNumber";};
//serviceNumber = [1,format ["1. - %1, %2",_group,waypoints _group]]; publicvariable "serviceNumber";
 
_rndPos = [ _center , _maxRad , _minRad ] call (compile preprocessFile "funcs\func_randomPos.sqf");
_group addWaypoint [_rndPos,0];
[_group, 1] setWaypointTimeout [1,3,2];
[_group, 1] setWaypointSpeed  "LIMITED";
[_group, 1] setWaypointBehaviour "SAFE";
sleep 0.05;

_rndPos = [ _center , _maxRad , _minRad ] call (compile preprocessFile "funcs\func_randomPos.sqf");
_group addWaypoint [_rndPos,0];
[_group, 2] setWaypointTimeout [1,3,2];
sleep 0.05;

_rndPos = [ _center , _maxRad , _minRad ] call (compile preprocessFile "funcs\func_randomPos.sqf");
_group addWaypoint [_rndPos,0];
[_group, 3] setWaypointTimeout [1,3,2];
sleep 0.05;

_rndPos = [ _center , _maxRad , _minRad ] call (compile preprocessFile "funcs\func_randomPos.sqf");
_group addWaypoint [_rndPos,0];
[_group, 4] setWaypointType "CYCLE";

//serviceNumber = [1,format ["2. - %1, %2",_group,waypoints _group]]; publicvariable "serviceNumber";

if (true) exitWith {};

