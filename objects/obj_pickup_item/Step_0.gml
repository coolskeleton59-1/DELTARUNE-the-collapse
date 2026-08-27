// Check distance to player
var _player = instance_nearest(x, y, obj_kris_hollow);
if (_player != noone && point_distance(x, y, _player.x, _player.y) < 16) {
    
    if (keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_space)) {
        
        // Ensure the global inventory list exists
        if (!variable_global_exists("inventory")) {
            global.inventory = [];
        }
        
        // Package this specific item's details into a neat little bundle (struct)
        var _newItem = {
            name: item_name,
            desc: item_desc
        };
        
        // Push it straight into your inventory array!
        array_push(global.inventory, _newItem);
        
        show_debug_message("Picked up: " + item_name);
        
        // Remove the item from the room
        instance_destroy();
    }
}
