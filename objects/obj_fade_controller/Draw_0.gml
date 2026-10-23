// Procedurally draw the black mask over the entire 640x480 viewport [Context]
draw_set_alpha(fade_alpha);
draw_set_color(c_black);
draw_rectangle(0, 0, 640, 480, false);

// Reset transparency back to 100% so normal sprites render correctly
draw_set_alpha(1);
