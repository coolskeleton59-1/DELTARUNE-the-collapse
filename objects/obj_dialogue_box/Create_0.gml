global.game_frozen = true
// 1. Initialize the page tracker
dialogue_page = 0;

// PAGE 0: Annoyed face [Context]
text_array[0] = "* ... Huh?\n* Kris? What the hell are you staring at?";
face_array[0] = spr_susie_normal; 

// PAGE 1: Shocked face portrait [Context]
text_array[1] = "* Wait, what's wrong with your face...?\n* Your... your eyes are completely blank!!";
face_array[1] = spr_susie_shocked; 


// PAGE 3: The breakthrough shocker! [Context]
text_array[3] = "* ... Wait.\n* ... Kris?\n* ... Got anymore of that chalk?";
face_array[3] = spr_susie_smile; 

// 2. Typewriter Engine Basics
text_visible = "";
char_index = 0;
type_speed = 0.5;

// ========================================================
// INSTANT STRING DECONSTRUCTION (BLEEDING PREVENTER FIX)
// ========================================================
// We look at obj_readable directly on creation to grab and split my_text instantly!
var _interact_target = noone;

if (instance_exists(obj_kris_hollow)) {
    _interact_target = instance_nearest(obj_kris_hollow.x, obj_kris_hollow.y, obj_readable);
}

if (instance_exists(_interact_target) && variable_instance_exists(_interact_target, "my_text")) {
    var _raw_text = _interact_target.my_text;
    
    // Look for the pipe symbol split indicator
    if (string_count("|", _raw_text) > 0) {
        var _temp_string = _raw_text;
        var _page_index = 0;
        
        // Loop through and slice strings apart at every "|" symbol boundary line
        while (string_count("|", _temp_string) > 0) {
            var _pos = string_pos("|", _temp_string);
            text_array[_page_index] = string_copy(_temp_string, 1, _pos - 1);
            _temp_string = string_delete(_temp_string, 1, _pos);
            _page_index++;
        }
        // Grab the final remaining string line segment
        text_array[_page_index] = _temp_string;
    } else {
        // Fallback safety gate: If no splitter exists, read as a standard single line block
        text_array = _raw_text;
    }
}


