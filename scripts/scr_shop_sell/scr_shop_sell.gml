function scr_shop_sell(_item_name) {

    // Make sure the item actually has a shop price.
    var _price = scr_shop_get_price(_item_name);

    if (_price < 0) {
        return "INVALID";
    }


    // Find the item in the player's inventory.
    for (var i = 0; i < array_length(obj_pause_menu.menu_items); i++) {

        if (obj_pause_menu.menu_items[i] == _item_name) {

            // Sell for half of the buying price.
            var _refund = floor(_price * 0.5);

            // Remove item from inventory.
            obj_pause_menu.menu_items[i] = "Empty Slot";

            // Give the player their money.
            global.money += _refund;

            // Save the changed inventory/money.
            save_game_data();

            return "SUCCESS";
        }
    }


    return "NOT_FOUND";
}