// INFANTRY SKILL
// _InfskillSet = [
// 0.15,        // aimingAccuracy
// 0.35,        // aimingShake
// 0.4,        // aimingSpeed
// 0.3,         // spotDistance
// 0.2,        // spotTime
// 1,        // courage
// 1,        // reloadSpeed
// 1,        // commanding
// 1        // general
// ];

// INFANTRY SKILL
_InfskillSet = [
0.15, // aimingAccuracy 
0.5, // aimingShake 
0.35, // aimingSpeed 
0.4, // spotDistance 
0.4, // spotTime 
0.6, // courage 
0.8, // reloadSpeed
0.95, // commanding
0.9 // general
];

// ARMOUR SKILL
_ArmSkillSet = [
0.25,        // aimingAccuracy
0.45,        // aimingShake
0.6,        // aimingSpeed
0.4,         // spotDistance
0.4,        // spotTime
1,        // courage
1,        // reloadSpeed
1,        // commanding
1        // general
];


// LIGHT VEHICLE skill
_LigSkillSet = [
0.15,        // aimingAccuracy
0.25,        // aimingShake
0.4,        // aimingSpeed
0.4,         // spotDistance
0.4,        // spotTime
0.6,        // courage
0.8,        // reloadSpeed
0.9,        // commanding
0.9        // general
];


// HELICOPTER SKILL
_AIRskillSet = [
0.25,        // aimingAccuracy
0.45,        // aimingShake
0.6,        // aimingSpeed
0.4,         // spotDistance
0.4,        // spotTime
0.5,        // courage
0.5,        // reloadSpeed
0.5,        // commanding
0.5        // general
];


// STATIC SKILL
_STAskillSet = [
0.25,        // aimingAccuracy
0.45,        // aimingShake
0.6,        // aimingSpeed
0.4,         // spotDistance
0.4,        // spotTime
1,        // courage
1,        // reloadSpeed
1,        // commanding
1        // general
];

server setvariable ["INFskill",_InfskillSet];
server setvariable ["ARMskill",_InfskillSet];
server setvariable ["LIGskill",_InfskillSet];
server setvariable ["AIRskill",_InfskillSet];
server setvariable ["STAskill",_InfskillSet];