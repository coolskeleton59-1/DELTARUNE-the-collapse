
// ============================================================
// SHOP DRAW GUI
// ============================================================

display_set_gui_size(640, 480);

// Do not draw shop UI while dialogue is active.
if (instance_exists(obj_dialogue_box)) {
    exit;
}

draw_set_font(shop_font);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_alpha(1);


// ============================================================
// SHOP UI PANEL
// ============================================================

var _panel_left = 20;
var _panel_top = 180;
var _panel_right = 620;
var _panel_bottom = 470;


// Black background
draw_set_color(c_black);

draw_rectangle(
    _panel_left,
    _panel_top,
    _panel_right,
    _panel_bottom,
    false
);


// White border
draw_set_color(c_white);

draw_rectangle(
    _panel_left,
    _panel_top,
    _panel_right,
    _panel_bottom,
    true
);


// ============================================================
// TITLE
// ============================================================

draw_set_color(c_white);

draw_text_transformed_color(
    45,
    198,
    "SHOP",
    shop_text_scale,
    shop_text_scale,
    0,
    c_white,
    c_white,
    c_white,
    c_white,
    1
);


// ============================================================
// MONEY
// ============================================================

draw_set_halign(fa_right);

draw_text_transformed_color(
    595,
    198,
    "$" + string(global.money),
    shop_text_scale,
    shop_text_scale,
    0,
    c_white,
    c_white,
    c_white,
    c_white,
    1
);

draw_set_halign(fa_left);


// ============================================================
// MAIN MENU
// ============================================================

if (shop_state == "MAIN") {

    var _menu_x = 220;
    var _menu_y = 255;
    var _menu_spacing = 42;

    var _options = [
        "BUY",
        "SELL",
        "TALK",
        "LEAVE"
    ];

    for (var i = 0; i < array_length(_options); i++) {

        var _y = _menu_y + (i * _menu_spacing);


        // ----------------------------------------------------
        // Cursor
        // ----------------------------------------------------
var _item_index = shop_buy_scroll + i;
        if (_item_index == shop_selection) {

            draw_sprite_ext(
                spr_soul,
                0,
                _menu_x - 30,
                _y + 10,
                1,
                1,
                0,
                c_white,
                1
            );

            draw_set_color(c_yellow);
        }
        else {
            draw_set_color(c_white);
        }


        // ----------------------------------------------------
        // Option
        // ----------------------------------------------------

        draw_text_transformed_color(
            _menu_x,
            _y,
            _options[i],
            shop_text_scale,
            shop_text_scale,
            0,
            c_white,
            c_white,
            c_white,
            c_white,
            1
        );
    }


    // --------------------------------------------------------
    // Controls
    // --------------------------------------------------------

    draw_set_color(c_white);

    draw_text_transformed_color(
        45,
        440,
        "Z: SELECT",
        shop_text_scale,
        shop_text_scale,
        0,
        c_white,
        c_white,
        c_white,
        c_white,
        1
    );

    draw_set_halign(fa_right);

    draw_text_transformed_color(
        595,
        440,
        "X: BACK",
        shop_text_scale,
        shop_text_scale,
        0,
        c_white,
        c_white,
        c_white,
        c_white,
        1
    );

    draw_set_halign(fa_left);
}


// ============================================================
// BUY MENU
// ============================================================

else if (shop_state == "BUY") {

    // --------------------------------------------------------
    // ITEM LIST PANEL
    // --------------------------------------------------------

    var _item_left = 40;
    var _item_top = 245;
    var _item_right = 310;
    var _item_bottom = 415;


    draw_set_color(c_black);

    draw_rectangle(
        _item_left,
        _item_top,
        _item_right,
        _item_bottom,
        false
    );


    draw_set_color(c_white);

    draw_rectangle(
        _item_left,
        _item_top,
        _item_right,
        _item_bottom,
        true
    );


    // --------------------------------------------------------
    // DESCRIPTION PANEL
    // --------------------------------------------------------

    var _desc_left = 325;
    var _desc_top = 245;
    var _desc_right = 600;
    var _desc_bottom = 415;


    draw_set_color(c_black);

    draw_rectangle(
        _desc_left,
        _desc_top,
        _desc_right,
        _desc_bottom,
        false
    );


    draw_set_color(c_white);

    draw_rectangle(
        _desc_left,
        _desc_top,
        _desc_right,
        _desc_bottom,
        true
    );


    // --------------------------------------------------------
    // ITEMS
    // --------------------------------------------------------

    var _item_x = 75;
    var _item_y = 270;
    var _item_spacing = 42;


   var _buy_visible = min(4, array_length(shop_items));

for (var i = 0; i < _buy_visible; i++) {

    var _item_index = shop_buy_scroll + i;

    var _iy = _item_y + (i * _item_spacing);


    // Cursor

    if (_item_index == shop_selection) {

        draw_sprite_ext(
            spr_soul,
            0,
            _item_x - 27,
            _iy + 10,
            1,
            1,
            0,
            c_white,
            1
        );

        draw_set_color(c_yellow);
    }
    else {
        draw_set_color(c_white);
    }


    // Item name

    draw_text_transformed_color(
        _item_x,
        _iy,
        shop_items[_item_index],
        shop_text_scale,
        shop_text_scale,
        0,
        c_white,
        c_white,
        c_white,
        c_white,
        1
    );


    // Price

    draw_set_halign(fa_right);

    draw_set_color(c_white);

    draw_text_transformed_color(
        295,
        _iy,
        "$" + string(
            scr_shop_get_price(shop_items[_item_index])
        ),
        shop_text_scale,
        shop_text_scale,
        0,
        c_white,
        c_white,
        c_white,
        c_white,
        1
    );

    draw_set_halign(fa_left);
}


    // --------------------------------------------------------
    // DESCRIPTION
    // --------------------------------------------------------

    var _selected_item = shop_items[shop_selection];

    draw_set_color(c_white);


    // Item name

    draw_text_transformed_color(
        350,
        270,
        _selected_item,
        shop_text_scale,
        shop_text_scale,
        0,
        c_white,
        c_white,
        c_white,
        c_white,
        1
    );


    // Price

    draw_text_transformed_color(
        350,
        305,
        "$" + string(scr_shop_get_price(_selected_item)),
        shop_text_scale,
        shop_text_scale,
        0,
        c_white,
        c_white,
        c_white,
        c_white,
        1
    );


    // Wrapped description

    draw_text_ext_transformed(
        350,
        345,
        scr_get_item_desc(_selected_item),
        18,
        225,
        shop_text_scale,
        shop_text_scale,
        0
    );


    // --------------------------------------------------------
    // CONTROLS
    // --------------------------------------------------------

    draw_set_color(c_white);

    draw_text_transformed_color(
        45,
        440,
        "Z: BUY",
        shop_text_scale,
        shop_text_scale,
        0,
        c_white,
        c_white,
        c_white,
        c_white,
        1
    );

    draw_set_halign(fa_right);

    draw_text_transformed_color(
        595,
        440,
        "X: BACK",
        shop_text_scale,
        shop_text_scale,
        0,
        c_white,
        c_white,
        c_white,
        c_white,
        1
    );

    draw_set_halign(fa_left);
}


// ============================================================
// SELL MENU
// ============================================================

// ============================================================
// SELL MENU
// ============================================================

else if (shop_state == "SELL") {

    // --------------------------------------------------------
    // Build current sell list
    // --------------------------------------------------------

    var _sell_items = [];

    for (var i = 0; i < array_length(obj_pause_menu.menu_items); i++) {

        var _inventory_item = obj_pause_menu.menu_items[i];

        if (_inventory_item != "Empty Slot") {
            array_push(_sell_items, _inventory_item);
        }
    }


    // --------------------------------------------------------
    // SELL ITEM LIST PANEL
    // --------------------------------------------------------

    var _sell_left = 40;
    var _sell_top = 245;
    var _sell_right = 310;
    var _sell_bottom = 415;


    draw_set_color(c_black);

    draw_rectangle(
        _sell_left,
        _sell_top,
        _sell_right,
        _sell_bottom,
        false
    );


    draw_set_color(c_white);

    draw_rectangle(
        _sell_left,
        _sell_top,
        _sell_right,
        _sell_bottom,
        true
    );


    // --------------------------------------------------------
    // INFORMATION PANEL
    // --------------------------------------------------------

    var _sell_desc_left = 325;
    var _sell_desc_top = 245;
    var _sell_desc_right = 600;
    var _sell_desc_bottom = 415;


    draw_set_color(c_black);

    draw_rectangle(
        _sell_desc_left,
        _sell_desc_top,
        _sell_desc_right,
        _sell_desc_bottom,
        false
    );


    draw_set_color(c_white);

    draw_rectangle(
        _sell_desc_left,
        _sell_desc_top,
        _sell_desc_right,
        _sell_desc_bottom,
        true
    );


    // --------------------------------------------------------
    // ITEMS
    // --------------------------------------------------------

    if (array_length(_sell_items) > 0) {

        var _sell_x = 75;
        var _sell_y = 270;
        var _sell_spacing = 42;


     var _sell_visible = min(4, array_length(_sell_items));

for (var i = 0; i < _sell_visible; i++) {

    var _item_index = shop_sell_scroll + i;

    var _sy = _sell_y + (i * _sell_spacing);


    // Cursor

    if (_item_index == shop_selection) {

        draw_sprite_ext(
            spr_soul,
            0,
            _sell_x - 27,
            _sy + 10,
            1,
            1,
            0,
            c_white,
            1
        );

        draw_set_color(c_yellow);
    }
    else {
        draw_set_color(c_white);
    }


    // Item name

    draw_text_transformed_color(
        _sell_x,
        _sy,
        _sell_items[_item_index],
        shop_text_scale,
        shop_text_scale,
        0,
        c_white,
        c_white,
        c_white,
        c_white,
        1
    );


    // Sell price

    draw_set_halign(fa_right);

    draw_set_color(c_white);

    draw_text_transformed_color(
        295,
        _sy,
        "$" + string(
            floor(
                scr_shop_get_price(_sell_items[_item_index]) * 0.5
            )
        ),
        shop_text_scale,
        shop_text_scale,
        0,
        c_white,
        c_white,
        c_white,
        c_white,
        1
    );

    draw_set_halign(fa_left);
}


        // ----------------------------------------------------
        // Selected item information
        // ----------------------------------------------------

        var _selected_sell_item = _sell_items[shop_selection];


        draw_set_color(c_white);


        // Item name

        draw_text_transformed_color(
            350,
            270,
            _selected_sell_item,
            shop_text_scale,
            shop_text_scale,
            0,
            c_white,
            c_white,
            c_white,
            c_white,
            1
        );


        // Sell price

        draw_text_transformed_color(
            350,
            305,
            "Sell for $" +
            string(
                floor(
                    scr_shop_get_price(_selected_sell_item) * 0.5
                )
            ),
            shop_text_scale,
            shop_text_scale,
            0,
            c_white,
            c_white,
            c_white,
            c_white,
            1
        );


        // Description

        draw_text_ext_transformed(
            350,
            345,
            scr_get_item_desc(_selected_sell_item),
            18,
            225,
            shop_text_scale,
            shop_text_scale,
            0
        );
    }
    else {

        // ----------------------------------------------------
        // Empty inventory
        // ----------------------------------------------------

        draw_set_color(c_white);

        draw_text_transformed_color(
            75,
            270,
            "Your inventory is empty.",
            shop_text_scale,
            shop_text_scale,
            0,
            c_white,
            c_white,
            c_white,
            c_white,
            1
        );


        draw_text_transformed_color(
            350,
            270,
            "Nothing to sell.",
            shop_text_scale,
            shop_text_scale,
            0,
            c_white,
            c_white,
            c_white,
            c_white,
            1
        );
    }


    // --------------------------------------------------------
    // CONTROLS
    // --------------------------------------------------------

    draw_set_color(c_white);

    draw_text_transformed_color(
        45,
        440,
        "Z: SELL",
        shop_text_scale,
        shop_text_scale,
        0,
        c_white,
        c_white,
        c_white,
        c_white,
        1
    );


    draw_set_halign(fa_right);

    draw_text_transformed_color(
        595,
        440,
        "X: BACK",
        shop_text_scale,
        shop_text_scale,
        0,
        c_white,
        c_white,
        c_white,
        c_white,
        1
    );

    draw_set_halign(fa_left);
}

// ============================================================
// TALK MENU
// ============================================================

else if (shop_state == "TALK") {

    // --------------------------------------------------------
    // TALK OPTIONS PANEL
    // --------------------------------------------------------

    var _talk_left = 40;
    var _talk_top = 245;
    var _talk_right = 600;
    var _talk_bottom = 415;


    draw_set_color(c_black);

    draw_rectangle(
        _talk_left,
        _talk_top,
        _talk_right,
        _talk_bottom,
        false
    );


    draw_set_color(c_white);

    draw_rectangle(
        _talk_left,
        _talk_top,
        _talk_right,
        _talk_bottom,
        true
    );


    // --------------------------------------------------------
    // OPTIONS
    // --------------------------------------------------------

    var _talk_x = 100;
    var _talk_y = 265;
    var _talk_spacing = 35;


    for (var i = 0; i < array_length(shop_talk_options); i++) {

        var _ty = _talk_y + (i * _talk_spacing);


        // Cursor
		var _item_index = shop_buy_scroll + i;

        if (_item_index == shop_selection) {

            draw_sprite_ext(
                spr_soul,
                0,
                _talk_x - 30,
                _ty + 10,
                1,
                1,
                0,
                c_white,
                1
            );

            draw_set_color(c_yellow);
        }
        else {
            draw_set_color(c_white);
        }


        // Option

        draw_text_transformed_color(
            _talk_x,
            _ty,
            shop_talk_options[i],
            shop_text_scale,
            shop_text_scale,
            0,
            c_white,
            c_white,
            c_white,
            c_white,
            1
        );
    }


    // --------------------------------------------------------
    // CONTROLS
    // --------------------------------------------------------

    draw_set_color(c_white);

    draw_text_transformed_color(
        45,
        440,
        "Z: TALK",
        shop_text_scale,
        shop_text_scale,
        0,
        c_white,
        c_white,
        c_white,
        c_white,
        1
    );


    draw_set_halign(fa_right);

    draw_text_transformed_color(
        595,
        440,
        "X: BACK",
        shop_text_scale,
        shop_text_scale,
        0,
        c_white,
        c_white,
        c_white,
        c_white,
        1
    );

    draw_set_halign(fa_left);
}


// ============================================================
// RESET DRAW STATE
// ============================================================

draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
