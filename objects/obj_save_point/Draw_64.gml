// ========================================================
// LOCAL SAVE WINDOW OVERLAY (DRAW GUI EVENT)
// ========================================================

if (is_selecting_slot == true) {
    // 1. Paint a clean, retro dark menu window box in the center of the display screen
    draw_set_color(c_black);
    draw_rectangle(140, 90, 500, 390, false);
    
    // 2. Paint a sharp white frame border outline
    draw_set_color(c_white);
    draw_rectangle(140, 90, 500, 390, true);
    
    draw_set_halign(fa_center);
    draw_set_font(fnt_menu_sub);
    draw_set_color(c_purple);
    draw_text(320, 105, "--- CHOOSE A SAVE SLOT ---");
    
       // ========================================================
    // MINIMAL 3-SLOT RE-RENDERER (DRAW GUI EVENT)
    // ========================================================
    
    // 3. Loop through all 3 files and draw their information slots line-by-line
    for (var s = 0; s < 3; s++) {
        var _file = "save_collapse_slot_" + string(s + 1) + ".ini";
        var _yy = 145 + (s * 60);
        
        // Highlight the border box row if the player is currently pointing at it
        if (local_slot_index == s) draw_set_color(c_yellow); else draw_set_color(c_white);
        draw_rectangle(160, _yy, 480, _yy + 45, true);
        
        // Always draw the Slot text label label first
        draw_set_halign(fa_left);
        draw_text(175, _yy + 12, "SLOT " + string(s + 1));
        
        // Scan the specific target file to display its current stats dynamically
        if (file_exists(_file)) {
            ini_open(_file);
            var _lv_val = string(ini_read_real("Stats", "player_lv", 0));
            ini_close();
            
            draw_set_color(c_ltgray);
            draw_text(250, _yy + 12, "LV: " + _lv_val);
        } else {
            draw_set_color(c_dkgray);
            draw_text(250, _yy + 12, "[ EMPTY SLOT ]");
        }
    }


    
    // 4. Render the Cancel line at the bottom row
    draw_set_halign(fa_center);
    if (local_slot_index == 3) draw_set_color(c_yellow); else draw_set_color(c_white);
    draw_text(320, 350, "[ CANCEL ]");
    
    // 5. Position the soul heart marker icon right beside your local selection choices
    var _soul_y = (local_slot_index == 3) ? 354 : 166 + (local_slot_index * 60);
    var _soul_x = (local_slot_index == 3) ? 210 : 125;
    if (sprite_exists(spr_soul)) draw_sprite(spr_soul, 0, _soul_x, _soul_y);
}
