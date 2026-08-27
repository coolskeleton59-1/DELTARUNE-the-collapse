#macro INVENTORY_MAX_SLOTS 12
#macro ITEM_NONE 0
#macro ITEM_GLITCHBURGER 1

/// @description Initializes the item database parameters natively.
function scr_item_database_init() {
    global.item_db = {};
    
    // Register Glitch Burger Properties
    global.item_db[$ string(ITEM_GLITCHBURGER)] = {
        name: "GlitchBurger",
        description: "* GlitchBurger - Heals 20 HP\n* A corrupted clump of data. It tastes slightly purple.",
        heal_amount: 20
    };
}

/// @description Adds an item ID to the first empty array slot.
function scr_inventory_add(_item_id) {
    for (var _i = 0; _i < INVENTORY_MAX_SLOTS; _i++) {
        if (global.inventory[_i] == ITEM_NONE) {
            global.inventory[_i] = _item_id;
            return true; // Successfully added item
        }
    }
    return false; // Inventory is full!
}