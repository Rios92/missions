// execVM "scripts\missionInfo.sqf";

_cnt = count allunits;
_cntWest = west countSide allunits;
_cntEast = east countSide allunits;
_cntRes = resistance countSide allunits;
_cntCiv = civilian countSide allunits;
_cntGRP = count allGroups;
_cntVeh = count vehicles;
_cntDead = count allDead;
_FPS = diag_fps;
  
hint format ["ALL UNITS: %1\n\nWEST: %2\n\nEAST: %3\n\nGUER: %4\n\nCIV: %5\n\nGROUPS: %6/151\n\nVEHICLES: %7\n\nDEADS: %8\n\nFPS: %9",_cnt,_cntWest,_cntEast,_cntRes,_cntCiv,_cntGRP,_cntVeh,_cntDead,_FPS];


if (true) exitWith {};