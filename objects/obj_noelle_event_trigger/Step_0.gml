// ========================================================
// SEQUENTIAL DIALOGUE STEP ENGINE
// ========================================================

// Trigger the sequence only if the player is actively in Light World Phase 2
if (global.truce_phase == 2) {
    
    // Check if the current dialogue box instance has been closed or destroyed
    if (!instance_exists(current_box)) {
		
		// ========================================================
// ACTIVATION GATE: Keeps the scene silent until Z is pressed!
// ========================================================
if (!activated) {
    exit; // Instantly halts the rest of the script from auto-firing on room enter!
}


        
        switch (scene_step) {
            case 0:
                current_box = instance_create_depth(0, 0, 0, obj_dialogue_box);
                current_box.text_array = "* Noelle: Oh! Hey Kris! Hey Susie!\n* Are you guys heading out to...";
                current_box.face_array = spr_noellestill;
                scene_step = 1;
                break;
                
            case 1:
                current_box = instance_create_depth(0, 0, 0, obj_dialogue_box);
                current_box.text_array = "* Noelle: ... wait.\n* Wh... why are you looking at me like that...?";
                current_box.face_array = spr_noellestill;
                scene_step = 2;
                break;
                
            case 2:
                current_box = instance_create_depth(0, 0, 0, obj_dialogue_box);
                current_box.text_array = "* Susie: Noelle. Look at my eyes.\n* Remember the snow.";
                current_box.face_array = spr_susie_normal;
                scene_step = 3;
                break;
                
            case 3:
                current_box = instance_create_depth(0, 0, 0, obj_dialogue_box);
                current_box.text_array = "* Susie: Remember the freezing dark.\n* Remember what happened to Cyber World.";
                current_box.face_array = spr_susie_normal;
                scene_step = 4;
                break;
                
            case 4:
                current_box = instance_create_depth(0, 0, 0, obj_dialogue_box);
                current_box.text_array = "* Noelle: No... no, that was just a nightmare!\n* We woke up in the library!";
                current_box.face_array = spr_noellestill;
                scene_step = 5;
                break;
                
            case 5:
                current_box = instance_create_depth(0, 0, 0, obj_dialogue_box);
                current_box.text_array = "* Kris: (You grab Noelle's hand.)\n* (Your soul flashes a cold, piercing crimson.)";
                current_box.face_array = -1; // Narrative text layout drops portrait frame
                scene_step = 6;
                break;
                
            case 6:
                current_box = instance_create_depth(0, 0, 0, obj_dialogue_box);
                current_box.text_array = "* Noelle: (...!)";
                current_box.face_array = spr_noellestill;
                scene_step = 7;
                break;
                
            case 7:
                current_box = instance_create_depth(0, 0, 0, obj_dialogue_box);
                current_box.text_array = "* Noelle: (Her eyes widen in absolute, paralyzing terror.)";
                current_box.face_array = spr_noellestill;
                scene_step = 8;
                break;
                
            case 8:
                current_box = instance_create_depth(0, 0, 0, obj_dialogue_box);
                current_box.text_array = "* Noelle: It... it wasn't a dream...\n* The loop... it's happening again, isn't it?";
                current_box.face_array = spr_noellestill;
                scene_step = 9;
                break;
                
            case 9:
                current_box = instance_create_depth(0, 0, 0, obj_dialogue_box);
                current_box.text_array = "* Susie: Yeah. And we're fixing it this time.\n* Come with us. We're finding Sans.";
                current_box.face_array = spr_susie_smile;
                scene_step = 10;
                break;
                
            case 10:
                // ALL PAGES FULLY RE-LINKED: Advance your timeline phase and clear memory loops!
                global.truce_phase = 3; // Lock timeline to Noelle-Aware state
                instance_destroy(); // Purge this controller block since its scene script is done
                break;
        }
    }
}
