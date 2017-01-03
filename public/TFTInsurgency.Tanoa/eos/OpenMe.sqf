EOS_Spawn = compile preprocessfilelinenumbers "eos\core\eos_launch.sqf";Bastion_Spawn=compile preprocessfilelinenumbers "eos\core\b_launch.sqf";null=[] execVM "eos\core\spawn_fnc.sqf";onplayerConnected {[] execVM "eos\Functions\EOS_Markers.sqf";};
/* EOS 1.98 by BangaBob 
GROUP SIZES
 0 = 1
 1 = 2,4
 2 = 4,8
 3 = 8,12
 4 = 12,16
 5 = 16,20

EXAMPLE CALL - EOS
 null=[["M1","M2","M3"],
 [HOUSE GROUPS,SIZE OF GROUPS,PROBABILITY],
 [PATROL GROUPS,SIZE OF GROUPS,PROBABILITY],
 [LIGHT VEHICLES,SIZE OF CARGO,PROBABILITY],
 [ARMOURED VEHICLES,PROBABILITY], 
 [STATIC VEHICLES,PROBABILITY],
 [HELICOPTERS,SIZE OF HELICOPTER CARGO,PROBABILITY],
 [0,0,<SPAWN DISTANCE>,EAST,TRUE, FALSE]] call EOS_Spawn;
 null = [["MARKERNAME","MARKERNAME2"],[2,1,70],[0,1],[1,2,30],[2,60],[2],[1,0,10],[1,0,250,WEST]] call EOS_Spawn;
*/
VictoryColor="colorGreen";	// Colour of marker after completion
hostileColor="colorRed";	// Default colour when enemies active
bastionColor="colorOrange";	// Colour for bastion marker
EOS_DAMAGE_MULTIPLIER=1;	// 1 is default
EOS_KILLCOUNTER=false;		// Counts killed units

//House x1, small group
null = [["EOS_square_1", "EOS_square_2", "EOS_square_4", "EOS_square_5", "EOS_square_6", "EOS_square_39", "EOS_square_36", "EOS_square_58",
         "EOS_square_61", "EOS_square_64", "EOS_square_76", "EOS_square_77", "EOS_square_106", "EOS_square_118", "EOS_square_119", "EOS_square_138",
         "EOS_square_138", "EOS_square_140", "EOS_square_144", "EOS_square_145", "EOS_square_151", "EOS_square_169", "EOS_square_190", "EOS_square_191", 
         "EOS_square_192", "EOS_square_193", "EOS_square_194", "EOS_square_176"],
        [3,1,95],[0,0,0],[0,0,0],[0,0],[0,0],[0,0,0],[0,0,500,EAST,TRUE, FALSE]] call EOS_Spawn; 
//House <=4, Med group
null = [["EOS_square_0", "EOS_square_7", "EOS_square_8", "EOS_square_10", "EOS_square_13", "EOS_square_78", "EOS_square_23",
         "EOS_square_27", "EOS_square_42", "EOS_square_43", "EOS_square_44", "EOS_square_45", "EOS_square_53", "EOS_square_57", "EOS_square_68", 
         "EOS_square_70", "EOS_square_73", "EOS_square_78", "EOS_square_80", "EOS_square_84", "EOS_square_88", "EOS_square_89", "EOS_square_92",
         "EOS_square_94", "EOS_square_96", "EOS_square_98", "EOS_square_100", "EOS_square_103", "EOS_square_105", "EOS_square_141", "EOS_square_144",
         "EOS_square_145", "EOS_square_151", "EOS_square_74", "EOS_square_171", "EOS_square_194"],
        [3,2,95],[0,0,0],[0,0,0],[0,0],[0,0],[0,0,0],[0,0,500,EAST,TRUE, FALSE]] call EOS_Spawn; 
//Patrol x1, small group
null = [["EOS_square_0", "EOS_square_1", "EOS_square_15", "EOS_square_19", "EOS_square_21", "EOS_square_29", "EOS_square_36", "EOS_square_39", 
         "EOS_square_34", "EOS_square_35", "EOS_square_48", "EOS_square_50", "EOS_square_51", "EOS_square_54", "EOS_square_62", "EOS_square_65",
         "EOS_square_66", "EOS_square_69", "EOS_square_77", "EOS_square_79", "EOS_square_80", "EOS_square_81", "EOS_square_86", "EOS_square_85",
         "EOS_square_91", "EOS_square_110", "EOS_square_111", "EOS_square_99", "EOS_square_106", "EOS_square_112", "EOS_square_115", "EOS_square_116",
         "EOS_square_121", "EOS_square_122", "EOS_square_123", "EOS_square_124", "EOS_square_125", "EOS_square_126", "EOS_square_127", "EOS_square_128",
         "EOS_square_129", "EOS_square_130", "EOS_square_131", "EOS_square_132", "EOS_square_133", "EOS_square_134", "EOS_square_135", "EOS_square_137",
         "EOS_square_138", "EOS_square_139", "EOS_square_140", "EOS_square_141", "EOS_square_159", "EOS_square_160", "EOS_square_161", "EOS_square_162", 
         "EOS_square_163", "EOS_square_164", "EOS_square_169", "EOS_square_170", "EOS_square_171", "EOS_square_173", "EOS_square_174", "EOS_square_175",
         "EOS_square_178", "EOS_square_179", "EOS_square_180", "EOS_square_181", "EOS_square_182", "EOS_square_183", "EOS_square_184", "EOS_square_185",
         "EOS_square_187", "EOS_square_188", "EOS_square_213", "EOS_square_214", "EOS_square_215", "EOS_square_216", "EOS_square_209", "EOS_square_210", 
         "EOS_square_76", "EOS_square_177"],
        [0,0,0],[3,1,95],[0,0,0],[0,0],[0,0],[0,0,0],[0,0,500,EAST,TRUE, FALSE]] call EOS_Spawn; 
//Patrol x1, Med group
null = [["EOS_square_4", "EOS_square_3", "EOS_square_9", "EOS_square_17", "EOS_square_18", "EOS_square_20", "EOS_square_24", "EOS_square_30",
         "EOS_square_32", "EOS_square_33", "EOS_square_41", "EOS_square_46", "EOS_square_52", "EOS_square_53", "EOS_square_71", "EOS_square_76", 
         "EOS_square_82", "EOS_square_93", "EOS_square_195", "EOS_square_198", "EOS_square_199", "EOS_square_200", "EOS_square_201", "EOS_square_202", 
         "EOS_square_203", "EOS_square_206", "EOS_square_207", "EOS_square_208", "EOS_square_211", "EOS_square_212"],
        [0,0,0],[2,2,95],[0,0,0],[0,0],[0,0],[0,0,0],[0,0,500,EAST,TRUE, FALSE]] call EOS_Spawn; 
//Patrol x2, small group
null = [["EOS_square_12", "EOS_square_14", "EOS_square_16", "EOS_square_25", "EOS_square_38", "EOS_square_49", "EOS_square_55", "EOS_square_59", 
         "EOS_square_60", "EOS_square_72", "EOS_square_73", "EOS_square_75", "EOS_square_83", "EOS_square_88", "EOS_square_97", "EOS_square_100",
         "EOS_square_102", "EOS_square_107", "EOS_square_108", "EOS_square_108", "EOS_square_113", "EOS_square_120", "EOS_square_144", "EOS_square_145",
         "EOS_square_147", "EOS_square_148", "EOS_square_149", "EOS_square_109"],
        [0,0,0],[4,1,95],[0,0,0],[0,0],[0,0],[0,0,0],[0,0,500,EAST,TRUE, FALSE]] call EOS_Spawn; 
//Patrol x2, Med group
null = [["EOS_square_10", "EOS_square_26", "EOS_square_42", "EOS_square_43", "EOS_square_67", "EOS_square_78", "EOS_square_90", "EOS_square_94",
         "EOS_square_95", "EOS_square_103", "EOS_square_104", "EOS_square_105", "EOS_square_117", "EOS_square_136", "EOS_square_146", "EOS_square_150",
         "EOS_square_151", "EOS_square_152", "EOS_square_153", "EOS_square_154", "EOS_square_156", "EOS_square_157", "EOS_square_158", "EOS_square_165",
         "EOS_square_11", "EOS_square_166", "EOS_square_167", "EOS_square_168", "EOS_square_172", "EOS_square_186", "EOS_square_189", "EOS_square_191",
         "EOS_square_194", "EOS_square_196", "EOS_square_197", "EOS_square_204", "EOS_square_205"],
        [0,0,0],[3,2,95],[0,0,0],[0,0],[0,0],[0,0,0],[0,0,500,EAST,TRUE, FALSE]] call EOS_Spawn; 
//Light Vic 
null = [["EOS_square_16", "EOS_square_20", "EOS_square_22", "EOS_square_28", "EOS_square_31", "EOS_square_40", "EOS_square_47",
         "EOS_square_50", "EOS_square_51", "EOS_square_56", "EOS_square_61", "EOS_square_67", "EOS_square_73", "EOS_square_78", "EOS_square_87",
         "EOS_square_88", "EOS_square_94", "EOS_square_101", "EOS_square_103", "EOS_square_105", "EOS_square_114", "EOS_square_117", "EOS_square_142",
         "EOS_square_155", "EOS_square_172", "EOS_square_195", "EOS_square_196"],
        [0,0,0],[0,0,0],[2,1,95],[0,0],[0,0],[0,0,0],[0,0,800,EAST,TRUE, FALSE]] call EOS_Spawn; 
//Light Vic x2
null = [["EOS_square_9", "EOS_square_37", "EOS_square_63", "EOS_square_130", "EOS_square_150", "EOS_square_180", "EOS_square_189", "EOS_square_207"],
        [0,0,0],[0,0,0],[3,1,95],[0,0],[0,0],[0,0,0],[0,0,800,EAST,TRUE, FALSE]] call EOS_Spawn; 
//Heavy Vic x1
null = [["EOS_square_4", "EOS_square_104", "EOS_square_120", "EOS_square_143", "EOS_square_199", "EOS_square_196"],
        [0,0,0],[0,0,0],[0,0,0],[0,0],[1,95],[0,0,0],[0,0,800,EAST,TRUE, FALSE]] call EOS_Spawn; 
//HELICOPTERS
null = [["EOS_square_0", "EOS_square_9", "EOS_square_56", "EOS_square_72", "EOS_square_104", "EOS_square_121", "EOS_square_146", "EOS_square_172",
         "EOS_square_189"],
        [0,0,0],[0,0,0],[0,0,0],[0,0],[0,0],[1,3,90],[0,0,1500,EAST,TRUE, FALSE]] call EOS_Spawn; 
 
