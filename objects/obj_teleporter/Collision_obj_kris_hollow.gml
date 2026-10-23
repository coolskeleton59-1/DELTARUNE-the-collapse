// 1. Immediately cancel Kris's active walk movement
with (obj_kris_hollow) {
    path_end(); 
}

// 2. Spawn your custom fade transition controller
if (!instance_exists(obj_fade_controller)) {
    var _fade = instance_create_layer(0, 0, "Instances", obj_fade_controller);
    
    // PASS ALL THREE VARIABLES DOWN THE PIPELINE TO STOP THE STEP CRASH!
    _fade.target_room = target_room;
    _fade.target_x = target_x; // Hands the coordinates over to the fade script
    _fade.target_y = target_y;
}




