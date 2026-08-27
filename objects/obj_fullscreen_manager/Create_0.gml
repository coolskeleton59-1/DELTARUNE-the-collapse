// 1 = Slot 1, 2 = Slot 2, 3 = Slot 3
global.active_save_slot = 1; 

// ========================================================
// 2026 LTS STABLE FULLSCREEN INITIALIZATION (60 FPS SESSION-LOCKED)
// ========================================================
last_fullscreen_state = window_get_fullscreen();
target_width = 640;
target_height = 480;

// 1. FORCE HIGH-PERFORMANCE 60 FPS MICROSECOND CONTROL
// Clamps each frame calculation to exactly 16,666 microseconds, banishing the 30fps slowness!
game_set_speed(16666, gamespeed_microseconds); 

// 2. RE-ENFORCE FOCUS-SAFE WINDOWS TIMING HOOKS
display_set_timing_method(tm_countvsyncs_winalt);
display_set_sleep_margin(10); 

// 3. Initial Boot Hardware Buffer Synchronizer
alarm = 3;
// Global array to hold picked-up item IDs (starts empty)
global.inventory = [];


