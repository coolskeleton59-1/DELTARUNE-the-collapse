// MASTER PARTY FOLLOWER PHYSICS
if (instance_exists(obj_kris_hollow)) {
    
    var _history_size = ds_list_size(obj_kris_hollow.kris_history_x);
    var _follow_delay = 60; // The physical distance/lag between Kris and Susie's heels
    
    // 1. POSITION SNAPPING
    if (_history_size > _follow_delay) {
        x = ds_list_find_value(obj_kris_hollow.kris_history_x, _follow_delay);
        y = ds_list_find_value(obj_kris_hollow.kris_history_y, _follow_delay);
        
        // 2. DIRECTION AND ANIMATION TRACKING
        if (x != xprevious || y != yprevious) {
            image_speed = 0.25; // Play walk animation if moving
            
            // Calculate absolute moving angle to figure out her face direction
            var _dir = point_direction(xprevious, yprevious, x, y);
            
            if (_dir >= 315 || _dir < 45)  face_direction = 0; // Right
            if (_dir >= 45  && _dir < 135) face_direction = 1; // Up
            if (_dir >= 135 && _dir < 225) face_direction = 2; // Left
            if (_dir >= 225 && _dir < 315) face_direction = 3; // Down
            
            // Swap out her index sprites dynamically!
            sprite_index = sprite_walk[face_direction];
        } else {
            image_speed = 0; // Stand completely still if Kris halts his feet!
            image_index = 0; 
        }
    }
}

// ========================================================
// CONDITIONAL PARTY TRAVERSAL GATES (PERSISTENT CHECKER)
// ========================================================

// 1. MONITOR TIMELINE: Activate persistence ONLY when the truce phase is over 2!
if (variable_global_exists("truce_phase") && global.truce_phase > 2) {
    persistent = true; // Noelle will now survive room transitions and stay in the party queue!
} else {
    persistent = false; // Safety fallback: She resets to a standard local room asset
}

