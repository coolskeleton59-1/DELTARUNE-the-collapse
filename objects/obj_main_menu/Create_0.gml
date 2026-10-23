// ========================================================
// FRONTEND BUFFER HOUSECLEANING (ANTI-HITCHHIKER PURGE)
// ========================================================
if (room == rm_main_menu) {
    // Forcefully delete any persistent overworld follower assets 
    // that leaked into the main menu space during a skip or reset!
    if (instance_exists(obj_noelle_follower)) {
        instance_destroy(obj_noelle_follower);
    }

    if (instance_exists(obj_susie_follower)) {
        instance_destroy(obj_susie_follower);
    }
}

// 1. FRONTEND STATE ENGINE MACHINE
enum menu_states {
    main_options,
    config_panel,
    controls_view,
    save_slots // Multi-slot state included
}
current_state = menu_states.main_options;
menu_index = 0;
slot_menu_mode = "new_game";

// 2. MULTI-SLOT GLOBAL SWEEP LAYER
can_continue = false;

// Scan if Slot 1, Slot 2, OR Slot 3 are alive on the hard drive
for (var s = 1; s <= 3; s++) {
    var _check_file = "save_collapse_slot_" + string(s) + ".ini";
    if (file_exists(_check_file)) {
        can_continue = true;
        break; // Stop looking once at least one file is found!
    }
}

// Default fallbacks to prevent undefined values if no files are found
save_room_display = Room1;
save_lv_display   = "0";
save_time_display = "0:00";

// If save files exist, look inside the first valid one to show preview data on the title box
if (can_continue) {
    var _preview_file = "save_collapse_slot_1.ini";
    
    // Fallback path tracking: If slot 1 doesn't exist, preview slot 2, then slot 3
    if (!file_exists(_preview_file)) {
        if (file_exists("save_collapse_slot_2.ini")) _preview_file = "save_collapse_slot_2.ini";
        else if (file_exists("save_collapse_slot_3.ini")) _preview_file = "save_collapse_slot_3.ini";
    }
    
    // OPEN THE SELECTED PREVIEW FILE TARGET
    ini_open(_preview_file); 
    
    // Read the room name as a pure text string!
    var _room_string = ini_read_string("Location", "saved_room", "Room1");
    
    // Convert that string name into the real internal GameMaker asset index number!
    save_room_display = asset_get_index(_room_string);
    
    // Double check fail-safe: if the asset name isn't found, default safely to Room1
    if (save_room_display == -1) {
        save_room_display = Room1;
    }
    
    // Clean up text naming values for display presentation mapping
    if (_room_string == "Room1") save_room_display = "Kris's Bedroom";
    if (_room_string == "rm_kris_hallway") save_room_display = "The Hallway";
    if (_room_string == "rm_kris_driveway") save_room_display = "The Driveway";
    if (_room_string == "rm_hometown_streets_gameplay") save_room_display = "Hometown Streets";
    if (_room_string == "rm_street_north_gameplay") save_room_display = "Hometown Streets";
    if (_room_string == "rm_dark_world_entrance") save_room_display = "Dark World Entrance";
    
    // Read statistics safely while the file buffer is officially open
    save_lv_display   = string(ini_read_real("Stats", "player_lv", 0)); 
    
    var _raw_time     = ini_read_real("Story", "time_played", 0);
    var _minutes      = floor(_raw_time / 60);
    var _seconds      = _raw_time % 60;
    var _sec_string   = string(_seconds);
    if (_seconds < 10) _sec_string = "0" + _sec_string;
    
    save_time_display = string(_minutes) + ":" + _sec_string;
    
    // Crucial closure loop: close the file to release memory cache bounds
    ini_close(); 
}

// 3. AIRTIGHT AUDIO MANAGEMENT
global.music_volume = 80;
global.sound_volume = 80;

// Open or create the config specific INI file
if (file_exists("config_collapse.ini")) {
    ini_open("config_collapse.ini");
    global.music_volume = ini_read_real("Settings", "music", 80);
    global.sound_volume = ini_read_real("Settings", "sound", 80);
    ini_close();
} else {
    // Write defaults if no file exists yet
    ini_open("config_collapse.ini");
    ini_write_real("Settings", "music", global.music_volume);
    ini_write_real("Settings", "sound", global.sound_volume);
    ini_write_real("Settings", "fullscreen", window_get_fullscreen() ? 1 : 0);
    ini_close();
}

// Apply theme track parameters
if (room == rm_main_menu) {
    if (!audio_is_playing(snd_menu_theme)) {
        menu_music_channel = audio_play_sound(snd_menu_theme, 10, true, global.music_volume / 100, 0.0, 1.0);
    } else {
        menu_music_channel = -1;
        audio_sound_gain(snd_menu_theme, global.music_volume / 100, 0);
    }
}

// 4. COSMIC BACKGROUND PARTICLE GENERATOR
if (room == rm_main_menu) {
    for (var i = 0; i < 20; i++) {
        star_x[i] = irandom_range(10, 630);
        star_y[i] = irandom_range(10, 470);
        star_speed[i] = random_range(0.2, 0.8); 
    }
}

// Initialize the soul's sliding tracking position
soul_y = 284; 
soul_x = 210; 
// Local variables to handle smooth screen-to-screen transitions
menu_fade_alpha = 1.0;
last_menu_state = menu_states.main_options; 







