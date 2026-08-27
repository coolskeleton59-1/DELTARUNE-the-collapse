

global.game_frozen = false;
active_screen = "MAIN"; 

menu_index     = 0; 
sub_menu_index = 0; 
config_index   = 0; 

options = ["ITEM", "EQUIP", "STAT", "CLOSE"];

menu_x         = -200;       
menu_target_x  = 32;  
slide_speed    = 0.3;  
is_closing     = false;

visible        = false;
ts             = 0.75; 

// Initial Inventory List
if (global.truce_phase <2)
menu_items = [
 "Empty Slot",
  "Empty Slot",
   "Empty Slot",
    "Empty Slot",
  "Empty Slot",
    "Empty Slot"
];

// --- NEW EQUIP SYSTEM NAVIGATION TRACKERS ---
equip_select_state = 0;  // 0 = Pick Party Member, 1 = Pick Slot (Weapon/Armor), 2 = Pick Item from Inventory
equip_slot_index   = 0;  // 0 = Weapon Slot, 1 = Armor Slot
equip_item_index   = 0;  // Tracks your scroll cursor when browsing filtered items to equip

// --- UPDATE YOUR PARTY STRUCTS WITH EQUIP TRACKERS ---
// Modify your existing party array to make sure each character has these slot attributes initialized:
party = [
    { 
        name: "KRIS",   
        hp: 120, max_hp: 120, 
        lv: 1, color: c_aqua,
        weapon: "None", // Starting weapon name string
        armor: "None"         // Starting armor name string
    },
    { 
        name: "SUSIE",  
        hp: 140, max_hp: 140, 
        lv: 1, color: c_fuchsia,
        weapon: "None",   // Starting weapon name string
        armor: "None"         // Starting armor name string
    },
    { 
        name: "NOELLE", 
        hp: 100, max_hp: 100, 
        lv: 1, color: c_yellow,
        weapon: "None",
        armor: "None"   // Starting armor name string
    }
];


if (!variable_global_exists("money")) {
    global.money = 250;
}

// Tracks our position inside the item sub-state
// 0 = Browsing items list, 1 = Selecting who to heal
item_select_state = 0; 
party_select_index = 0; // Tracks which party member (0 to 2) you are targeting







