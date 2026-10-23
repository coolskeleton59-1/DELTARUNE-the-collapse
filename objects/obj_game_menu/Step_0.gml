// Navigate up/down or left/right (using horizontal layout like Deltarune)
var _move = keyboard_check_pressed(vk_right) - keyboard_check_pressed(vk_left);
if (_move != 0) {
    menu_index += _move;
    // Wrap around index bounds
    if (menu_index < 0) menu_index = array_length(menu_options) - 1;
    if (menu_index >= array_length(menu_options)) menu_index = 0;
    
    // Play a subtle selection-move sound if you have one (optional)
    // audio_play_sound(snd_menu_move, 5, false);
}

// Cancel/Close menu with X, Shift, or Esc
if (keyboard_check_pressed(ord("X")) || keyboard_check_pressed(vk_shift) || keyboard_check_pressed(vk_escape)) {
    global.game_frozen = false;
    instance_destroy();
    exit;
}

// Confirm choice with Z or Space
if (keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_space)) {
    switch (menu_options[menu_index]) {
           case "ITEM":
    if (variable_global_exists("inventory") && array_length(global.inventory) > 0) {
        menu_state = "inventory";
        inv_index = 0;
    } else {
        show_debug_message("Inventory is empty!");
    }
    break;

            
        case "CONFIG":
            // TODO: Open your config/volume settings state or object
            show_debug_message("Opened Config!");
            break;
            
        case "TEAM":
            show_debug_message("View Team Stats!");
            break;
            
        case "BACK":
            global.game_frozen = false;
            instance_destroy();
            break;
    }
}

if (menu_state == "inventory") {
    var _inv_move = keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up);
    if (_inv_move != 0) {
        inv_index += _inv_move;
        if (inv_index < 0) inv_index = array_length(global.inventory) - 1;
        if (inv_index >= array_length(global.inventory)) inv_index = 0;
    }
    
    // Go back to main menu buttons
    if (keyboard_check_pressed(ord("X")) || keyboard_check_pressed(vk_shift)) {
        menu_state = "main";
    }
}
