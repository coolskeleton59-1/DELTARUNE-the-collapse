if (menu_active) {
    // 1. Draw a dark backdrop window box over the center screen
    draw_set_color(c_black);
    draw_rectangle(120, 180, 520, 300, false);
    draw_set_color(c_white);
    draw_rectangle(120, 180, 520, 300, true);
    
    // 2. Set typography font
    draw_set_font(fnt_dialogue);
    draw_set_halign(fa_center);
    
    // 3. Print the core contract question text string
    draw_text(320, 200, "WILL YOU ACCEPT THE TRUCE?");
    
    // 4. Highlight the active choice option with a yellow color modifier!
    if (menu_select == 0) draw_set_color(c_yellow); else draw_set_color(c_white);
    draw_text(220, 250, "[ YES ]");
    
    if (menu_select == 1) draw_set_color(c_yellow); else draw_set_color(c_white);
    draw_text(420, 250, "[ NO ]");
}
