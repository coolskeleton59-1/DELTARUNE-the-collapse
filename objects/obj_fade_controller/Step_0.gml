// 1. Adjust alpha up or down depending on whether we are fading out or fading in
fade_alpha += (fade_speed * fade_state);
fade_alpha = clamp(fade_alpha, 0, 1);

// 2. Handle Peak Blackout Condition (Screen is fully black)
if (fade_alpha >= 1 && fade_state == 1) 
{
    // --- PLAY THE DELTARUNE-STYLE TRANSITION SOUND ---
    if (!audio_is_playing(snd_room_transition)) 
    {
        // Plays the sound asset once, at maximum priority, and does not loop (false)
        audio_play_sound(snd_room_transition, 10, false);
    }

    // Go to the requested target room if one was assigned
    if (room_exists(target_room)) 
    {
        room_goto(target_room);
    }
    
    // Switch state to start Fading In to the new room
    fade_state = -1; 
}

// 3. Handle Fade Completed Condition (Screen is fully transparent again)
if (fade_alpha <= 0 && fade_state == -1) 
{
 // Handle Fade Completed Condition (Screen is fully transparent again)
if (fade_alpha <= 0 && fade_state == -1) 
{
    global.game_frozen = false; // Unfreeze the player!
    instance_destroy(); 
}
}

