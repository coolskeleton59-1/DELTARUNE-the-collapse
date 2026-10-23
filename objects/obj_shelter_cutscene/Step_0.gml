
// ========================================================
// PROLOGUE CUTSCENE BYPASS CORE (X KEY SKIP UNLOCKED)
// ========================================================

// 1. Monitor if the player taps the cancel/sprint button (X or Shift)
if (keyboard_check_pressed(ord("X")) || keyboard_check_pressed(vk_shift)) {
    
    // 2. HARD DRIVE SECURITY SCAN: Check if a save profile container exists!
    if (file_exists("save_collapse.ini")) {
        
        // 3. PURGE PROLOGUE TEXT BOXES & SCENE CHANNELS
        if (instance_exists(obj_dialogue_box)) {
            instance_destroy(obj_dialogue_box);
        }
        
        // 4. INSTANT TRANSITION UPGRADE
        // Wipes the looping menu track buffer cleanly before entering the overworld grid
        audio_stop_all(); 
        
        // 5. RUN DATABASE PARSING ROUTINE TO FETCH SAVED POSITION DATA
        ini_open("save_collapse.ini");
        var _raw_room_string = ini_read_string("Location", "saved_room", "Room1");
        global.truce_phase   = ini_read_real("Story", "truce_phase", 0);
        global.target_x      = ini_read_real("Location", "kris_x", 80);
        global.target_y      = ini_read_real("Location", "kris_y", 140);
        ini_close();
        
        // Convert that text string name safely into a real internal number index id!
        var _target_room_index = asset_get_index(_raw_room_string);
        if (_target_room_index == -1) _target_room_index = Room1;
        
       if(global.truce_phase >3){
        room_goto(rm_shelter_open);
	   }
	   else{room_goto(rm_shelter_exterior)
	   }
        
        // Destroy this intro controller object instance so it stops processing code
        instance_destroy(); 
    }
}

// 1. TYPEWRITER PROCESSING ENGINE
var _current_target = prelude_text[prelude_page];

if (char_index < string_length(_current_target)) {
    var _old_index = floor(char_index);
    char_index += type_speed;
    text_visible = string_copy(_current_target, 1, floor(char_index));
    
    // Play your text sound bleep every time a new letter pops up
    if (floor(char_index) > _old_index) {
        audio_play_sound(snd_text_bleep, 1, false); 
    }
}

// 2. INPUT SKIP & PROGRESSION (Press Z or Spacebar)
if (keyboard_check_pressed(vk_space) || keyboard_check_pressed(ord("Z"))) {
    // If the line is still typing, instantly finish revealing it
    if (char_index < string_length(_current_target)) {
        char_index = string_length(_current_target);
        text_visible = _current_target;
    } 
    // If the line was already finished, move to the next page!
    else {
        if (prelude_page < array_length(prelude_text) - 1) {
            prelude_page += 1;
            char_index = 0;
            text_visible = "";
        } 
        // ALL PAGES READ: Hand control over to the Main Menu!
        else {
            io_clear(); // Flush key trackers so it doesn't auto-click "New Game"
		if(global.truce_phase >3){
            room_goto(rm_shelter_open);}
			else{room_goto(rm_shelter_exterior)
			}
        }
    }
}
