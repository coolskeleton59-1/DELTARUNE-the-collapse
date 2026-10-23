// ============================================================
// PAUSE MENU DRAW GUI
// ============================================================

if (!visible) exit;

var ts = 0.75;

if (font_exists(fnt_menu_sub)) {
    draw_set_font(fnt_menu_sub);
}

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_alpha(1);

var col_white    = c_white;
var col_black    = c_black;
var col_gray     = make_color_rgb(150, 150, 150);
var col_darkgray = make_color_rgb(45, 35, 50);
var col_purple   = make_color_rgb(100, 70, 110);
var col_cyan     = make_color_rgb(0, 255, 255);
var col_red      = make_color_rgb(255, 30, 40);
var col_yellow   = make_color_rgb(255, 225, 0);
var col_green    = make_color_rgb(0, 255, 40);
var col_magenta  = make_color_rgb(255, 0, 240);


// ============================================================
// GUI SCALING
// ============================================================

var _win_w = window_get_width();
var _win_h = window_get_height();

if (window_get_fullscreen()) 
{
    var _board_x = _win_w * 0.150;
    var _board_y = _win_h * 0.035;
    var _board_w = _win_w * 0.702;
    var _board_h = _win_h * 0.915;

    var _game_native_w = 640;
    var _game_native_h = 480;

    var _scale_x = _board_w / _game_native_w;
    var _scale_y = _board_h / _game_native_h;

    var _final_scale = min(_scale_x, _scale_y);

    var _game_draw_x = _board_x +
        ((_board_w - (_game_native_w * _final_scale)) / 2);

    var _game_draw_y = _board_y +
        ((_board_h - (_game_native_h * _final_scale)) / 2);

    display_set_gui_size(640, 480);

    display_set_gui_maximise(
        _final_scale,
        _final_scale,
        _game_draw_x,
        _game_draw_y
    );
}
else 
{
    display_set_gui_size(640, 480);

    var _win_scale_x = _win_w / 640;
    var _win_scale_y = _win_h / 480;

    display_set_gui_maximise(
        _win_scale_x,
        _win_scale_y,
        0,
        0
    );
}


// ============================================================
// VERTICAL SLIDE
// Everything in the pause menu uses this offset.
// ============================================================

var _slide_y = menu_y;


// ============================================================
// TOP BLACK BAR
// ============================================================

draw_set_alpha(1);
draw_set_color(col_black);

draw_rectangle(
    0,
    0 + _slide_y,
    640,
    80 + _slide_y,
    false
);


// ============================================================
// TOP MENU TABS
// ============================================================

var top_x = 20;
var top_y = 20 + _slide_y;
var top_w = 100;
var top_h = 48;
var top_gap = 10;


// ------------------------------------------------------------
// ITEM
// ------------------------------------------------------------

var item_sprite = spr_item_noslect;

if (menu_index == 0) {
    item_sprite = spr_item_slect;
}

draw_set_color(col_black);

draw_rectangle(
    top_x,
    top_y,
    top_x + top_w,
    top_y + top_h,
    false
);

if (sprite_exists(item_sprite)) {
    draw_sprite_ext(
        item_sprite,
        0,
        top_x + (top_w / 2),
        top_y + (top_h / 2),
        2,
        2,
        0,
        col_white,
        1
    );
}


// ------------------------------------------------------------
// EQUIP
// ------------------------------------------------------------

var equip_x = top_x + (top_w + top_gap);

var equip_sprite = spr_equip_noslect;

if (menu_index == 1) {
    equip_sprite = spr_equip_slect;
}

draw_set_color(col_black);

draw_rectangle(
    equip_x,
    top_y,
    equip_x + top_w,
    top_y + top_h,
    false
);

if (sprite_exists(equip_sprite)) {
    draw_sprite_ext(
        equip_sprite,
        0,
        equip_x + (top_w / 2),
        top_y + (top_h / 2),
        2,
        2,
        0,
        col_white,
        1
    );
}


// ------------------------------------------------------------
// STAT
// ------------------------------------------------------------

var stat_x = top_x + ((top_w + top_gap) * 2);

var stat_sprite = spr_stat_noslect;

if (menu_index == 2) {
    stat_sprite = spr_stat_slect;
}

draw_set_color(col_black);

draw_rectangle(
    stat_x,
    top_y,
    stat_x + top_w,
    top_y + top_h,
    false
);

if (sprite_exists(stat_sprite)) {
    draw_sprite_ext(
        stat_sprite,
        0,
        stat_x + (top_w / 2),
        top_y + (top_h / 2),
        2,
        2,
        0,
        col_white,
        1
    );
}


// ------------------------------------------------------------
// CLOSE
// ------------------------------------------------------------

var close_x = top_x + ((top_w + top_gap) * 3);

var close_sprite = spr_close_noslect;

if (menu_index == 3) {
    close_sprite = spr_close_slect;
}

draw_set_color(col_black);

draw_rectangle(
    close_x,
    top_y,
    close_x + top_w,
    top_y + top_h,
    false
);

if (sprite_exists(close_sprite)) {
    draw_sprite_ext(
        close_sprite,
        0,
        close_x + (top_w / 2),
        top_y + (top_h / 2),
        2,
        2,
        0,
        col_white,
        1
    );
}


// ============================================================
// SUB-MENU BOX
// ============================================================

if (active_screen != "MAIN") {

    var box_x1 = 60;
    var box_y1 = 88 + _slide_y;
    var box_x2 = 580;
    var box_y2 = 420 + _slide_y;


    // ========================================================
    // NINE-SLICE BOX
    // ========================================================

    var _s = spr_menu_box;

    if (sprite_exists(_s)) {

        var _w = box_x2 - box_x1;
        var _h = box_y2 - box_y1;

        var _b_size   = 24;
        var _mid_size = 192 - (_b_size * 2);
        var _opp_edge = 192 - _b_size;


        // ----------------------------------------------------
        // FOUR CORNERS
        // ----------------------------------------------------

        draw_sprite_part(
            _s, 0,
            0, 0,
            _b_size, _b_size,
            box_x1, box_y1
        );

        draw_sprite_part(
            _s, 0,
            _opp_edge, 0,
            _b_size, _b_size,
            box_x1 + _w - _b_size,
            box_y1
        );

        draw_sprite_part(
            _s, 0,
            0, _opp_edge,
            _b_size, _b_size,
            box_x1,
            box_y1 + _h - _b_size
        );

        draw_sprite_part(
            _s, 0,
            _opp_edge, _opp_edge,
            _b_size, _b_size,
            box_x1 + _w - _b_size,
            box_y1 + _h - _b_size
        );


        // ----------------------------------------------------
        // EDGE SCALING
        // ----------------------------------------------------

        var _horiz_scale =
            (_w - (_b_size * 2)) / _mid_size;

        var _vert_scale =
            (_h - (_b_size * 2)) / _mid_size;


        // ----------------------------------------------------
        // TOP BORDER
        // ----------------------------------------------------

        draw_sprite_part_ext(
            _s, 0,
            _b_size, 0,
            _mid_size, _b_size,
            box_x1 + _b_size,
            box_y1,
            _horiz_scale,
            1,
            col_white,
            1
        );


        // ----------------------------------------------------
        // BOTTOM BORDER
        // ----------------------------------------------------

        draw_sprite_part_ext(
            _s, 0,
            _b_size, _opp_edge,
            _mid_size, _b_size,
            box_x1 + _b_size,
            box_y1 + _h - _b_size,
            _horiz_scale,
            1,
            col_white,
            1
        );


        // ----------------------------------------------------
        // LEFT BORDER
        // ----------------------------------------------------

        draw_sprite_part_ext(
            _s, 0,
            0, _b_size,
            _b_size, _mid_size,
            box_x1,
            box_y1 + _b_size,
            1,
            _vert_scale,
            col_white,
            1
        );


        // ----------------------------------------------------
        // RIGHT BORDER
        // ----------------------------------------------------

        draw_sprite_part_ext(
            _s, 0,
            _opp_edge, _b_size,
            _b_size, _mid_size,
            box_x1 + _w - _b_size,
            box_y1 + _b_size,
            1,
            _vert_scale,
            col_white,
            1
        );


        // ----------------------------------------------------
        // CENTER
        // ----------------------------------------------------

        draw_sprite_part_ext(
            _s, 0,
            _b_size, _b_size,
            _mid_size, _mid_size,
            box_x1 + _b_size,
            box_y1 + _b_size,
            _horiz_scale,
            _vert_scale,
            col_white,
            1
        );
    }


    // ========================================================
    // HEADER
    // ========================================================

    var header_color = col_white;

    if (active_screen == "ITEM" && item_select_state == 1) {
        header_color = col_yellow;
    }

    if (active_screen == "EQUIP" && equip_select_state == 0) {
        header_color = col_yellow;
    }


    if (active_screen == "ITEM" && item_select_state == 1) {

        draw_text_transformed_color(
            103,
            108 + _slide_y,
            "WHO TO HEAL?",
            ts, ts, 0,
            header_color,
            header_color,
            header_color,
            header_color,
            1
        );

    }
    else if (active_screen == "EQUIP" && equip_select_state == 0) {

        draw_text_transformed_color(
            103,
            108 + _slide_y,
            "MANAGE WHO?",
            ts, ts, 0,
            header_color,
            header_color,
            header_color,
            header_color,
            1
        );

    }
    else {

        draw_text_transformed_color(
            103,
            108 + _slide_y,
            string_upper(string(active_screen)),
            ts, ts, 0,
            header_color,
            header_color,
            header_color,
            header_color,
            1
        );
    }


    // ========================================================
    // DEFAULT DESCRIPTION
    // ========================================================

    var current_desc_text =
        "Select an option from your backpack stash.";


    // ========================================================
    // ITEM SCREEN
    // ========================================================

    if (active_screen == "ITEM") {

        var item_x = 103;
        var item_y_start = 148 + _slide_y;
        var item_spacing = 32;


        // ----------------------------------------------------
        // INVENTORY LIST
        // ----------------------------------------------------

        for (var ii = 0; ii < array_length(menu_items); ii++) {

            var iy =
                item_y_start +
                (ii * item_spacing);

            var item_selected =
                (item_select_state == 0 &&
                 ii == sub_menu_index);

            var item_color =
                item_selected ? col_yellow : col_white;


            if (item_selected) {

                if (sprite_exists(spr_soul)) {

                    draw_sprite_ext(
                        spr_soul,
                        0,
                        item_x - 17,
                        iy + 7,
                        1,
                        1,
                        0,
                        col_red,
                        1
                    );

                }
                else {

                    draw_set_color(col_red);

                    draw_rectangle(
                        item_x - 18,
                        iy + 6,
                        item_x - 7,
                        iy + 17,
                        false
                    );
                }
            }


            draw_text_transformed_color(
                item_x,
                iy,
                string(menu_items[ii]),
                ts, ts, 0,
                item_color,
                item_color,
                item_color,
                item_color,
                1
            );
        }


        // ----------------------------------------------------
        // ITEM DESCRIPTION
        // ----------------------------------------------------

        if (array_length(menu_items) > 0) {

            current_desc_text =
                scr_get_item_desc(
                    menu_items[sub_menu_index]
                );
        }


        // ----------------------------------------------------
        // CHARACTER TARGETING
        // ----------------------------------------------------

        if (item_select_state == 1) {

            draw_set_color(col_darkgray);

            draw_rectangle(
                310,
                140 + _slide_y,
                312,
                365 + _slide_y,
                false
            );


            var target_x = 340;
            var target_y = 150 + _slide_y;
            var target_spacing = 60;


            for (var tp = 0; tp < array_length(party); tp++) {

                var t_member = party[tp];

                var ty =
                    target_y +
                    (tp * target_spacing);

                var target_selected =
                    (tp == party_select_index);

                var target_color =
                    target_selected ? col_cyan : col_white;


                if (target_selected) {

                    if (sprite_exists(spr_soul)) {

                        draw_sprite_ext(
                            spr_soul,
                            0,
                            target_x - 23,
                            ty + 7,
                            1,
                            1,
                            0,
                            col_red,
                            1
                        );

                    }
                    else {

                        draw_set_color(col_red);

                        draw_rectangle(
                            target_x - 23,
                            ty + 6,
                            target_x - 12,
                            ty + 17,
                            false
                        );
                    }
                }


                draw_text_transformed_color(
                    target_x,
                    ty,
                    string(t_member.name),
                    ts, ts, 0,
                    target_color,
                    target_color,
                    target_color,
                    target_color,
                    1
                );


                draw_text_transformed_color(
                    target_x,
                    ty + 23,
                    "HP",
                    ts * 0.8,
                    ts * 0.8,
                    0,
                    col_gray,
                    col_gray,
                    col_gray,
                    col_gray,
                    1
                );


                draw_text_transformed_color(
                    target_x + 28,
                    ty + 23,
                    string(t_member.hp) +
                    "/" +
                    string(t_member.max_hp),
                    ts * 0.8,
                    ts * 0.8,
                    0,
                    target_color,
                    target_color,
                    target_color,
                    target_color,
                    1
                );
            }
        }
    }


    // ========================================================
    // EQUIP SCREEN
    // ========================================================

    else if (active_screen == "EQUIP") {

        var eq_member = party[party_select_index];

        var stat_x = 103;
        var stat_y = 148 + _slide_y;


        var name_color =
            (equip_select_state == 0)
            ? col_cyan
            : col_white;


        draw_text_transformed_color(
            stat_x,
            stat_y,
            string(eq_member.name),
            ts * 1.2,
            ts * 1.2,
            0,
            name_color,
            name_color,
            name_color,
            name_color,
            1
        );


        var wp_val =
            scr_get_item_value(eq_member.weapon);

        var ar_val =
            scr_get_item_value(eq_member.armor);


        draw_text_transformed_color(
            stat_x,
            stat_y + 40,
            "LV " + string(eq_member.lv),
            ts, ts, 0,
            col_white,
            col_white,
            col_white,
            col_white,
            1
        );


        draw_text_transformed_color(
            stat_x,
            stat_y + 70,
            "ATK " +
            string(10 + wp_val) +
            " (" +
            string(wp_val) +
            ")",
            ts, ts, 0,
            col_yellow,
            col_yellow,
            col_yellow,
            col_yellow,
            1
        );


        draw_text_transformed_color(
            stat_x,
            stat_y + 100,
            "DEF " +
            string(2 + ar_val) +
            " (" +
            string(ar_val) +
            ")",
            ts, ts, 0,
            col_green,
            col_green,
            col_green,
            col_green,
            1
        );


        draw_set_color(col_darkgray);

        draw_rectangle(
            290,
            140 + _slide_y,
            292,
            365 + _slide_y,
            false
        );


        var right_column_x = 320;


        // ====================================================
        // EQUIPMENT SLOTS
        // ====================================================

        if (equip_select_state == 0 ||
            equip_select_state == 1) {


            // ------------------------------------------------
            // WEAPON
            // ------------------------------------------------

            var slot_w_selected =
                (equip_select_state == 1 &&
                 equip_slot_index == 0);

            var slot_w_color =
                slot_w_selected
                ? col_cyan
                : col_white;


            if (slot_w_selected) {

                if (sprite_exists(spr_soul)) {

                    draw_sprite_ext(
                        spr_soul,
                        0,
                        right_column_x - 18,
                        stat_y + 14,
                        1,
                        1,
                        0,
                        col_red,
                        1
                    );

                }
                else {

                    draw_set_color(col_red);

                    draw_rectangle(
                        right_column_x - 18,
                        stat_y + 12,
                        right_column_x - 8,
                        stat_y + 22,
                        false
                    );
                }
            }


            draw_text_transformed_color(
                right_column_x,
                stat_y,
                "Weapon:",
                ts * 0.9,
                ts * 0.9,
                0,
                col_gray,
                col_gray,
                col_gray,
                col_gray,
                1
            );


            draw_text_transformed_color(
                right_column_x + 85,
                stat_y,
                string(eq_member.weapon),
                ts,
                ts,
                0,
                slot_w_color,
                slot_w_color,
                slot_w_color,
                slot_w_color,
                1
            );


            // ------------------------------------------------
            // ARMOR
            // ------------------------------------------------

            var slot_a_selected =
                (equip_select_state == 1 &&
                 equip_slot_index == 1);

            var slot_a_color =
                slot_a_selected
                ? col_cyan
                : col_white;


            if (slot_a_selected) {

                if (sprite_exists(spr_soul)) {

                    draw_sprite_ext(
                        spr_soul,
                        0,
                        right_column_x - 18,
                        stat_y + 54,
                        1,
                        1,
                        0,
                        col_red,
                        1
                    );

                }
                else {

                    draw_set_color(col_red);

                    draw_rectangle(
                        right_column_x - 18,
                        stat_y + 52,
                        right_column_x - 8,
                        stat_y + 62,
                        false
                    );
                }
            }


            draw_text_transformed_color(
                right_column_x,
                stat_y + 40,
                "Armor:",
                ts * 0.9,
                ts * 0.9,
                0,
                col_gray,
                col_gray,
                col_gray,
                col_gray,
                1
            );


            draw_text_transformed_color(
                right_column_x + 85,
                stat_y + 40,
                string(eq_member.armor),
                ts,
                ts,
                0,
                slot_a_color,
                slot_a_color,
                slot_a_color,
                slot_a_color,
                1
            );


            if (equip_select_state == 0) {

                current_desc_text =
                    "Select a party member to configure.";

            }
            else {

                current_desc_text =
                    (equip_slot_index == 0)
                    ? scr_get_item_desc(eq_member.weapon)
                    : scr_get_item_desc(eq_member.armor);
            }
        }


        // ====================================================
        // EQUIPMENT ITEM SELECTION
        // ====================================================

        else if (equip_select_state == 2) {

            var target_filter =
                (equip_slot_index == 0)
                ? "WEAPON"
                : "ARMOR";


            draw_text_transformed_color(
                right_column_x,
                stat_y,
                "SELECT " + target_filter + ":",
                ts * 0.9,
                ts * 0.9,
                0,
                col_yellow,
                col_yellow,
                col_yellow,
                col_yellow,
                1
            );


            var row_y_start = stat_y + 36;
            var spacing_row = 30;


            for (var k = 0;
                 k < array_length(menu_items);
                 k++) {

                var current_itm =
                    menu_items[k];

                var current_row_y =
                    row_y_start +
                    (k * spacing_row);

                var row_item_type =
                    scr_get_item_type(current_itm);

                var is_compatible =
                    (row_item_type == target_filter ||
                     current_itm == "Empty Slot");

                var display_color =
                    is_compatible
                    ? col_white
                    : col_darkgray;


                if (k == equip_item_index) {

                    display_color =
                        is_compatible
                        ? col_cyan
                        : col_purple;
                }


                if (k == equip_item_index) {

                    if (sprite_exists(spr_soul)) {

                        draw_sprite_ext(
                            spr_soul,
                            0,
                            right_column_x - 18,
                            current_row_y + 4,
                            1,
                            1,
                            0,
                            col_red,
                            1
                        );

                    }
                    else {

                        draw_set_color(col_red);

                        draw_rectangle(
                            right_column_x - 18,
                            current_row_y + 2,
                            right_column_x - 8,
                            current_row_y + 12,
                            false
                        );
                    }
                }


                draw_text_transformed_color(
                    right_column_x,
                    current_row_y,
                    string(current_itm),
                    ts,
                    ts,
                    0,
                    display_color,
                    display_color,
                    display_color,
                    display_color,
                    1
                );
            }


            if (array_length(menu_items) > 0) {

                current_desc_text =
                    scr_get_item_desc(
                        menu_items[equip_item_index]
                    );
            }
        }
    }


    // ========================================================
    // OTHER SCREENS
    // ========================================================

    else {

        draw_text_transformed_color(
            103,
            150 + _slide_y,
            string_upper(string(active_screen)),
            ts,
            ts,
            0,
            col_cyan,
            col_cyan,
            col_cyan,
            col_cyan,
            1
        );


        draw_text_transformed_color(
            103,
            185 + _slide_y,
            "Nothing here yet.",
            ts,
            ts,
            0,
            col_gray,
            col_gray,
            col_gray,
            col_gray,
            1
        );
    }


    // ========================================================
    // DIVIDER
    // ========================================================

    draw_set_color(col_darkgray);

    draw_line(
        box_x1 + 40,
        360 + _slide_y,
        box_x2 - 40,
        360 + _slide_y
    );


    // ========================================================
    // DESCRIPTION
    // ========================================================

    draw_text_transformed_color(
        103,
        368 + _slide_y,
        current_desc_text,
        ts * 0.9,
        ts * 0.9,
        0,
        col_gray,
        col_gray,
        col_gray,
        col_gray,
        1
    );


    // ========================================================
    // CONTROLS
    // ========================================================

    if (active_screen == "ITEM" &&
        item_select_state == 1) {

        draw_text_transformed_color(
            103,
            390 + _slide_y,
            "[Z] CONFIRM",
            ts * 0.8,
            ts * 0.8,
            0,
            col_white,
            col_white,
            col_white,
            col_white,
            1
        );


        draw_text_transformed_color(
            225,
            390 + _slide_y,
            "[X] CANCEL",
            ts * 0.8,
            ts * 0.8,
            0,
            col_white,
            col_white,
            col_white,
            col_white,
            1
        );
    }

    else if (active_screen == "EQUIP" &&
             equip_select_state > 0) {

        draw_text_transformed_color(
            103,
            390 + _slide_y,
            "[Z] SELECT",
            ts * 0.8,
            ts * 0.8,
            0,
            col_white,
            col_white,
            col_white,
            col_white,
            1
        );


        draw_text_transformed_color(
            225,
            390 + _slide_y,
            "[X] BACK",
            ts * 0.8,
            ts * 0.8,
            0,
            col_white,
            col_white,
            col_white,
            col_white,
            1
        );
    }

    else {

        draw_text_transformed_color(
            103,
            390 + _slide_y,
            "[X] RETURN",
            ts * 0.8,
            ts * 0.8,
            0,
            col_gray,
            col_gray,
            col_gray,
            col_gray,
            1
        );
    }
}


// ============================================================
// PARTY STATUS BAR
// ============================================================

var party_y = 426 + _slide_y;


for (var pp = 0;
     pp < array_length(party);
     pp++) {

    var p_member = party[pp];

    var px =
        12 + (pp * 207);

    var icon_color = col_yellow;

    if (pp == 0) {
        icon_color = col_cyan;
    }

    if (pp == 1) {
        icon_color = col_magenta;
    }


    // --------------------------------------------------------
    // CHARACTER ICON
    // --------------------------------------------------------

    draw_set_color(icon_color);

    draw_rectangle(
        px,
        party_y + 5,
        px + 28,
        party_y + 28,
        false
    );


    // --------------------------------------------------------
    // NAME
    // --------------------------------------------------------

    draw_text_transformed_color(
        px + 37,
        party_y,
        string(p_member.name),
        ts,
        ts,
        0,
        col_white,
        col_white,
        col_white,
        col_white,
        1
    );


    // --------------------------------------------------------
    // HP LABEL
    // --------------------------------------------------------

    draw_text_transformed_color(
        px + 95,
        party_y + 3,
        "HP",
        ts * 0.8,
        ts * 0.8,
        0,
        col_white,
        col_white,
        col_white,
        col_white,
        1
    );


    // --------------------------------------------------------
    // HP NUMBERS
    // --------------------------------------------------------

    draw_text_transformed_color(
        px + 123,
        party_y,
        string(p_member.hp) +
        "/" +
        string(p_member.max_hp),
        ts * 0.8,
        ts * 0.8,
        0,
        col_white,
        col_white,
        col_white,
        col_white,
        1
    );


    // --------------------------------------------------------
    // HP BAR
    // --------------------------------------------------------

    var hp_x = px + 95;
    var hp_y = party_y + 27;
    var hp_w = 105;
    var hp_h = 7;

    var hp_percent = 0;

    if (p_member.max_hp > 0) {
        hp_percent =
            p_member.hp /
            p_member.max_hp;
    }

    hp_percent =
        clamp(hp_percent, 0, 1);


    draw_set_color(
        make_color_rgb(45, 45, 45)
    );

    draw_rectangle(
        hp_x,
        hp_y,
        hp_x + hp_w,
        hp_y + hp_h,
        false
    );


    draw_set_color(icon_color);

    draw_rectangle(
        hp_x,
        hp_y,
        hp_x + (hp_w * hp_percent),
        hp_y + hp_h,
        false
    );
}


// ============================================================
// RESET DRAW SETTINGS
// ============================================================

draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

// ============================================================
// FULLSCREEN BORDER — DRAW LAST
// ============================================================

if (window_get_fullscreen())
{
    // Save the normal 640x480 GUI setup by simply drawing
    // the border in window coordinates, then restore it.

    display_set_gui_size(
        window_get_width(),
        window_get_height()
    );

    display_set_gui_maximise(
        1,
        1,
        0,
        0
    );

    gpu_set_texfilter(true);

    draw_sprite_stretched(
        spr_fullscreen_border,
        0,
        0,
        0,
        window_get_width(),
        window_get_height()
    );

    gpu_set_texfilter(false);


    // --------------------------------------------------------
    // RESTORE THE GAME'S NORMAL GUI SCALE
    // --------------------------------------------------------

    var _win_w_restore = window_get_width();
    var _win_h_restore = window_get_height();

    var _board_x_restore = _win_w_restore * 0.150;
    var _board_y_restore = _win_h_restore * 0.035;
    var _board_w_restore = _win_w_restore * 0.702;
    var _board_h_restore = _win_h_restore * 0.915;

    var _scale_x_restore = _board_w_restore / 640;
    var _scale_y_restore = _board_h_restore / 480;

    var _final_scale_restore =
        min(_scale_x_restore, _scale_y_restore);

    var _game_draw_w_restore =
        640 * _final_scale_restore;

    var _game_draw_h_restore =
        480 * _final_scale_restore;

    var _game_draw_x_restore =
        _board_x_restore +
        ((_board_w_restore - _game_draw_w_restore) / 2);

    var _game_draw_y_restore =
        _board_y_restore +
        ((_board_h_restore - _game_draw_h_restore) / 2);

    display_set_gui_size(640, 480);

    display_set_gui_maximise(
        _final_scale_restore,
        _final_scale_restore,
        _game_draw_x_restore,
        _game_draw_y_restore
    );
}