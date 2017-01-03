// [a1,"Me"] execVM "tasks\t7_reporterMarker.sqf";
// S E R V E R  O N L Y

if(!isServer)exitwith{}; 

_unit = _this select 0;
_unitName = _this select 1;
_typ = "mil_dot";
_color = "ColorGreen";

_reporterMarker = createMarker ["Marker1", [0,0] ];
_reporterMarker setMarkerColor _color;
_reporterMarker setMarkerType _typ;
_reporterMarker setMarkerSize [0.5, 0.5];
_reporterMarker SetMarkerText format [" %1",_unitName];
_reporterPos = getPos _unit;
_rescueCheck = time + 60;

while {Status7P == "ACTIVE"} do
{ 	
	_reporterMarker setMarkerPos [GetPos _unit select 0, GetPos _unit select 1];     
	sleep 1;
};

deleteMarker _reporterMarker;

if (true) exitWith {};

