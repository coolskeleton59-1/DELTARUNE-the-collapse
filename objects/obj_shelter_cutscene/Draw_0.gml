// Set up text appearance upfront
draw_set_font(fnt_dialogue);
draw_set_color(c_white);
draw_set_halign(fa_center); // Centers the text on the screen for a cinematic feel!

// Draw the rolling text right in the middle of your 640x480 screen window
draw_text_ext(320, 220, text_visible, 24, 500);
