// ========================================================
// CENTER COLUMN MASK DRAWER (BORDER PROTECTION HOOK)
// ========================================================

if (fade_alpha > 0) {
    // 1. Fetch your screen's actual physical window properties
    var _display_w = display_get_gui_width();
    var _display_h = display_get_gui_height();
    
    // 2. Calculate the exact scaled width of your 4:3 core gameplay aspect window
    var _game_scaled_w = (_display_h / 480) * 640;
    
    // 3. Find where the black side bars end and the true gameplay viewport begins
    var _left_pillar_width  = (_display_w - _game_scaled_w) / 2;
    var _right_pillar_start = _left_pillar_width + _game_scaled_w;
    
    // 4. PAINT THE BLACK MASK *ONLY* INSIDE THE CENTER GAMEPLAY COLUMN
    draw_set_alpha(fade_alpha);
    draw_set_color(c_black);
    
    // Bounded perfectly inside your custom widescreen border margins!
    draw_rectangle(_left_pillar_width, 0, _right_pillar_start, _display_h, false);
    
    // Safety resets for text fonts and player sprites
    draw_set_alpha(1.0);
    draw_set_color(c_white);
}
