// execVM "scripts\intro_ISIS.sqf"; 

_obj = introCar;
playsound "Islamic_music";

// CREATE CAMERA 
showCinemaBorder true;  
_camera = "camera" CamCreate getPos _obj;
_camera CameraEffect ["internal","back"];
showCinemaBorder true;  
camera = _camera;

// CAR 
_camera camPrepareTarget (_obj modelToWorld [-300.5, -200.9, 1.2]);
_camera camSetTarget _obj;
_camera camSetRelPos [10.5, 8, 1.0];
_camera camPrepareFOV 0.700;
_camera camCommitPrepared 0;
waitUntil {camCommitted _camera};

// CAR CLOSER
_camera camPrepareTarget (_obj modelToWorld [-300.5, -200.9, 1.2]);
_camera camSetTarget _obj;
_camera camSetRelPos [8.25, 6, +0.9];
_camera camPrepareFOV 0.700;
_camera camCommitPrepared 6;
waitUntil {camCommitted _camera};

titleText ["","black out",0.8];  
sleep 0.8; 
titleText ["","black in",0.8];    

// CAR GUNNER 
_camera camPrepareTarget (_obj modelToWorld [-500, -2, +0.1]);
_camera camSetTarget _obj;
_camera camSetRelPos [1, -1.0, 0.3];
_camera camPrepareFOV 0.700;
_camera camCommitPrepared 0;
waitUntil {camCommitted _camera};

// CAR GUNNER MOVING
_camera camPrepareTarget (_obj modelToWorld [-500, -2, +0.1]);
_camera camSetTarget _obj;
_camera camSetRelPos [1, -3.2, 0.3];
_camera camPrepareFOV 0.700;
_camera camCommitPrepared 8;
waitUntil {camCommitted _camera};

0.7 setWindDir 180;
titleText ["","black out",0.8];  
sleep 0.8; 
titleText ["","black in",0.8]; 
1 setWindDir 180;

// CAR FLAG 
_camera camPrepareTarget (_obj modelToWorld [500, -1.2, 0.3]);
_camera camSetTarget _obj;
_camera camSetRelPos [-1.5, -0.8, 0.95];
_camera camPrepareFOV 0.700;
_camera camCommitPrepared 0;
waitUntil {camCommitted _camera};
sleep 7;

// DESTROY CAMERA 
_camera cameraeffect ["terminate","back"];
camdestroy _camera;
titleText ["","black in",10];  

if (true) exitWith {};






