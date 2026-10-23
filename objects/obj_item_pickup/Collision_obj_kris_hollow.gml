// Check if our pause menu object exists in the game room memory
if (instance_exists(obj_pause_menu_worse)) {
    var added = false;
    
    // Look through our menu items array for an open slot
    for (var i = 0; i < array_length(obj_pause_menu_worse.menu_items); i++) {
        if (obj_pause_menu_worse.menu_items[i] == "Empty Slot") {
            obj_pause_menu_worse.menu_items[i] = "Dark Candy"; // Give them a healing item!
            added = true;
            break; // Stop looking once we fill one slot
        }
    }
    
    // Play a pickup sound here if you have one, then vanish
    if (added) {
        instance_destroy();
    }
}
