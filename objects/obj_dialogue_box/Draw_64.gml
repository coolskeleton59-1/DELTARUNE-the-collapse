

/// ========================================================
// 1. RENDER MASTER DIALOGUE BOX CONTAINER (SOLID GEOMETRY FIX)
// ========================================================

// OUTER FRAME: Draw a solid white base rectangle that represents the total exterior border size
draw_set_color(c_white);
draw_rectangle(32, 320, 608, 448, false); // Thick solid white block

// INNER BOX: Punch a solid black cavity directly out of the center 
// Insetting by exactly 3 pixels creates one clean, bold 3px border frame with zero mini-line gaps!
draw_set_color(c_black);
draw_rectangle(32 + 4, 320 + 4, 608 - 4, 448 - 4, false); 

// 2. Initialize Core Text Placement Variables
// Default Left Margin (No Portrait): 60 pixels inside from your box layout borders
var _text_start_x = 32 + 60; 
var _text_start_y = 320 + 26;

// 3. ARRAY-SAFE CHARACTER PORTRAIT MANAGER (CRASH PREVENTION FIX)
var _current_face = -1;

// If your cutscene feeds face_array as a raw array list, read the specific page index!
if (is_array(face_array)) {
    if (dialogue_page < array_length(face_array)) {
        _current_face = face_array[dialogue_page];
    }
} else {
    // If it's a standard standalone single portrait number, read it directly
    _current_face = face_array;
}

// Checks a single sprite number instead of a raw array structure
if (sprite_exists(_current_face) && _current_face != -1) {
    
    // Draw your well-proportioned 96x96 face asset cleanly inside the left borders
    draw_sprite_stretched(_current_face, dialogue_page, 54, 336, 96, 96);
    
    // Smoothly shift your text left margin past your portrait frame
    _text_start_x = 32 + 150; 
}

// 4. RENDER TYPOGRAPHY LINES WITH PRECISE PARALLEL MARGINS
draw_set_font(fnt_dialogue); // Using your perfect size 15 Determination Mono font! [Context]
draw_set_color(c_white);
draw_set_halign(fa_left);

// Calculate maximum text wrapping boundary width cleanly so it fits inside the frame
var _max_wrap_width = 608 - _text_start_x - 20;

// Draw your rolling typewriter text string using your original, working line separation
draw_text_ext(_text_start_x, _text_start_y, text_visible, 18, _max_wrap_width);
