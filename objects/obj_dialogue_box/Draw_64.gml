/// ========================================================
/// 1. RENDER MASTER DIALOGUE BOX CONTAINER (192X192 RE-ALIGN)
/// ========================================================

var _s = spr_menu_box;
if (sprite_exists(_s)) {
    var _x = 32;
    var _y = 320;
    var _w = 577; // Total desired box width
    var _h = 145; // Total desired box height
    
    // --- THICKNESS TUNER ---
    // HARD-LOCKED AT 12: Matches your native 12px border art inside the 192x192 file!
    var _b_size = 25; 
    
    // RE-CALIBRATED FOR 192X192: Replaced the old 96 layout trackers entirely
    // 192 - (12 * 2) = exactly 168 pixels for your middle section cavity slice!
    var _mid_size = 192 - (_b_size * 2); 
    var _opp_edge = 192 - _b_size; // Landmark point at pixel 180 (192 - 12)
    
    // --- DRAW FOUR CORNERS (Un-scaled, locked to your custom 12px thickness!) ---
    draw_sprite_part(_s, 0, 0, 0, _b_size, _b_size, _x, _y);                                      // Top Left
    draw_sprite_part(_s, 0, _opp_edge, 0, _b_size, _b_size, _x + _w - _b_size, _y);               // Top Right
    draw_sprite_part(_s, 0, 0, _opp_edge, _b_size, _b_size, _x, _y + _h - _b_size);               // Bottom Left
    draw_sprite_part(_s, 0, _opp_edge, _opp_edge, _b_size, _b_size, _x + _w - _b_size, _y + _h - _b_size); // Bottom Right
    
    // --- DRAW STRAIGHT EDGES (Stretched perfectly flat at exactly 12px thickness!) ---
    draw_sprite_part_ext(_s, 0, _b_size, 0, _mid_size, _b_size, _x + _b_size, _y, (_w - (_b_size * 2)) / _mid_size, 1, c_white, 1);                  // Top Border Line
    draw_sprite_part_ext(_s, 0, _b_size, _opp_edge, _mid_size, _b_size, _x + _b_size, _y + _h - _b_size, (_w - (_b_size * 2)) / _mid_size, 1, c_white, 1); // Bottom Border Line
    draw_sprite_part_ext(_s, 0, 0, _b_size, _b_size, _mid_size, _x, _y + _b_size, 1, (_h - (_b_size * 2)) / _mid_size, c_white, 1);                  // Left Border Line
    draw_sprite_part_ext(_s, 0, _opp_edge, _b_size, _b_size, _mid_size, _x + _w - _b_size, _y + _b_size, 1, (_h - (_b_size * 2)) / _mid_size, c_white, 1); // Right Border Line
    
    // --- DRAW SOLID CENTER CAVITY (Fills the black box cavity safely) ---
    draw_sprite_part_ext(_s, 0, _b_size, _b_size, _mid_size, _mid_size, _x + _b_size, _y + _b_size, (_w - (_b_size * 2)) / _mid_size, (_h - (_b_size * 2)) / _mid_size, c_white, 1);
}

// ========================================================
// 2. Initialize Core Text Placement Variables
// ========================================================
var _text_start_x = 32 + 60; 
var _text_start_y = 320 + 26;

// ========================================================
// 3. ARRAY-SAFE CHARACTER PORTRAIT MANAGER
// ========================================================
var _current_face = -1;
if (is_array(face_array)) {
    if (dialogue_page < array_length(face_array)) _current_face = face_array[dialogue_page];
} else {
    _current_face = face_array;
}

if (sprite_exists(_current_face) && _current_face != -1) {
    draw_sprite_stretched(_current_face, dialogue_page, 54, 336, 96, 96);
    _text_start_x = 32 + 150; 
}

// ========================================================
// 4. RENDER TYPOGRAPHY LINES NATIVELY
// ========================================================
draw_set_font(fnt_dialogue); 
draw_set_color(c_white);
draw_set_halign(fa_left);

var _max_wrap_width = 608 - _text_start_x - 20;
draw_text_ext(_text_start_x, _text_start_y, text_visible, 18, _max_wrap_width);


