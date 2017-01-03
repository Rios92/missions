// ["killed", a1] execVM "scripts\sound_allah.sqf"; a1 say3D "alah1"
_soundARRAY=["Allah_Akbar1","Allah_Akbar2","Allah_Akbar3","Allah_Akbar4","Allah_Akbar5"];
_soundPath = [(str missionConfigFile), 0, -15] call BIS_fnc_trimString;
_speaker=objNull;

if (_this select 0 == "killed" && side (_this select 1) == east) then
{
	if (floor random 10 >= 8) then
	{
		_speaker = _this select 1;
		_sound =_soundARRAY select (floor random count _soundARRAY);
		_soundToPlay = _soundPath + "sound\" + _sound + ".ogg";
		playSound3D [_soundToPlay,_speaker,false];
		["sound_allah.sqf",2,format ["Killed / Sound: %1 Who: %2",_soundToPlay,_speaker]] spawn FFS_FNC_log;
	};
}else{
	while {alive server} do
	{
		_speaker=objNull;
		{
			if (side _x == east && player distance _x < 50) then
			{
				_speaker=_x;
			};
		} count allUnits;
		if (!isNull _speaker) then
		{	
			if ((floor random 10 >= 8) and (behaviour _speaker == "COMBAT" or behaviour _speaker == "STEALTH")) then
			{
				_sound =_soundARRAY select (floor random count _soundARRAY);
				_soundToPlay = _soundPath + "sound\" + _sound + ".ogg";
				playSound3D [_soundToPlay,_speaker,false];
				sleep 600;
				["sound_allah.sqf",2,format ["Loop / Sound: %1 Who: %2",_soundToPlay,_speaker]] spawn FFS_FNC_log;
			};
		};
		sleep 600;
	};
};

if (true) exitWith {};











