// ========================================================
// PERSISTENT USER SETTINGS BOOT SYNCHRONIZER
// ========================================================

// Open the config file safely now that the window is fully active in VRAM!
if (file_exists("config_collapse.ini")) {
    ini_open("config_collapse.ini");
    var _saved_fullscreen = ini_read_real("Settings", "fullscreen", 0);
    ini_close();
    
    // Snaps the screen frame full screen before your intro sequence displays!
    if (_saved_fullscreen == 1) {
        window_set_fullscreen(true);
        surface_resize(application_surface, 640, 480);
        display_reset(0, true);
    }
}


// Lock the user interface rendering grid to your native 640x480 proportions at boot time!
display_set_gui_size(640, 480);

// Lock the baseline tracking state variable to prevent stuttering
last_fullscreen_state = window_get_fullscreen();

