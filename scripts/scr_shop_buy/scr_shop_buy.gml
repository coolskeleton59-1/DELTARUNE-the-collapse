function scr_shop_buy(_item_name) {

    var _price = scr_shop_get_price(_item_name);

    if (_price < 0) {
        return "INVALID";
    }

    if (global.money < _price) {
        return "NO_MONEY";
    }

    for (var i = 0; i < array_length(obj_pause_menu.menu_items); i++) {

        if (obj_pause_menu.menu_items[i] == "Empty Slot") {

            obj_pause_menu.menu_items[i] = _item_name;
            global.money -= _price;

            return "SUCCESS";
        }
    }

    return "FULL";
}