params ["_num"];

tft_dnd_points = tft_dnd_points + _num;
((uiNamespace getVariable "TFID_ScoreDialog") displayCtrl 1506) ctrlsetText (str tft_dnd_points);
