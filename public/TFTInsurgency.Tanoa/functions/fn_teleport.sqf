_leader = leader group _this;
_vehicle = vehicle _leader;

if((_leader getVariable ["BIS_revive_incapacitated", false]) || {!alive _leader}) exitWith { hint "Your leader is down."; };
if(_leader distance2D _this < 150) exitWith { hint "Your leader is too close.\nDon't be so lazy."; };
if((_vehicle != _leader) && {(_vehicle emptyPositions "Commander") + (_vehicle emptyPositions "Driver") + (_vehicle emptyPositions "Gunner") + (_vehicle emptyPositions "Cargo") == 0}) exitWith { hint "There is no space in your leaders vehicle."; };

"tft_tp" cutText ["","BLACK OUT"];
sleep 2;

if(_vehicle == _leader) then {
    _this setPos ((getPos _leader) vectorAdd [(random 10) - 5, (random 10) - 5, 0]);
} else {
    _this moveInAny _vehicle;
};

"tft_tp" cutText ["","BLACK IN"];
