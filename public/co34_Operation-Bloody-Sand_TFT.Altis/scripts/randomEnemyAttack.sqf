//[] execVM "scripts\randomEnemyAttack.sqf";
_size = 100;
_target = [16196.2,16927.6,0];
_sleep = 600 + random 600;
sleep _sleep;
waitUntil {!isNil "FFS_FNC_crateVehsPatrol"};

["east",1,[18521.7,17978.2,0],_target,_size,0,game_difficulty,"ISIS_AT"] call FFS_FNC_crateVehsPatrol; 
sleep 25;
["east",1,[18530.4,17976.5,0],_target,_size,0,game_difficulty,"ISIS"] call FFS_FNC_crateVehsPatrol; 
sleep 3;
["east",1,[18544,17974.9,0],_target,_size,0,game_difficulty,"ISIS"] call FFS_FNC_crateVehsPatrol; 

if (logging_mode) then {["randomEnemyAttack.sqf",2,format ["randomEnemyAttack finished / sleep: %2 / target: %1 ",_target,_sleep]] spawn FFS_FNC_log;};
if (true) exitWith {};


