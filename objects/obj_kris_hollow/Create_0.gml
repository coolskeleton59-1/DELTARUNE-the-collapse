// MASTER CUTSCENE TRACKER (Add this to the absolute top!)
kris_state = 1; 

// 0 = Right, 1 = Up, 2 = Left, 3 = Down
face_direction = 3; 

//  CORRECT (Notice the index brackets!)
sprite_walk[0] = spr_kris_walk_right;
sprite_walk[1] = spr_kris_walk_up;
sprite_walk[2] = spr_kris_walk_left;
sprite_walk[3] = spr_kris_walk_down;


// 1. Initialize his regular local variables
vspeed = 0;
hspeed = 0;
facing_direction = 0;

// 2. Read the global variable safely initialized by our script file!
if (global.truce_phase == 0) {
    alarm = 120; // 2-second intro countdown timer
    vspeed = 2;  // Walk down out the door
} 
// If we have returned home for the truce, stay completely frozen!
else {
    vspeed = 0;
    hspeed = 0;
}

// TRAIL QUEUE FOR THE FOLLOWER OBJECT
kris_history_x = ds_list_create();
kris_history_y = ds_list_create();


