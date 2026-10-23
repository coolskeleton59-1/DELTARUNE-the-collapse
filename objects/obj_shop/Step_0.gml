// ============================================================
// SHOP INPUT
// ============================================================

if (instance_exists(obj_dialogue_box)) {
    exit;
}


// ============================================================
// MAIN MENU
// ============================================================

if (shop_state == "MAIN") {

    if (keyboard_check_pressed(vk_up)) {
        shop_selection--;

        if (shop_selection < 0) {
            shop_selection = 3;
        }
    }

    if (keyboard_check_pressed(vk_down)) {
        shop_selection++;

        if (shop_selection > 3) {
            shop_selection = 0;
        }
    }


    if (keyboard_check_pressed(ord("Z"))) {

        switch (shop_selection) {

            // BUY
            case 0:
    shop_state = "BUY";
    shop_selection = 0;
    shop_buy_scroll = 0;
    break;


            case 1:
    shop_state = "SELL";
    shop_selection = 0;
    shop_sell_scroll = 0;
    break;


          case 2:
    shop_state = "TALK";
    shop_selection = 0;
    break;


       case 3:
    room_goto(global.shop_return_room);
    break;
        }
    }

    exit;
}


// ============================================================
// BUY MENU
// ============================================================

if (shop_state == "BUY") {

 // --------------------------------------------------------
// Navigation
// --------------------------------------------------------

if (keyboard_check_pressed(vk_up)) {

    shop_selection--;

    if (shop_selection < 0) {
        shop_selection = array_length(shop_items) - 1;
    }
}


if (keyboard_check_pressed(vk_down)) {

    shop_selection++;

    if (shop_selection >= array_length(shop_items)) {
        shop_selection = 0;
    }
}


// --------------------------------------------------------
// Scrolling
// --------------------------------------------------------

if (shop_selection < shop_buy_scroll) {
    shop_buy_scroll = shop_selection;
}

if (shop_selection >= shop_buy_scroll + 4) {
    shop_buy_scroll = shop_selection - 3;
}


// Keep scroll position valid when wrapping around.
var _buy_max_scroll = max(0, array_length(shop_items) - 4);

if (shop_buy_scroll > _buy_max_scroll) {
    shop_buy_scroll = _buy_max_scroll;
}


    // Buy item
    if (keyboard_check_pressed(ord("Z"))) {

        var _item = shop_items[shop_selection];
        var _result = scr_shop_buy(_item);

        var _textbox = instance_create_layer(
            0, 0, "Instances", obj_dialogue_box
        );

        switch (_result) {

            case "SUCCESS":
                _textbox.text_array = "* You bought the " + _item + ".";
                break;

            case "NO_MONEY":
                _textbox.text_array = "* You don't have enough Dark Dollars.";
                break;

            case "FULL":
                _textbox.text_array = "* Your inventory is full.";
                break;

            default:
                _textbox.text_array = "* Something went wrong.";
                break;
        }

        _textbox.face_array = -1;
        _textbox.dialogue_page = 0;
        _textbox.char_index = 0;
        _textbox.text_visible = "";
    }


    // Back to main menu
    if (keyboard_check_pressed(ord("X"))) {
        shop_state = "MAIN";
        shop_selection = 0;
    }
}




// ============================================================
// SELL MENU
// ============================================================

if (shop_state == "SELL") {

    // --------------------------------------------------------
    // Build a list of items currently in the inventory.
    // --------------------------------------------------------

    var _sell_items = [];

    for (var i = 0; i < array_length(obj_pause_menu.menu_items); i++) {

        var _inventory_item = obj_pause_menu.menu_items[i];

        if (_inventory_item != "Empty Slot") {
            array_push(_sell_items, _inventory_item);
        }
    }


    // --------------------------------------------------------
    // No items to sell
    // --------------------------------------------------------

    if (array_length(_sell_items) == 0) {

        if (keyboard_check_pressed(ord("X")) ||
            keyboard_check_pressed(ord("Z"))) {

            shop_state = "MAIN";
            shop_selection = 0;
        }

        exit;
    }


    // --------------------------------------------------------
    // Keep selection inside the list.
    // --------------------------------------------------------

    if (shop_selection >= array_length(_sell_items)) {
        shop_selection = array_length(_sell_items) - 1;
    }

    if (shop_selection < 0) {
        shop_selection = 0;
    }


    // --------------------------------------------------------
    // Navigation
    // --------------------------------------------------------

 if (keyboard_check_pressed(vk_up)) {

    shop_selection--;

    if (shop_selection < 0) {
        shop_selection = array_length(_sell_items) - 1;
    }
}


if (keyboard_check_pressed(vk_down)) {

    shop_selection++;

    if (shop_selection >= array_length(_sell_items)) {
        shop_selection = 0;
    }
}


// --------------------------------------------------------
// Scrolling
// --------------------------------------------------------

if (shop_selection < shop_sell_scroll) {
    shop_sell_scroll = shop_selection;
}

if (shop_selection >= shop_sell_scroll + 4) {
    shop_sell_scroll = shop_selection - 3;
}


var _sell_max_scroll = max(0, array_length(_sell_items) - 4);

if (shop_sell_scroll > _sell_max_scroll) {
    shop_sell_scroll = _sell_max_scroll;
}


    // --------------------------------------------------------
    // Sell item
    // --------------------------------------------------------

    if (keyboard_check_pressed(ord("Z"))) {

        var _item = _sell_items[shop_selection];

        var _result = scr_shop_sell(_item);


        if (_result == "SUCCESS") {

            var _refund = floor(scr_shop_get_price(_item) * 0.5);

            var _textbox = instance_create_layer(
                0,
                0,
                "Instances",
                obj_dialogue_box
            );

            _textbox.text_array =
                "* You sold the " + _item +
                " for $" + string(_refund) + ".";

            _textbox.face_array = -1;
            _textbox.dialogue_page = 0;
            _textbox.char_index = 0;
            _textbox.text_visible = "";
        }


        // Rebuild the inventory list next frame.
        shop_selection = 0;
    }


    // --------------------------------------------------------
    // Back
    // --------------------------------------------------------

    if (keyboard_check_pressed(ord("X"))) {

        shop_state = "MAIN";
        shop_selection = 0;
    }
}
// ============================================================
// TALK MENU
// ============================================================

if (shop_state == "TALK") {

    // --------------------------------------------------------
    // UP
    // --------------------------------------------------------

    if (keyboard_check_pressed(vk_up)) {

        shop_selection--;

        if (shop_selection < 0) {
            shop_selection = array_length(shop_talk_options) - 1;
        }
    }


    // --------------------------------------------------------
    // DOWN
    // --------------------------------------------------------

    if (keyboard_check_pressed(vk_down)) {

        shop_selection++;

        if (shop_selection >= array_length(shop_talk_options)) {
            shop_selection = 0;
        }
    }


    // --------------------------------------------------------
    // SELECT
    // --------------------------------------------------------

    if (keyboard_check_pressed(ord("Z"))) {

        // Never mind
        if (shop_selection == array_length(shop_talk_options) - 1) {

            shop_state = "MAIN";
            shop_selection = 0;
        }
        else {

            var _textbox = instance_create_layer(
                0,
                0,
                "Instances",
                obj_dialogue_box
            );


         _textbox.text_array = shop_talk_dialogue[shop_selection];

            _textbox.face_array = -1;
            _textbox.dialogue_page = 0;
            _textbox.char_index = 0;
            _textbox.text_visible = "";
        }
    }


    // --------------------------------------------------------
    // BACK
    // --------------------------------------------------------

    if (keyboard_check_pressed(ord("X"))) {

        shop_state = "MAIN";
        shop_selection = 0;
    }
}

