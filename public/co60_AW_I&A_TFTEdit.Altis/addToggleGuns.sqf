private ["_veh"];
_veh = _this select 0;

if !(typeOf _veh in ["B_Heli_Transport_01_camo_F", "B_Heli_Transport_01_F", "B_Heli_Transport_03_F"]) exitWith {};

_veh addAction [
	"Toggle Guns",
	{
		_heli = (_this select 0);
		_mag = count (_heli magazinesTurret [1]);
		if (_mag == 0) then {
			_heli addMagazineTurret ["2000Rnd_65x39_Belt_Tracer_Red", [1]];
			_heli addMagazineTurret ["2000Rnd_65x39_Belt_Tracer_Red", [2]];
			_heli vehicleChat "Guns enabled.";
		} else {
			_heli removeMagazinesTurret ["2000Rnd_65x39_Belt_Tracer_Red", [1]];
			_heli removeMagazinesTurret ["2000Rnd_65x39_Belt_Tracer_Red", [2]];
			_heli vehicleChat "Guns disabled.";
		};
	},
	[],
	1.5,
	false,
	false,
	"",
	"driver _target == _this"
];