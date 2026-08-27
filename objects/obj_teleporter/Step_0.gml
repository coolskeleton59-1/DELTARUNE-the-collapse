// ========================================================
// INTEGRATED TRANSITION MACHINE (STEP EVENT LOCKS)
// ========================================================

// Only calculate math if the teleporter is actively processing a transition!
if (fade_state != 0) {
    fade_alpha += (fade_speed * fade_state);
    fade_alpha = clamp(fade_alpha, 0, 1);
    
    // THRESHOLD A: Screen hits absolute black -> Execute the room warp right now!
    if (fade_alpha == 1 && fade_state == 1) {
        if (room_exists(target_room)) {
            room_goto(target_room);
        }
        // Immediately kick into reverse so it's ready to reveal the room upon arrival!
        fade_state = -1;
    }
    
    // THRESHOLD B: The fade-in reveal is 100% complete inside the new room
    if (fade_alpha == 0 && fade_state == -1) {
        fade_state = 0; // Return to completely idle rest mode
        persistent = false; // Safety reset: stops her from traveling across future maps
    }
}
