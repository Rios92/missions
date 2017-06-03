message = "SCORE";
hintText = hintText + message + "\n";
publicVariable "message";
message remoteExec ["systemChat", 0, true];

timer = round(serverTime - timer);
publicVariable "timer";
message = str(timer) + " seconds elapsed: -" + str(timer);
hintText = hintText + message + "\n";
message remoteExec ["systemChat", 0, true];
timer = -1 * timer;

if (vip_1 inArea "marker_safe") then {
	timer = timer + 1000;
	message = "VIP secured: +1000";
	hintText = hintText + message + "\n";
	message remoteExec ["systemChat", 0, true];
};

if (vip_2 inArea "marker_safe") then {	
	timer = timer + 500;
	message = "Bodyguard secured: +500";
	hintText = hintText + message + "\n";
	message remoteExec ["systemChat", 0, true];
};

if (vip_3 inArea "marker_safe") then {
	timer = timer + 500;
	message = "Bodyguard secured: +500";
	hintText = hintText + message + "\n";
	message remoteExec ["systemChat", 0, true];
};

civCount = count (allDead select {side group _x == CIVILIAN;});
timer = timer - (civCount * 200);
message = str(civCount) + " civilians killed: -" + str(civCount * 200);
hintText = hintText + message + "\n";
message remoteExec ["systemChat", 0, true];

enemyCount = count (allUnits select {side _x == EAST;});
timer = timer - (enemyCount * 100);
message = str(enemyCount) + " enemies remaining: -" + str(enemyCount * 100);
hintText = hintText + message + "\n";
message remoteExec ["systemChat", 0, true];

message = "Final Score: " + str(timer);
hintText = hintText + message + "\n";
message remoteExec ["systemChat", 0, true];

hintText remoteExec ["hint", 0, true];
