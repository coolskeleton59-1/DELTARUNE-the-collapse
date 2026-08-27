


// 1. ADAPTIVE TARGET CHECK: Safely read whether the text is an array or a single string
var _current_target = "";

if (is_array(text_array)) {
    _current_target = text_array[dialogue_page]; // Read multi-page conversation page slot [Context]
} else {
    _current_target = text_array; // Read as a simple single sentence block!
}

// 2. TYPEWRITER CALCULATION LOOP: Feed letters one by one
if (char_index < string_length(_current_target)) {
    var _old_index = floor(char_index);
    char_index += type_speed;
    text_visible = string_copy(_current_target, 1, floor(char_index));
    
    // AUDIO TRIGGER: Only play the bleep if a brand-new letter has just spawned!
    if (floor(char_index) > _old_index) {
        audio_play_sound(snd_text_bleep, 1, false); // Play text sounds bleep! [Context]
    }
}

// 3. PAGE PROGRESSION & CLOSING LOGIC
if (keyboard_check_pressed(vk_space) || keyboard_check_pressed(ord("Z"))) {
    // If the sentence is still typing, instantly complete the current line
    if (char_index < string_length(_current_target)) {
        char_index = string_length(_current_target);
        text_visible = _current_target;
    } 
    // Advance page or close the box
    else {
        // If it's a simple object text string OR we've hit the end of a multi-page array
        if (!is_array(text_array) || (dialogue_page >= array_length(text_array) - 1)) {
            
            // CINEMATIC LOOP COUNTER: If this was Susie's street scene finishing, trigger the warp! [Context]
            if (room == rm_street_north && is_array(text_array)) {
                global.truce_phase = 1; 
                room_goto(Room1)
                obj_kris_hollow.x = 450;
                obj_kris_hollow.y = 220;
            }
            
             // If it's a simple object text string OR we've hit the end of a multi-page array
        if (!is_array(text_array) || (dialogue_page >= array_length(text_array) - 1)) {
            
            // NOELLE FOLLOWER PARTY SPAWNER (2X SCALE RE-CALIBRATION)
            if (global.truce_phase == 2 && is_array(text_array) && array_length(text_array) > 5) {
                
                global.truce_phase = 3; 
                
                var _nearest_noelle_npc = instance_nearest(obj_kris_hollow.x, obj_kris_hollow.y, obj_readable);
                
                if (instance_exists(_nearest_noelle_npc)) {
                    // 1. Capture a local reference handle id to the newly spawned follower instance!
                    var _noelle_inst = instance_create_depth(_nearest_noelle_npc.x, _nearest_noelle_npc.y, _nearest_noelle_npc.depth, obj_noelle_follower);
                    
                    // 2. DOUBLE THE SPRITE ASSET DIMENSIONS INSTANTLY
                    // Forces her overworld graphics canvas to render at exactly 2x scale on your monitor glass!
                    if (instance_exists(_noelle_inst)) {
                        _noelle_inst.image_xscale = 2;
                        _noelle_inst.image_yscale = 2;
                    }
                    
                    // 3. ABSOLUTE PURGE: Permanently destroy the static overworld NPC object from the map
                    with (_nearest_noelle_npc) {
                        instance_destroy();
                    }
                }
            }
			        // If it's a simple object text string OR we've hit the end of a multi-page array
            
            // SANS BACKROOM TELEPORTATION JUMP
            // Fires automatically the exact frame the player finishes reading Sans's briefing lines!
            if (global.truce_phase == 4 && room = rm_sans_interior ) {
                audio_stop_all(); // Kill h.ogg instantly to clear the audio channels for pure silence!
                
                // Teleport your 2x scaled persistent party cleanly to the next room map layer!
                // (Change rm_sans_backroom to your exact backroom room asset name!)
                room_goto(rm_sans_backroom); 
			}
				
         
            
            io_clear(); 
            instance_destroy(); 
        }


            
            // Your original cinematic street scene room warp check stays completely safe below it: [Context]
            if (room == rm_street_north && is_array(text_array)) {
                global.truce_phase = 1; 
                room_goto(Room1);
                obj_kris_hollow.x = 450;
                obj_kris_hollow.y = 220;
            }
            
            instance_destroy(); // Safely remove the text box from screen glass [Context]
        } 


        
        // If it's an array and there are more pages waiting, advance! [Context]
        else {
            dialogue_page += 1;
            char_index = 0;
            text_visible = "";
        }
    }
}
