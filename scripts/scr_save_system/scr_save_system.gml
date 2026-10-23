function save_game_data() {
    // THE MULTI-SLOT FIX: Generate file path dynamically matching your active slot!
    var _slot_file = "save_collapse_slot_" + string(global.active_save_slot) + ".ini";
    ini_open(_slot_file);
    
    ini_write_real("Story", "truce_phase", global.truce_phase);
    
    var _total_seconds = floor(current_time / 1000);
    ini_write_real("Story", "time_played", _total_seconds);
    
    ini_write_real("Stats", "player_lv", 0); 
    ini_write_real("Stats", "money", global.money);

    if (instance_exists(obj_pause_menu)) {
        ini_write_real("Inventory", "item_count", array_length(obj_pause_menu.menu_items));
        for (var i = 0; i < array_length(obj_pause_menu.menu_items); i++) {
            ini_write_string("Inventory", "item_" + string(i), obj_pause_menu.menu_items[i]);
        }

        ini_write_real("Party", "member_count", array_length(obj_pause_menu.party));
        for (var p = 0; p < array_length(obj_pause_menu.party); p++) {
            ini_write_string("Party", "p_name_" + string(p), obj_pause_menu.party[p].name);
            ini_write_real("Party", "p_hp_" + string(p), obj_pause_menu.party[p].hp);
            ini_write_real("Party", "p_maxhp_" + string(p), obj_pause_menu.party[p].max_hp);
            ini_write_real("Party", "p_lv_" + string(p), obj_pause_menu.party[p].lv);
            
            ini_write_string("Party", "p_weapon_" + string(p), obj_pause_menu.party[p].weapon);
            ini_write_string("Party", "p_armor_" + string(p), obj_pause_menu.party[p].armor);
        }
    }

    ini_write_string("Location", "saved_room", room_get_name(room));
    if (instance_exists(obj_kris_hollow)) {
        ini_write_real("Location", "saved_x", obj_kris_hollow.x);
        ini_write_real("Location", "saved_y", obj_kris_hollow.y);
    } else {
        ini_write_real("Location", "saved_x", 100);
        ini_write_real("Location", "saved_y", 100);
    }
    
    ini_close();
}

function load_game_data() {
    var _slot_file = "save_collapse_slot_" + string(global.active_save_slot) + ".ini";
    
    if (file_exists(_slot_file)) {
        ini_open(_slot_file);
        
        global.truce_phase = ini_read_real("Story", "truce_phase", global.truce_phase);
        global.money = ini_read_real("Stats", "money", global.money);
        
        var _room_name = ini_read_string("Location", "saved_room", "Room1");
        var _target_x = ini_read_real("Location", "saved_x", 100);
        var _target_y = ini_read_real("Location", "saved_y", 100);
        
        // Pass the file name forward so it syncs from the correct slot file!
        sync_saved_inventory(_slot_file);
        
        ini_close();
        
        var _room_index = asset_get_index(_room_name);
        
        if (room_exists(_room_index)) {
            global.target_room = _room_index;
            global.target_x = _target_x;
            global.target_y = _target_y;
            
            room_goto(_room_index);
        }
    }
}

// Updated argument format so it cleanly syncs your selected slot
function sync_saved_inventory(_target_file) {
    if (file_exists(_target_file)) {
        ini_open(_target_file);
        
        if (instance_exists(obj_pause_menu)) {
            var _item_count = ini_read_real("Inventory", "item_count", 0);
            if (_item_count > 0) {
                obj_pause_menu.menu_items = array_create(_item_count);

                for (var i = 0; i < _item_count; i++) {
                    obj_pause_menu.menu_items[i] = ini_read_string("Inventory", "item_" + string(i), "Empty Slot");
                }
            }
            
            var _member_count = ini_read_real("Party", "member_count", 0);
            if (_member_count > 0) {
                for (var p = 0; p < _member_count; p++) {
                    if (p < array_length(obj_pause_menu.party)) {
                        obj_pause_menu.party[p].name   = ini_read_string("Party", "p_name_" + string(p), obj_pause_menu.party[p].name);
                        obj_pause_menu.party[p].hp     = ini_read_real("Party", "p_hp_" + string(p), obj_pause_menu.party[p].hp);
                        obj_pause_menu.party[p].max_hp = ini_read_real("Party", "p_maxhp_" + string(p), obj_pause_menu.party[p].max_hp);
                        obj_pause_menu.party[p].lv     = ini_read_real("Party", "p_lv_" + string(p), obj_pause_menu.party[p].lv);
                        
                        obj_pause_menu.party[p].weapon = ini_read_string("Party", "p_weapon_" + string(p), obj_pause_menu.party[p].weapon);
                        obj_pause_menu.party[p].armor  = ini_read_string("Party", "p_armor_" + string(p), obj_pause_menu.party[p].armor);
                    }
                }
            }
        }
        
        ini_close();
    }
}







