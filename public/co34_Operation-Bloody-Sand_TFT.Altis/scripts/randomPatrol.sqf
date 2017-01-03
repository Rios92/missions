//["area3","area4",3] execVM "scripts\randomPatrol.sqf";

// create patrol 2 sections
_taskMarker1 = _this select 0;
_taskMarker2 = _this select 1;
_numPatrolVeh = _this select 2;
if (logging_mode) then {["randomPatrol.sqf",16,format ["RandomPatrol started / _taskMarker1: %1 / _taskMarker2: %2 / _numPatrolVeh: %3",_taskMarker1,_taskMarker2,_numPatrolVeh]] spawn FFS_FNC_log;};

_markerPos1 = getMarkerPos _taskMarker1;
_markerSize1 = (getMarkerSize _taskMarker1) select 0;
_markerPos2 = getMarkerPos _taskMarker2;
_markerSize2 = (getMarkerSize _taskMarker2) select 0;

waitUntil {!isNil "FFS_FNC_crateVehsPatrol"};
_vehArray1 = ["east",1,_markerPos1,_markerPos1,_markerSize1,0,game_difficulty,"ISIS"] call FFS_FNC_crateVehsPatrol; _numPatrolVeh = _numPatrolVeh - 1;
_vehArray2 = ["east",1,_markerPos2,_markerPos2,_markerSize2,0,game_difficulty,"ISIS"] call FFS_FNC_crateVehsPatrol; _numPatrolVeh = _numPatrolVeh - 1;
_veh1 = _vehArray1 select 0;
_veh2 = _vehArray2 select 0;
vehPatrol = [_veh1 ,_veh2 ];

//player sideChat format ["Loop started / veh1: %1 / veh2: %2",_veh1,_veh2];
while {_numPatrolVeh > 0 } do
{
 	//player sideChat format ["waitUntil  >> _numPatrolVeh: %3 / veh1: %1 / veh2: %2",_veh1,_veh2,_numPatrolVeh];
	waitUntil { !canMove _veh1 or !canMove _veh2 };
	sleep 60 + random 100;
	//player sideChat format ["Vehicle was destroyed / veh1: %1 / veh2: %2",_veh1,_veh2];
	if (!canMove _veh1) then
	{
		_vehArray1 = ["east",1,_markerPos1,_markerPos1,_markerSize1,0,game_difficulty,"ISIS"] call FFS_FNC_crateVehsPatrol; _numPatrolVeh = _numPatrolVeh - 1;
		_veh1 = _vehArray1 select 0;
		hint "New patrol vehicle1 created";
		//player sideChat format ["Vehicle 1 was created / _numPatrolVeh: %3 / veh1: %1 / veh2: %2",_veh1,_veh2,_numPatrolVeh];
	}else {
		if (!canMove _veh2) then
		{
			_vehArray2 = ["east",1,_markerPos2,_markerPos2,_markerSize2,0,game_difficulty,"ISIS"] call FFS_FNC_crateVehsPatrol; _numPatrolVeh = _numPatrolVeh - 1;
			_veh2 = _vehArray2 select 0;
			hint "New patrol vehicle2 created";
			//player sideChat format ["Vehicle 2 was created / _numPatrolVeh: %3 / veh1: %1 / veh2: %2",_veh1,_veh2,_numPatrolVeh];
		} else {
			if (logging_mode) then {["randomPatrol.sqf",16,format ["No condition found / veh1: %1 / veh2: %2",_veh1,_veh2]] spawn FFS_FNC_log;};
		};
	};
	sleep 5;
	vehPatrol = [_veh1 ,_veh2 ];
};
//player sideChat format ["END /  _numPatrolVeh: %3 / veh1: %1 / veh2: %2",_veh1,_veh2,_numPatrolVeh];

if (true) exitWith {};


