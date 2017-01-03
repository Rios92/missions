
        _polePos = _this select 0;
        _maxRadius = _this select 1;
        _minRadius = _this select 2;
        
        _rndRadius = random _maxRadius;
        
        if (_rndRadius < _minRadius ) then 
        {
                _rndRadius = _rndRadius + _minRadius;
        };
        
        _rndAngle = random 360;
        _x = 0;
        _y = 0;
             
        if (_rndAngle < 90) then
        {
                
                _y = _rndRadius * sin _rndAngle;
                _x = _rndRadius * cos _rndAngle;

        }
        else
        {    
                if (_rndAngle < 180) then
                {
                        _rndAngle = _rndAngle - 90;
                        _y = -(_rndRadius * sin _rndAngle);
                        _x = (_rndRadius * cos _rndAngle);

                }else
                {
                        if (_rndAngle < 270) then 
                        {
                                _rndAngle = _rndAngle - 180;
                                _x = -(_rndRadius * sin _rndAngle);
                                _y = -(_rndRadius * cos _rndAngle);

                        }else
                        {
                                if (_rndAngle < 360) then
                                {
                                        _rndAngle = _rndAngle - 270;
                                        _x = -(_rndRadius * sin _rndAngle);
                                        _y = (_rndRadius * cos _rndAngle);

                                };
                        };    
               };   
        };

        _x = _x + (_polePos select 0);
        _y = _y + (_polePos select 1);
        _result = [_x,_y];
        _fixRndPos = _result findEmptyPosition [1,30];
        if (count _fixRndPos > 0 ) then {_result = _fixRndPos};
                 
        if (true) exitWith {_result};

