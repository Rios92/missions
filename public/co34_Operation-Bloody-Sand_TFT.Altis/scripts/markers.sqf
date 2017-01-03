//*******************************************************************************************************
//*********************************** by FriZY & Faust **************************************************
//*******************************************************************************************************
// execVM "Markers.sqf";

// S E R V E R  O N L Y

if(!(isServer))exitwith{}; 
sleep 1;

//*************************************** VARIABLES ******************************************************

_countMarkers = getNumber (missionconfigfile >> "Header" >> "maxPlayers");
_base = "a";
_typ = "mil_dot";
_color = "ColorBlue";

_SelUnit = "";
_SelMarker = "";
_noDriverMarker=[];
{_noDriverMarker set [_forEachIndex, _x select 0]} forEach vehOnMap;
_noDriverMarker=_noDriverMarker + noDriverName;

//*************************************** SCRIPT **********************************************************

for [{_i = 1},{_i <= _countMarkers},{_i = _i + 1}] do
{
	_SelMarker = format ["%1%2",_base, _i];
	createMarker [_SelMarker, [0,0] ];
       _SelMarker setMarkerColor _color;
       _SelMarker setMarkerType _typ;
       _SelMarker setMarkerSize [0.5, 0.5];       
};

//call compile format ["!isNull %1%2",_base,_i]

while {alive server} do
{ 	
	for [{_i = 1},{_i <= _countMarkers},{_i = _i + 1}] do
	{
		_SelMarker = format ["%1%2",_base, _i];
		
		if (call compile format ["!isNil ""%1%2""",_base,_i]) then
		{
			call compile format ["_SelUnit = %1%2",_base,_i];
			if (isplayer _SelUnit) then                      
			{		               	                 
		        if ((vehicle _SelUnit != _SelUnit)) then 
				{      
					if ((driver (vehicle _SelUnit) == _SelUnit) and ({_x == format ["%1",vehicle _SelUnit]} count _noDriverMarker < 1) ) then 
					{  
						// DRIVER MARKER
						_SelMarker SetMarkerText format ["Driver: %1 Crew: %2",name _SelUnit, count (crew (vehicle _SelUnit))];
					} else {
						_SelMarker SetMarkerText "";
					};
				}else
				{                        
					if (alive _SelUnit) then {
						_SelMarker SetMarkerText format [" %1",name _SelUnit];
					};
				};
				_SelMarker SetMarkerPos [GetPos _SelUnit select 0, GetPos _SelUnit select 1];     
		
			}else
		  	{
		                _SelMarker SetMarkerText "";                       
		                _SelMarker SetMarkerPos [0,0];
			};
		}else
		{
			_SelMarker SetMarkerText "";                       
		        _SelMarker SetMarkerPos [0,0];
		};
		sleep 0.2;
	};
	
	{
		_stringName=(_x select 0);
		_pos=[0,0];
		if (call compile format ["!isNil ""%1""",(_x select 0)]) then
		{	
			_objName=call compile format ["%1",_stringName];
			if (count crew _objName > 0) then 
				{
						// VEHICLE MARKER
						if (isNull driver _objName) then 
						{
								_stringName setMarkerText format [" %1, crew: %2",(_x select 1),(count crew _objName)];
						}else
						{
								_stringName setMarkerText format [" %1: %3, crew: %2",(_x select 1),(count crew _objName),(name driver _objName)];        
						};
						
				}else
				{
						_stringName setMarkerText (_x select 1);
				}; 
			
			_pos = getpos _objName;
		}else
		{
			_pos=[0,0];
			_stringName setMarkerText (_x select 1);
		};
		_stringName setMarkerPos _pos;
		sleep 0.2;
	} forEach vehOnMap;
};

