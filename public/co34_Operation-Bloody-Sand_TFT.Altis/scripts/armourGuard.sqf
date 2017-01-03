_Grpvehicle = group (_this select 0); 
_maxRad = _this select 1;
_minRad = _this select 2;
_center = _this select 3;

_speed = "LIMITED";
_behav = "SAFE";
_type = "MOVE";

if (count _this >= 5) then 
{
	if (_this select 4 in ["UNCHANGED","LIMITED","NORMAL","FULL"]) then 
	{
		_speed = _this select 4;
		if (count _this >= 6) then 
		{
			if (_this select 5 in ["UNCHANGED","CARELESS","SAFE","AWARE","COMBAT","STEALTH"]) then 
			{
				_behav = _this select 5;
				if (count _this >= 7) then 
				{
					if (_this select 6 in ["MOVE","DESTROY"]) then 
					{
						_type = _this select 6;
					} else
					{
						hint "WRONG ARGUMENT IN ARRAY #7 !!!";
					};
				};
			} else
			{
				hint "WRONG ARGUMENT IN ARRAY #6 !!!";
			};
		};
	} else
	{
		hint "WRONG ARGUMENT IN ARRAY #5 !!!";	
	}; 	
};
 
// String = typeName anything >> Returns the data type of an expression.

_rndPos = [ _center , _maxRad , _minRad ] call (compile preprocessFile "funcs\func_randomPos.sqf");
_Grpvehicle addWaypoint [_rndPos,0 ];
[_Grpvehicle, 1] setWaypointTimeout [1,20,5];
[_Grpvehicle, 1] setWaypointSpeed  _speed;
[_Grpvehicle, 1] setWaypointBehaviour _behav;
[_Grpvehicle, 1] setWaypointType _type; 

_rndPos = [ _center , _maxRad , _minRad ] call (compile preprocessFile "funcs\func_randomPos.sqf");
_Grpvehicle addWaypoint [_rndPos,0 ];
[_Grpvehicle, 2] setWaypointTimeout [5,10,8];
[_Grpvehicle, 2] setWaypointType _type; 
sleep 0.1;

_rndPos = [ _center , _maxRad , _minRad ] call (compile preprocessFile "funcs\func_randomPos.sqf");
_Grpvehicle addWaypoint [_rndPos,0];
[_Grpvehicle, 3] setWaypointTimeout [10,30,20];
[_Grpvehicle, 3] setWaypointType _type; 
sleep 0.1;

_rndPos = [ _center , _maxRad , _minRad ] call (compile preprocessFile "funcs\func_randomPos.sqf");
_Grpvehicle addWaypoint [_rndPos,0];
[_Grpvehicle, 4] setWaypointTimeout [10,30,20];
[_Grpvehicle, 4] setWaypointType _type; 
sleep 0.1;

_rndPos = [ _center , _maxRad , _minRad ] call (compile preprocessFile "funcs\func_randomPos.sqf");
_Grpvehicle addWaypoint [_rndPos,0];
[_Grpvehicle, 5] setWaypointType "CYCLE";

//player groupchat format ["--- %4: %1 %2 %3 %5 ---",_speed,_behav,_type, typeof (vehicle leader _Grpvehicle),typeName _speed];

if (true) exitWith {};

//[q,200,50,getMarkerPos "zelenogorsk","FULL","SAFE","DESTROY"] execVM "scripts\ArmourGuard.sqf";
