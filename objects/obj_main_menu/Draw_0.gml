draw_set_alpha(menu_fade_alpha);
for (var i = 0; i < 20; i++) {
    draw_set_color(c_dkgray);
    draw_rectangle(star_x[i], star_y[i], star_x[i] + 2, star_y[i] + 2, false);
}

draw_set_halign(fa_center);
draw_set_font(fnt_logo);
draw_set_color(c_purple);
draw_text(320, 60, "DELTARUNE: THE COLLAPSE");

draw_set_font(fnt_menu_sub);
draw_set_color(c_gray);
draw_text(320, 105, "ACT ONE — THE BEGINNING AND THE END");

// 2. DYNAMIC STATE INTERFACE LAYER RENDERER
switch (current_state) {
    
    case menu_states.main_options:
	
        draw_set_halign(fa_left);
        draw_set_color(c_white);
        draw_rectangle(90, 135, 550, 250, true); 

        draw_set_color(c_ltgray);
        draw_text(115, 150, "PLAYER: KRIS");
        draw_text(390, 150, "LV: " + save_lv_display); 
        draw_set_color(c_yellow);
        // Display the actual room name or room number index safely
        draw_text(115, 182, "LOCATION: " + string(save_room_display)); 
        draw_set_color(c_ltgray);
        draw_text(115, 214, "TIME: " + save_time_display);

        draw_set_halign(fa_center);
        var _options = ["NEW GAME", "CONTINUE", "CONFIG", "CONTROLS"];
        for (var i = 0; i < 4; i++) {
            if (i == 1 && !can_continue) draw_set_color(c_dkgray);
            else if (menu_index == i) draw_set_color(c_yellow);
            else draw_set_color(c_white);
            draw_text(320, 280 + (i * 40), _options[i]);
        }

        var _heart_y = 284 + (menu_index * 40);
if (sprite_exists(spr_soul)) draw_sprite(spr_soul, 0, soul_x, soul_y);


        break;
        
    case menu_states.config_panel:
	        // --- INSIDE CURRENT_STATE == MENU_STATES.CONFIG_PANEL ---
        // Force the drawing opacity filter to follow our smooth blender variable
        draw_set_alpha(menu_fade_alpha);
        
        draw_set_halign(fa_center);
        draw_set_color(c_purple);
        draw_text(320, 140, "--- CONFIGURATION SETTINGS ---");
        
        // ... [Leave your existing volume bar and fullscreen drawing lines completely untouched here!] ...
        
        // CRUCIAL HOUSECLEANING: Reset the global drawing transparency back to 100% 
        // at the very end of the case line so it doesn't accidentally bleed onto your background stars!
      
        
        draw_set_halign(fa_left);
        
        // Row 0: Music
        if (menu_index == 0) draw_set_color(c_yellow); else draw_set_color(c_white);
        draw_text(100, 190, "MUSIC VOLUME: " + string(global.music_volume) + "%");
        draw_rectangle(380, 196, 380 + (global.music_volume * 1.5), 206, false);
        draw_rectangle(380, 196, 530, 206, true);
        
        // Row 1: SFX
        if (menu_index == 1) draw_set_color(c_yellow); else draw_set_color(c_white);
        draw_text(100, 240, "SOUND VOLUME: " + string(global.sound_volume) + "%");
        draw_rectangle(380, 246, 380 + (global.sound_volume * 1.5), 256, false);
        draw_rectangle(380, 246, 530, 256, true);
        
        // Row 2: GRAPHICAL SCREEN DISPLAY TOGGLE
        if (menu_index == 2) draw_set_color(c_yellow); else draw_set_color(c_white);
        var _disp_text = window_get_fullscreen() ? "FULLSCREEN" : "WINDOWED MODE";
        draw_text(100, 290, "DISPLAY MODES: [ " + _disp_text + " ]");
        
        // Row 3: Return
        draw_set_halign(fa_center);
        if (menu_index == 3) draw_set_color(c_yellow); else draw_set_color(c_white);
        draw_text(320, 360, "[ BACK TO LAUNCHER ROOT ]");
        
        // Handle heart icon heights inside configuration lines
        var _conf_y = (menu_index == 3) ? 364 : 194 + (menu_index * 50);
        // --- INSIDE CURRENT_STATE == MENU_STATES.CONFIG_PANEL ---
// Replace the old configuration heart location drawing line with this:
var _conf_x = (menu_index == 3) ? 170 : 70;
if (sprite_exists(spr_soul)) draw_sprite(spr_soul, 0, soul_x, soul_y);

    draw_set_alpha(1.0);
        break;
        
    case menu_states.controls_view:
     // --- INSIDE CURRENT_STATE == MENU_STATES.CONTROLS_VIEW ---
        // Force the text opacity filter to follow our smooth blender variable
        draw_set_alpha(menu_fade_alpha);
        
        draw_set_halign(fa_center);
        draw_set_color(c_purple);
        draw_text(320, 150, "--- KEYBOARD CONTROLS INDEX ---");
        draw_set_color(c_white);
        draw_text(320, 200, "[ ARROWS ]  -  Move Kris & Trailing Susie");
        draw_text(320, 240, "[ Z KEY ]   -  Confirm Choice / Interact Object");
        draw_text(320, 280, "[ X / SHIFT ] - Cancel Option / Overworld Sprint");
        draw_text(320, 320, "[ ESC KEY ]  - Instant Title Menu Return");
        draw_set_color(c_gray);
        draw_text(320, 380, "PRESS Z, X, OR SHIFT TO GO BACK");
		 draw_set_alpha(1.0);
        break;
// --- ADDED TO THE BOTTOM OF THE DRAW STATE SWITCH ---
case menu_states.save_slots:
    draw_set_halign(fa_center);
    draw_set_color(c_purple);
    draw_text(320, 130, "--- SELECT A SAVE ---");
    
       // ========================================================
    // MINIMAL TITLE MENU FILE SLOTS DRAW (DRAW EVENT)
    // ========================================================
    
    // Loop through all 3 files and draw their information containers on screen
    for (var s = 0; s < 3; s++) {
        var _file = "save_collapse_slot_" + string(s + 1) + ".ini";
        var _box_y = 160 + (s * 75);
        
        // Highlight the border box frame if the user is pointing at it
        if (menu_index == s) draw_set_color(c_yellow); else draw_set_color(c_white);
        draw_rectangle(100, _box_y, 540, _box_y + 60, true);
        
        draw_set_halign(fa_left);
        draw_text(115, _box_y + 20, "SLOT " + string(s + 1));
        
        // Scan the specific target file to display its current stats dynamically
        if (file_exists(_file)) {
            ini_open(_file);
            var _lv = string(ini_read_real("Stats", "player_lv", 0));
            var _time_raw = ini_read_real("Story", "time_played", 0);
            ini_close();
            
            var _min = floor(_time_raw / 60);
            var _sec = _time_raw % 60;
            var _sec_str = (_sec < 10) ? "0" + string(_sec) : string(_sec);
            var _time_str = string(_min) + ":" + _sec_str;
            
            draw_set_color(c_ltgray);
            draw_text(230, _box_y + 20, "LV: " + _lv + "      TIME: " + _time_str);
        } else {
            // Empty slot fallback string
            draw_set_color(c_dkgray);
            draw_text(230, _box_y + 20, "-- NO SAVE --");
        }
    }


    
    // Render the Back Button choice at the very bottom line row
    draw_set_halign(fa_center);
    if (menu_index == 3) draw_set_color(c_yellow); else draw_set_color(c_white);
    draw_text(320, 400, "[ RETURN TO MAIN MENU ]");
    
    // Position the soul heart cursor right next to whatever profile index is targeted
    var _soul_y = (menu_index == 3) ? 404 : 190 + (menu_index * 75);
   // --- INSIDE CURRENT_STATE == MENU_STATES.SAVE_SLOTS ---
// Replace the old slot list heart location drawing line with this:
var _soul_x = (menu_index == 3) ? 180 : 70;
if (sprite_exists(spr_soul)) draw_sprite(spr_soul, 0, soul_x, soul_y);

    break;
}
draw_set_alpha(1.0);





