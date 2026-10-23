// ========================================================
// AUTOMATED RESOLUTION RE-SYNC & PERFECT BORDER CLAMP
// ========================================================
var _current_fullscreen = window_get_fullscreen();

// DETECT STATE TRANSITION: Catches the exact frame the window border snaps!
if (_current_fullscreen != last_fullscreen_state) {
    
    // 1. Give GameMaker a brief window to process operating system display drivers safely
    display_reset(0, true);
    
    // 2. FORCE COMPLETE INTEGERS SCALE SURFACE BUFFERING
    surface_resize(application_surface, target_width, target_height);
    
    // 3. PIXEL-PERFECT BORDER FIX: Anchor the GUI layer firmly to a 640x480 resolution matrix!
    // This stops the border from splitting into mini-lines while keeping coordinates visible!
    display_set_gui_size(640, 480);
    
    // 4. RE-ENFORCE UN-THROTTLED 60 FPS TIMING HOOKS
    game_set_speed(16666, gamespeed_microseconds);
    display_set_timing_method(tm_countvsyncs_winalt);
    display_set_sleep_margin(10);
    
    // 5. Update tracking state variables
    last_fullscreen_state = _current_fullscreen;
}

// ========================================================
// CINEMATIC PORTAL REVEAL FADER
// ========================================================

if (variable_global_exists("start_portal_fade_in") && global.start_portal_fade_in == true) {
    if (global.screen_fade_alpha > 0) {
        // Slowly reduce transparency by a tiny fraction each frame loop
        global.screen_fade_alpha -= 0.02; 
    } else {
        // Once the screen is fully visible, turn off the tracking switch safely!
        global.start_portal_fade_in = false; 
    }
}




