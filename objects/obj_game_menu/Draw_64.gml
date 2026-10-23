var _gui_w = display_get_gui_width();
var _gui_h = display_get_gui_height();

// Draw semi-transparent dark backdrop box over the GUI layer
draw_set_color(c_black);
draw_set_alpha(0.85);
draw_rectangle(60, _gui_h - 130, _gui_w - 60, _gui_h - 30, false);

// Draw outer retro border line
draw_set_color(c_white);
draw_set_alpha(1.0);
draw_rectangle(60, _gui_h - 130, _gui_w - 60, _gui_h - 30, true);

// Draw options horizontally
var _start_x = 100;
var _spacing = 130;
var _draw_y = _gui_h - 85;

for (var i = 0; i < array_length(menu_options); i++) {
    var _col = (i == menu_index) ? c_yellow : c_white;
    draw_set_color(_col);
    
    // Draw a small heart/cursor indicator next to the active choice
    if (i == menu_index) {
        draw_text(_start_x + (i * _spacing) - 20, _draw_y, ">");
    }
    
    draw_text(_start_x + (i * _spacing), _draw_y, menu_options[i]);
}

 if (menu_state == "inventory") {
    var _start_y = _gui_h - 130;
    for (var i = 0; i < array_length(global.inventory); i++) {
        var _item = global.inventory[i];
        var _col = (i == inv_index) ? c_yellow : c_white;
        draw_set_color(_col);
        
        if (i == inv_index) {
            draw_text(85, _start_y + (i * 25), ">");
            draw_text(350, _start_y, _item.desc); // Draws your creation code description
        }
        draw_text(110, _start_y + (i * 25), _item.name); // Draws your creation code name
    }
}
