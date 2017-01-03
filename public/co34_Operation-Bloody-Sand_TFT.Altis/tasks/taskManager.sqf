
//-----------   I N I T I A L I Z A T I O N  -----------------
_wait = 15;
obj0 = player createSimpleTask ["Wait for orders"];
/*
TASK1: Clear Rodopoli town
TASK2: Clear Charika town [A]
TASK3: Clear Dorina town
TASK4: Clear Pyrgos town
TASK5: Kill leader and clear Chalkeia town
TASK6: Clear and rescue hostages near Charika  [A]
TASK7: Rescue U.S. reporter
TASK8: Find and destroy ammo boxes
TASK9: Transport 6 boxes to AAF base
*/
if (isServer) then 
{
	Task_List = [1,3,4,5,7,8,9] + [[2,6] select (floor random 2)];
	TaskArray = [];
	TaskArray = Task_List call bis_fnc_arrayShuffle;
	TaskArray resize numTasks;
	//TaskArray = [7,1];
	publicVariable "TaskArray";
	if (logging_mode) then {["taskManager.sqf",2,format ["TaskArray: %1",TaskArray]] spawn FFS_FNC_log;};
	if (!isMultiplayer) then {waituntil {IntroFinish};};
}else{
	waituntil {IntroFinish};
};
sleep 10;

if (isNil "TaskArray") then
{
  ["taskManager.sqf",16,format ["ERROR: taskArray is not defined so far (%1) - waiting for variable!!!",time]] spawn FFS_FNC_log;
  waitUntil {!isNil "TaskArray"};
  ["taskManager.sqf",2,format ["TaskArray is updated (%1) / TaskArray: %2 !!!",time,TaskArray]] spawn FFS_FNC_log;
};

//-----------  S T A R T  -----------------
{
	if (!((call compile format ["status%1P",_x] == "DONE") or (call compile format ["status%1P",_x] == "FAILED"))) then
	{ 
		sleep _wait; 
	};
	if(obj0 in simpleTasks player) then 
	{
		player removeSimpleTask obj0;
	};
	call compile format ["_script_handler = execVM ""tasks\task%1P.sqf""",_x];

	waituntil {(call compile format ["status%1P",_x] == "DONE") or (call compile format ["status%1P",_x] == "FAILED")};
} forEach TaskArray;

//-----------  E N D  -----------------
sleep 10;
_text=format [" *****  %1  ***** ",getText (missionconfigfile >> "onLoadName")];
titleText [_text,"PLAIN",2];
playMusic ["Track03_OnTheRoad", 23.5];0 fadeMusic 0.6;
sleep 25;

titleText [" M i s s i o n   b y   \n\n FF Studio","black out",2];
9 fadeMusic 0;
sleep 6;
titleText ["","black in"];
sleep 3;
if (logging_mode) then {["taskManager.sqf",2,"MISSION COMPLETED"] spawn FFS_FNC_log;};

"endMission1" call BIS_fnc_endMission;