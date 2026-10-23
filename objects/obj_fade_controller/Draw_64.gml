// Only bother drawing if there is an actual fade happening
if (fade_alpha > 0) 
{
    // Force the color tracking to absolute black
    draw_set_color(c_black);
    draw_set_alpha(fade_alpha);
    
    // Draw a rectangle covering the entire GUI viewport resolution layer
    draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
    
    // CRUCIAL: Always reset the global alpha back to 1 so other objects don't turn invisible
    draw_set_alpha(1.0);
}

