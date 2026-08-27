// INSTANT TITLE ROUTE SHORTCUT
// Stop any active player pathways so Kris doesn't hold input variables across the reset
audio_stop_all();
path_end();

// Safely clear out any lingering local game instance data
if (instance_exists(obj_dialogue_box)) {
    instance_destroy(obj_dialogue_box);
	
}

// Flash the graphics engine directly back to your state-protected title launcher room asset!
room_goto(rm_main_menu); 
