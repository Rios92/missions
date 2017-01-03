_press={
comment "Exported from Arsenal by FriZY";

comment "Remove existing items";
removeAllWeapons this;
removeAllItems this;
removeAllAssignedItems this;
removeUniform this;
removeVest this;
removeBackpack this;
removeHeadgear this;
removeGoggles this;

comment "Add containers";
this forceAddUniform "U_C_Journalist";
this addItemToUniform "FirstAidKit";
this addItemToUniform "Chemlight_green";
this addVest "V_Press_F";
this addItemToVest "SmokeShell";
this addItemToVest "SmokeShellGreen";
this addItemToVest "Chemlight_green";

comment "Add weapons";

comment "Add items";

comment "Set identity";
this setFace "WhiteHead_20";
this setSpeaker "Male01ENGVR";

};

if (true) exitWith {_press};
