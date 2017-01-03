// by Xeno
//#define __DEBUG__
#define THIS_FILE "x_initcommon.sqf"
#include "..\x_setup.sqf"
diag_log [diag_frameno, diag_ticktime, time, "Executing Dom x_initcommon.sqf"];

if (isNil "paramsArray") then {
	if (isClass (getMissionConfig "Params")) then {
		private _conf = getMissionConfig "Params";
		for "_i" from 0 to (count _conf - 1) do {
			private _paramName = configName (_conf select _i);
			private _paramval = getNumber (_conf>>_paramName>>"default");
			if (_paramval != -99999) then {
				missionNamespace setVariable [_paramName, _paramval];
			};
		};
	};
} else {
	for "_i" from 0 to (count paramsArray - 1) do {
		private _paramval = paramsArray select _i;
		if (_paramval != -99999) then {
			missionNamespace setVariable [configName ((getMissionConfig "Params") select _i), _paramval];
		};
	};
};

d_with_ranked = d_with_ranked == 0;
#ifndef __TT__
d_with_ai = d_with_ai == 0;
#else
d_with_ai = false;
d_with_ai_features = 1;
d_WithRecapture = 1;
d_WithJumpFlags = 1;
d_MaxNumAmmoboxes = d_MaxNumAmmoboxes * 2;
d_pilots_only = 1;
#endif

if (d_sub_kill_points != 0) then {
	d_sub_kill_points = d_sub_kill_points * -1;
};

if (d_GrasAtStart == 1) then {setTerrainGrid 50};

if (isServer) then {skipTime d_TimeOfDay};

if (isServer || {!isDedicated && {!hasInterface}}) then {
	// first element (array. for example: [2,1]): number of vehicle groups that will get spawned, the first number is the max number that will get spawned,
	// the second one the minimum. So [2,0] means, there can be no vehicle groups at all or a maximum of 2 groups of this kind
	// second element: maximum number of vehicles in group; randomly chosen
	switch (d_WithLessArmor) do {
		case 0: {
			d_vec_numbers_guard = [
				[[1,0], 1], // tanks
				[[1,0], 1], // tracked apc
				[[1,1], 1], // wheeled apc
				[[1,1], 1], // jeep with mg
				[[1,0], 1] // jeep with gl
			];
			d_vec_numbers_guard_static = [
				[[1,1], 1], // tanks
				[[1,1], 1], // tracked apc
				[[1,1], 1] // aa
			];
			d_vec_numbers_patrol = [
#ifndef __TT__
				[[1,1], 1], // tanks
				[[1,1], 1], // tracked apc
				[[1,1], 1], // wheeled apc
				[[1,1], 1], // jeep with mg
				[[1,1], 1] // jeep with gl
#else
				[[1,1], 1], // tanks
				[[2,1], 1], // tracked apc
				[[2,1], 1], // wheeled apc
				[[2,1], 1], // jeep with mg
				[[1,1], 1] // jeep with gl
#endif
			];

			// allmost the same like above
			// first element the max number of ai "foot" groups that will get spawned, second element minimum number (no number for vehicles in group necessary)
			d_footunits_guard = [
#ifndef __TT__
				[1,1], // basic groups
				[1,1] // specop groups
#else
				[2,1], // basic groups
				[2,1] // specop groups
#endif
			];
			d_footunits_patrol = [
#ifndef __TT__
				[5,3], // basic groups
				[5,3] // specop groups
#else
				[6,3], // basic groups
				[5,3] // specop groups
#endif
			];
			d_footunits_guard_static = [
				[1,1], // basic groups
				[1,0] // specop groups
			];
			d_footunits_attack = [
				[1,1], // basic groups
				[1,1] // specop groups
			];
			d_vec_numbers_attack = [
				[[1,1], 1], // tanks
				[[1,1], 1], // tracked apc
				[[1,1], 1], // wheeled apc
				[[1,1], 1], // jeep with mg
				[[1,1], 1], // jeep with gl
				[[1,1], 1] // aa
			];
		};
		case 1: {
			d_vec_numbers_guard = [
				[[1,0], 1], // tanks
				[[1,0], 1], // tracked apc
				[[1,0], 1], // wheeled apc
				[[1,1], 1], // jeep with mg
				[[1,1], 1] // jeep with gl
			];
			d_vec_numbers_guard_static = [
				[[1,0], 1], // tanks
				[[1,0], 1], // tracked apc
				[[1,0], 1] // aa
			];
			d_vec_numbers_patrol = [
				[[1,0], 1], // tanks
				[[1,0], 1], // tracked apc
				[[1,0], 1], // wheeled apc
				[[1,0], 1], // jeep with mg
				[[1,1], 1] // jeep with gl
			];

			// allmost the same like above
			// first element the max number of ai "foot" groups that will get spawned, second element minimum number (no number for vehicles in group necessary)
			d_footunits_guard = [
				[2,1], // basic groups
				[2,1] // specop groups
			];
			d_footunits_patrol = [
				[6,3], // basic groups
				[6,3] // specop groups
			];
			d_footunits_guard_static = [
				[3,1], // basic groups
				[2,1] // specop groups
			];
			d_footunits_attack = [
				[3,1], // basic groups
				[2,1] // specop groups
			];
			d_vec_numbers_attack = [
				[[1,0], 1], // tanks
				[[1,0], 1], // tracked apc
				[[1,0], 1], // wheeled apc
				[[1,1], 1], // jeep with mg
				[[1,1], 1], // jeep with gl
				[[1,0], 1] // aa
			];
		};
		case 2: {
			d_vec_numbers_guard = [
				[[0,0], 1], // tanks
				[[0,0], 1], // tracked apc
				[[0,0], 1], // wheeled apc
				[[2,1], 1], // jeep with mg
				[[2,1], 1] // jeep with gl
			];
			d_vec_numbers_guard_static = [
				[[0,0], 1], // tanks
				[[0,0], 1], // tracked apc
				[[0,0], 1] // aa
			];
			d_vec_numbers_patrol = [
				[[0,0], 1], // tanks
				[[0,0], 1], // tracked apc
				[[0,0], 1], // wheeled apc
				[[2,1], 1], // jeep with mg
				[[2,1], 1] // jeep with gl
			];

			// allmost the same like above
			// first element the max number of ai "foot" groups that will get spawned, second element minimum number (no number for vehicles in group necessary)
			d_footunits_guard = [
				[4,1], // basic groups
				[4,1] // specop groups
			];
			d_footunits_patrol = [
				[8,3], // basic groups
				[6,3] // specop groups
			];
			d_footunits_guard_static = [
				[4,1], // basic groups
				[3,1] // specop groups
			];
			d_footunits_attack = [
				[6,1], // basic groups
				[6,1] // specop groups
			];
			d_vec_numbers_attack = [
				[[0,0], 1], // tanks
				[[0,0], 1], // tracked apc
				[[0,0], 1], // wheeled apc
				[[2,1], 1], // jeep with mg
				[[2,1], 1], // jeep with gl
				[[1,0], 1] // aa
			];
		};
	};
	
	// enemy ai skill: [base skill, random value (random 0.3) that gets added to the base skill]
	d_skill_array = switch (d_EnemySkill) do {
		case 1: {[0.2,0.1]};
		case 2: {[0.4,0.2]};
		case 3: {[0.6,0.3]};
	};
};

if (!isDedicated) then {
	if (d_with_ai) then {d_current_ai_num = 0};

	if (d_with_ranked) then {
		d_ranked_a = [
			20, // points that an engineer must have to repair/refuel a vehicle
			[3,2,1,0], // points engineers get for repairing an air vehicle, tank, car, other
			10, // points an artillery operator needs for a strike
			3, // points in the AI version for recruiting one soldier
			10, // points a player needs for an AAHALO parajump
			10, // points that get subtracted for creating a vehicle at a MHQ
			20, // points needed to create a vehicle at a MHQ
			3, // points a medic gets if someone heals at his Mash
			["Sergeant","Lieutenant","Captain","Major"], // Ranks needed to drive different vehicles, starting with: kindof wheeled APC, kindof Tank, kindof Helicopter (except the inital 4 helis), Plane
			30, // points that get added if a player is xxx m in range of a main target when it gets cleared
			400, // range the player has to be in to get the main target extra points
			10, // points that get added if a player is xxx m in range of a sidemission when the sidemission is resolved
			200, // range the player has to be in to get the sidemission extra points
			20, // points needed for an egineer to rebuild the support buildings at base
			10, // not used anymore !!! Was points needed to build MG Nest before
			5, // points needed in AI Ranked to call in an airtaxi
			20, // points needed to call in an air drop
			4, // points a medic gets when he heals another unit
			1, // points that a player gets when transporting others
			20, // points needed for activating satellite view
			20, // points needed to build a FARP (engineer)
			2, // points a player gets for reviving another player
			10 // points a Squad Leader needs for a CAS
		];

		// distance a player has to transport others to get points
		d_transport_distance = 500;

		// rank needed to fly the wreck lift chopper
		d_wreck_lift_rank = "CAPTAIN";
	} else {
		d_ranked_a = [];
	};

	d_graslayer_index = if (d_GrasAtStart == 1) then {0} else {1};

	d_disable_viewdistance = d_ViewdistanceChange == 1;
};
// chopper varname, type (0 = lift chopper, 1 = wreck lift chopper, 2 = normal chopper), marker name, unique number (same as in d_init.sqf), marker type, marker color, marker text, chopper string name
#ifndef __TT__
d_choppers = [
	["D_HR1",0,"d_chopper1",3001,"n_air","ColorWhite","1", localize "STR_DOM_MISSIONSTRING_7"], ["D_HR2",2,"d_chopper2",3002,"n_air","ColorWhite","2",""],
	["D_HR3",2,"d_chopper3",3003,"n_air","ColorWhite","3",""], ["D_HR4",1,"d_chopper4",3004,"n_air","ColorWhite","W", localize "STR_DOM_MISSIONSTRING_10"],
	["D_HR5",2,"d_chopper5",3005,"n_air","ColorWhite","5",""], ["D_HR6",2,"d_chopper6",3006,"n_air","ColorWhite","6",""]
];
#else
d_choppers_blufor = [
	["D_HR1",0,"d_chopper1",3001,"n_air","ColorWhite","1", localize "STR_DOM_MISSIONSTRING_7"], ["D_HR2",2,"d_chopper2",3002,"n_air","ColorWhite","2",""],
	["D_HR3",2,"d_chopper3",3003,"n_air","ColorWhite","3",""], ["D_HR4",1,"d_chopper4",3004,"n_air","ColorWhite","W", localize "STR_DOM_MISSIONSTRING_10"],
	["D_HR5",2,"d_chopper5",3005,"n_air","ColorWhite","5",""], ["D_HR6",2,"d_chopper6",3006,"n_air","ColorWhite","6",""]
];
d_choppers_opfor = [
	["D_HRO1",0,"d_choppero1",4001,"n_air","ColorWhite","1", localize "STR_DOM_MISSIONSTRING_7"], ["D_HRO2",2,"d_choppero2",4002,"n_air","ColorWhite","2",""],
	["D_HRO3",2,"d_choppero3",4003,"n_air","ColorWhite","3",""], ["D_HRO4",1,"d_choppero4",4004,"n_air","ColorWhite","W", localize "STR_DOM_MISSIONSTRING_10"],
	["D_HRO5",2,"d_choppero5",4005,"n_air","ColorWhite","5",""], ["D_HRO6",2,"d_choppero6",4006,"n_air","ColorWhite","6",""]
];
#endif

// vehicle varname, unique number (same as in d_init.sqf), marker name, marker type, marker color, marker text, vehicle string name
#ifndef __TT__
d_p_vecs = [
	["D_MRR1",0,"d_mobilerespawn1","b_hq","ColorYellow","1",localize "STR_DOM_MISSIONSTRING_12"],["D_MRR2",1,"d_mobilerespawn2","b_hq","ColorYellow","2",localize "STR_DOM_MISSIONSTRING_13"],
	["D_MEDVEC",100,"d_medvec","n_med","ColorGreen","M",""],["D_TR1",200,"d_truck1","n_maint","ColorGreen","R1",""],
	["D_TR2",201,"d_truck2","n_support","ColorGreen","F1",""],["D_TR3",202,"d_truck3","n_support","ColorGreen","A1",""],
	["D_TR6",203,"d_truck4","n_maint","ColorGreen","R2",""],["D_TR5",204,"d_truck5","n_support","ColorGreen","F2",""],
	["D_TR4",205,"d_truck6","n_support","ColorGreen","A2",""],["D_TR7",300,"d_truck7","n_service","ColorGreen","E1",""],
	["D_TR8",301,"d_truck8","n_service","ColorGreen","E2",""],["D_TR9",400,"d_truck9","n_support","ColorGreen","T2",""],
	["D_TR10",401,"d_truck10","n_support","ColorGreen","T1",""]
];
#else
d_p_vecs_blufor = [
	["D_MRR1",0,"d_mobilerespawn1","b_hq","ColorYellow","1",localize "STR_DOM_MISSIONSTRING_12"],["D_MRR2",1,"d_mobilerespawn2","b_hq","ColorYellow","2",localize "STR_DOM_MISSIONSTRING_13"],
	["D_MEDVEC",100,"d_medvec","n_med","ColorGreen","M",""],["D_TR1",200,"d_truck1","n_maint","ColorGreen","R1",""],
	["D_TR2",201,"d_truck2","n_support","ColorGreen","F1",""],["D_TR3",202,"d_truck3","n_support","ColorGreen","A1",""],
	["D_TR6",203,"d_truck4","n_maint","ColorGreen","R2",""],["D_TR5",204,"d_truck5","n_support","ColorGreen","F2",""],
	["D_TR4",205,"d_truck6","n_support","ColorGreen","A2",""],["D_TR7",300,"d_truck7","n_service","ColorGreen","E1",""],
	["D_TR8",301,"d_truck8","n_service","ColorGreen","E2",""],["D_TR9",400,"d_truck9","n_support","ColorGreen","T2",""],
	["D_TR10",401,"d_truck10","n_support","ColorGreen","T1",""]
];
d_p_vecs_opfor = [
	["D_MRRO1",1000,"d_mobilerespawno1","o_hq","ColorYellow","1",localize "STR_DOM_MISSIONSTRING_12"],["D_MRRO2",1001,"d_mobilerespawno2","o_hq","ColorYellow","2",localize "STR_DOM_MISSIONSTRING_13"],
	["D_MEDVECO",1100,"d_medveco","n_med","ColorGreen","M",""],["D_TRO1",1200,"d_trucko1","n_maint","ColorGreen","R1",""],
	["D_TRO2",1201,"d_trucko2","n_support","ColorGreen","F1",""],["D_TRO3",1202,"d_trucko3","n_support","ColorGreen","A1",""],
	["D_TRO6",1203,"d_trucko4","n_maint","ColorGreen","R2",""],["D_TRO5",1204,"d_trucko5","n_support","ColorGreen","F2",""],
	["D_TRO4",1205,"d_trucko6","n_support","ColorGreen","A2",""],["D_TRO7",1300,"d_trucko7","n_service","ColorGreen","E1",""],
	["D_TRO8",1301,"d_trucko8","n_service","ColorGreen","E2",""],["D_TRO9",1400,"d_trucko9","n_support","ColorGreen","T2",""],
	["D_TRO10",1401,"d_trucko10","n_support","ColorGreen","T1",""]
];
#endif


if (!isDedicated) then {
	d_mob_respawns = [];
#ifndef __TT__
	{
		if (_x select 1 < 100) then {
			d_mob_respawns pushBack [_x select 0, _x select 6];
		};
		false
	} count d_p_vecs;
#else
	d_mob_respawns_blufor = [];
	{
		if (_x select 1 < 100) then {
			d_mob_respawns_blufor pushBack [_x select 0, _x select 6];
		};
		false
	} count d_p_vecs_blufor;
	d_mob_respawns_opfor = [];
	{
		if (_x select 1 < 1100) then {
			d_mob_respawns_opfor pushBack [_x select 0, _x select 6];
		};
		false
	} count d_p_vecs_opfor;
#endif
};

#ifdef __OWN_SIDE_OPFOR__
private _d_helilift1_types = ["O_MRAP_02_F","O_Truck_02_transport_F","O_Truck_02_covered_F","O_Truck_02_Ammo_F","O_Truck_03_ammo_F","O_Truck_02_fuel_F","O_Truck_03_fuel_F","O_Truck_02_box_F",
	"O_Truck_02_medical_F","O_Truck_03_medical_F","O_APC_Wheeled_02_rcws_F","O_APC_Tracked_02_cannon_F","O_APC_Tracked_02_AA_F","O_MBT_02_cannon_F","O_UGV_01_F","O_UGV_01_rcws_F",
	"O_MRAP_02_hmg_F","O_MRAP_02_gmg_F","C_Offroad_01_F","Land_CargoBox_V1_F","O_Truck_03_device_F","B_APC_Tracked_01_CRV_F","O_Truck_03_transport_ghex_F","O_T_Truck_03_transport_ghex_F",
	"O_Truck_03_covered_ghex_F","O_T_Truck_03_covered_ghex_F","O_Truck_03_medical_ghex_F","O_Truck_03_repair_ghex_F","O_T_Truck_03_repair_ghex_F","O_Truck_03_fuel_ghex_F","O_T_Truck_03_fuel_ghex_F",
	"O_Truck_03_ammo_ghex_F","O_T_Truck_03_ammo_ghex_F"];
#endif
#ifdef __OWN_SIDE_BLUFOR__
private _d_helilift1_types = ["B_MRAP_01_F","B_Truck_01_transport_F","B_Truck_01_covered_F","B_Truck_01_ammo_F","B_Truck_01_fuel_F","B_Truck_01_Repair_F","B_Truck_01_medical_F",
	"B_APC_Wheeled_01_cannon_F","B_APC_Tracked_01_rcws_F","B_MBT_01_cannon_F","B_MBT_01_TUSK_F","B_UGV_01_F","B_UGV_01_rcws_F","B_MRAP_01_gmg_F","B_MRAP_01_hmg_F",
	"B_APC_Tracked_01_CRV_F","B_Truck_01_box_F","B_Truck_01_mover_F","C_Offroad_01_F","Land_CargoBox_V1_F","I_APC_tracked_03_cannon_F","I_MBT_03_cannon_F","I_MRAP_03_F ","I_MRAP_03_hmg_F",
	"I_MRAP_03_gmg_F","I_APC_Wheeled_03_cannon_F", "B_T_APC_Tracked_01_CRV_F","B_T_Truck_01_transport_F","B_T_Truck_01_covered_F","B_T_Truck_01_medical_F","B_T_Truck_01_Repair_F",
	"B_T_Truck_01_fuel_F","B_T_Truck_01_ammo_F"];
#endif
#ifdef __OWN_SIDE_INDEPENDENT__
private _d_helilift1_types =["I_MRAP_03_F","I_Truck_02_covered_F","I_Truck_02_transport_F","I_Truck_02_ammo_F","I_Truck_02_box_F","I_Truck_02_medical_F","I_Truck_02_fuel_F",
	"I_APC_Wheeled_03_cannon_F","I_APC_tracked_03_cannon_F","I_MBT_03_cannon_F","I_UGV_01_F","I_UGV_01_rcws_F","I_MRAP_03_hmg_F","I_MRAP_03_gmg_F",
	"C_Offroad_01_F","Land_CargoBox_V1_F"];
#endif
#ifdef __TT__
private _d_heliliftw_types =["B_MRAP_01_F","B_Truck_01_transport_F","B_Truck_01_covered_F","B_Truck_01_ammo_F","B_Truck_01_fuel_F","B_Truck_01_Repair_F","B_Truck_01_medical_F",
	"B_APC_Wheeled_01_cannon_F","B_APC_Tracked_01_rcws_F","B_MBT_01_cannon_F","B_MBT_01_TUSK_F","B_UGV_01_F","B_UGV_01_rcws_F","B_MRAP_01_gmg_F","B_MRAP_01_hmg_F",
	"B_APC_Tracked_01_CRV_F","B_Truck_01_box_F","B_Truck_01_mover_F","C_Offroad_01_F","Land_CargoBox_V1_F","I_APC_tracked_03_cannon_F","I_MBT_03_cannon_F","I_MRAP_03_F ","I_MRAP_03_hmg_F",
	"I_MRAP_03_gmg_F","I_APC_Wheeled_03_cannon_F", "B_T_APC_Tracked_01_CRV_F","B_T_Truck_01_transport_F","B_T_Truck_01_covered_F","B_T_Truck_01_medical_F","B_T_Truck_01_Repair_F",
	"B_T_Truck_01_fuel_F","B_T_Truck_01_ammo_F"];
private _d_helilifte_types = ["C_Offroad_01_F","Land_CargoBox_V1_F","I_APC_tracked_03_cannon_F","I_MBT_03_cannon_F","I_MRAP_03_F ","I_MRAP_03_hmg_F",
	"I_MRAP_03_gmg_F","I_APC_Wheeled_03_cannon_F","O_MRAP_02_F","O_Truck_02_transport_F","O_Truck_02_covered_F","O_Truck_02_Ammo_F","O_Truck_03_ammo_F","O_Truck_02_fuel_F","O_Truck_03_fuel_F","O_Truck_02_box_F",
	"B_APC_Tracked_01_CRV_F","O_Truck_02_medical_F","O_Truck_03_medical_F","O_APC_Wheeled_02_rcws_F","O_APC_Tracked_02_cannon_F","O_APC_Tracked_02_AA_F","O_MBT_02_cannon_F","O_UGV_01_F","O_UGV_01_rcws_F",
	"O_MRAP_02_hmg_F","O_MRAP_02_gmg_F","O_Truck_03_device_F", "B_T_APC_Tracked_01_CRV_F","O_Truck_03_transport_ghex_F","O_T_Truck_03_transport_ghex_F","O_Truck_03_covered_ghex_F","O_T_Truck_03_covered_ghex_F",
	"O_Truck_03_medical_ghex_F","O_Truck_03_repair_ghex_F","O_T_Truck_03_repair_ghex_F","O_Truck_03_fuel_ghex_F","O_T_Truck_03_fuel_ghex_F","O_Truck_03_ammo_ghex_F","O_T_Truck_03_ammo_ghex_F"];
#endif

#ifdef __OWN_SIDE_OPFOR__
private _armor = if (d_LockArmored == 1) then {["B_APC_Tracked_01_AA_F","B_APC_Tracked_01_rcws_F","B_MBT_01_cannon_F","B_MBT_01_arty_F","B_MBT_01_mlrs_F","B_APC_Wheeled_01_cannon_F","B_MBT_01_TUSK_F"]} else {[]};
private _car = if (d_LockCars == 1) then {["B_MRAP_01_gmg_F","B_MRAP_01_hmg_F","B_MRAP_01_F"]} else {[]};
#endif
#ifdef __OWN_SIDE_BLUFOR__
private _armor = if (d_LockArmored == 1) then {["O_MBT_02_arty_F","O_APC_Tracked_02_cannon_F","O_MBT_02_cannon_F","O_APC_Tracked_02_AA_F","O_APC_Wheeled_02_rcws_F"]} else {[]};
private _car = if (d_LockCars == 1) then {["O_MRAP_02_gmg_F","O_MRAP_02_hmg_F","O_MRAP_02_F"]} else {[]};
#endif
#ifdef __OWN_SIDE_INDEPENDENT__
private _armor = if (d_LockArmored == 1) then {["I_APC_Wheeled_03_cannon_F","I_APC_tracked_03_cannon_F","I_MBT_03_cannon_F"]} else {[]};
private _car = if (d_LockCars == 1) then {["I_MRAP_03_F","I_MRAP_03_hmg_F","I_MRAP_03_gmg_F"]} else {[]};
#endif
#ifdef __TT__
private _armor = [];
private _car = [];
#endif

#ifndef __TT__
if !(_armor isEqualTo []) then {_d_helilift1_types append _armor};
if !(_car isEqualTo []) then {_d_helilift1_types append _car};

_d_helilift1_types = _d_helilift1_types apply {toUpper _x};

{
	if (_x select 1 == 0) then {
		_x pushBack _d_helilift1_types
	} else {
		if (_x select 1 == 1) then {
			_x pushBack d_heli_wreck_lift_types
		};
	};
	false
} count d_choppers;
#else
if !(_armor isEqualTo []) then {
	_d_heliliftw_types append _armor;
	_d_helilifte_types append _armor;
};
if !(_car isEqualTo []) then {
	_d_heliliftw_types append _car;
	_d_helilifte_types append _car;
};

_d_heliliftw_types = _d_heliliftw_types apply {toUpper _x};
_d_helilifte_types = _d_helilifte_types apply {toUpper _x};

{
	if (_x select 1 == 0) then {
		_x pushBack _d_heliliftw_types
	} else {
		if (_x select 1 == 1) then {
			_x pushBack d_heli_wreck_lift_types
		};
	};
	false
} count d_choppers_blufor;

{
	if (_x select 1 == 0) then {
		_x pushBack _d_helilifte_types
	} else {
		if (_x select 1 == 1) then {
			_x pushBack d_heli_wreck_lift_types
		};
	};
	false
} count d_choppers_opfor;
#endif

if (!isDedicated && {d_with_ai}) then {
	// additional AI recruit buildings
	// these have to be placed in the editor, give them a var name in the editor
	// only client handling means, no damage handling done for those buildings (contrary to the standard AI hut)
	// example:
	// d_additional_recruit_buildings = [my_ai_building1, my_ai_building2];
	d_additional_recruit_buildings = [];
};

diag_log [diag_frameno, diag_ticktime, time, "Dom x_initcommon.sqf processed"];