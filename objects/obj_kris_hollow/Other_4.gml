// Trigger your drawn path the exact frame they step onto the pavement
if (room == rm_hometown_streets) {
    path_start(pth_kris_walk, 2, path_action_stop, true);
}

if (room == rm_street_north) {
    path_start(kris_pth_susie, 2, path_action_stop, true);
}

// If we have returned to the bedroom for the truce phase
if (room == Room1 && global.truce_phase == 1) {
    // Face down toward the birdcage corner
    facing_direction = 0; 
    
    // Spawn the interactive choice window if it isn't open yet!
    if (!instance_exists(obj_truce_menu)) {
        instance_create_layer(0, 0, "Instances", obj_truce_menu);
    }
}




