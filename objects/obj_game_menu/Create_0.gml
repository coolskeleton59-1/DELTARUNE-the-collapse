// Define menu choices layout
menu_options = ["ITEM", "CONFIG", "TEAM", "BACK"];
menu_index = 0; // Currently selected option

// Freeze the overworld player instantly when the menu opens
global.game_frozen = true; 

menu_state = "main"; // Tracks if you are on main buttons or inside the item list
inv_index = 0;       // Tracks which item you are highlighting in your inventory
