// ONLY run this logic if the player is in Fullscreen mode
if (window_get_fullscreen()) 
{
    var _win_w = window_get_width();
    var _win_h = window_get_height();

    // 1. Clear background canvas to black first
    draw_clear(c_black);

    // 2. Aspect ratio scaling calculations for your 640x480 game
    var _board_x = _win_w * 0.150;
    var _board_y = _win_h * 0.035;
    var _board_w = _win_w * 0.702;
    var _board_h = _win_h * 0.915;

    var _game_native_w = 640;
    var _game_native_h = 480;

    var _scale_x = _board_w / _game_native_w;
    var _scale_y = _board_h / _game_native_h;
    var _final_scale = min(_scale_x, _scale_y);

    var _game_draw_w = _game_native_w * _final_scale;
    var _game_draw_h = _game_native_h * _final_scale;

    var _game_draw_x = _board_x + ((_board_w - _game_draw_w) / 2);
    var _game_draw_y = _board_y + ((_board_h - _game_draw_h) / 2);

    // 3. LAYER 1: Draw your game surface FIRST
    gpu_set_texfilter(false); // Forces pixel-perfect crisp textures
    draw_surface_stretched(application_surface, _game_draw_x, _game_draw_y, _game_draw_w, _game_draw_h);

    // 4. LAYER 2 (NEW): Draw the transition fade ONLY inside the gameplay window
    if (instance_exists(obj_fade_controller)) 
    {
        draw_set_color(c_black);
        draw_set_alpha(obj_fade_controller.fade_alpha); // Grab alpha from the controller
        
        // Draw the black rectangle exactly over the 640x480 game box boundaries
        draw_rectangle(_game_draw_x, _game_draw_y, _game_draw_x + _game_draw_w, _game_draw_y + _game_draw_h, false);
        
        draw_set_alpha(1.0); // Reset alpha back to normal
    }

    // 5. LAYER 3: Draw your single border sprite directly ON TOP of everything
    gpu_set_texfilter(true); // Smooths the high-res border artwork edges
    draw_sprite_stretched(spr_fullscreen_border, 0, 0, 0, _win_w, _win_h);
    gpu_set_texfilter(false); // Reset back to default crisp mode
}
else 
{
    // IF WINDOWED: Draw the game raw filling the window
    gpu_set_texfilter(false);
    draw_surface_stretched(application_surface, 0, 0, window_get_width(), window_get_height());
    
    // Process windowed fade overlay if it exists
    if (instance_exists(obj_fade_controller)) 
    {
        draw_set_color(c_black);
        draw_set_alpha(obj_fade_controller.fade_alpha);
        draw_rectangle(0, 0, window_get_width(), window_get_height(), false);
        draw_set_alpha(1.0);
    }
}
