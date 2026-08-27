if ( show_sidebar == true) {
    // Solid background column on the screen edge
    draw_set_color(c_black);
    draw_rectangle(20, 20, 190, 420, false);
    
    // Outer white frame border
    draw_set_color(c_white);
    draw_rectangle(20, 20, 190, 420, true);
    
    draw_set_halign(fa_left);
    draw_set_font(fnt_menu_sub);
    draw_text(32, 32, "MENU");
    draw_line(32, 50, 178, 50);
    
    var _options = ["NEW GAME", "CONTINUE", "CONFIG", "CONTROLS"];
    for (var i = 0; i < 4; i++) {
        if (i == 1 && !can_continue) draw_set_color(c_dkgray);
        else if (menu_index == i) draw_set_color(c_yellow);
        else draw_set_color(c_white);
        draw_text(32, 70 + (i * 40), _options[i]);
    }
    
    var _side_heart_y = 74 + (menu_index * 40);
    if (sprite_exists(spr_soul)) {
        draw_sprite(spr_soul, 0, 24, _side_heart_y);
    }
}

