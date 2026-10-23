if instance_exists(obj_shop){visible = false & is_closing = true }

if (room == rm_main_menu) {
    visible = false;
    is_closing = true;
}

if (room == rm_prelude) {
    visible = false;
    is_closing = true;
}


var key_menu = keyboard_check_pressed(ord("C")) || keyboard_check_pressed(vk_lcontrol);

if (key_menu) {
    if (!global.game_frozen) {
        global.game_frozen = true;

        active_screen = "MAIN";
        menu_index = 0;
menu_x         = -200;
menu_target_x  = 32;

// Vertical slide position
menu_y         = -480;
menu_target_y  = 0;

slide_speed    = 0.3;
is_closing     = false;
        visible = true;
    }
    else {
        if (active_screen == "MAIN" && !is_closing) {
            is_closing = true;
        }
    }
}


if (global.game_frozen) {

    // =========================================================
    // CLOSING ANIMATION
    // =========================================================
    if (is_closing) {

        // Slide UP off the screen
        menu_y = lerp(menu_y, -480, slide_speed);

        if (menu_y <= -450) {
            global.game_frozen = false;
            is_closing = false;
            visible = false;

            menu_x = -200;
            menu_y = -480;
        }

        exit;
    }


    // =========================================================
    // OPENING ANIMATION
    // =========================================================

    // Keep horizontal position fixed
    menu_x = lerp(menu_x, menu_target_x, slide_speed);

    // Slide down from above
    menu_y = lerp(menu_y, menu_target_y, slide_speed);


    // =========================================================
    // WAIT UNTIL MENU HAS FINISHED OPENING
    // =========================================================
    if (menu_y >= menu_target_y - 5) {

        menu_y = menu_target_y;


        // --- INPUTS ---
        var key_up     = keyboard_check_pressed(vk_left);
        var key_down   = keyboard_check_pressed(vk_right);
        var key_accept = keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_enter);
        var key_cancel = keyboard_check_pressed(ord("X")) || keyboard_check_pressed(vk_shift);
        var move       = key_down - key_up;


        switch(active_screen) {

            // =====================================================
            // MAIN
            // =====================================================
            case "MAIN":

                if (move != 0) {
                    menu_index += move;

                    if (menu_index < 0)
                        menu_index = array_length(options) - 1;

                    if (menu_index >= array_length(options))
                        menu_index = 0;

                    if (audio_exists(snd_menuselect)) {
                        audio_play_sound(snd_menuselect, 1, false);
                    }
                }


                if (key_accept) {

                    if (menu_index == 3) {
                        is_closing = true;
                    }
                    else {
                        active_screen = options[menu_index];
                        sub_menu_index = 0;
                    }
                }


                if (key_cancel) {
                    is_closing = true;
                }

            break;


            // =====================================================
            // ITEM
            // =====================================================
            case "ITEM":

                if (item_select_state == 0) {

                    if (move != 0) {
                        sub_menu_index += move;

                        if (sub_menu_index < 0)
                            sub_menu_index = array_length(menu_items) - 1;

                        if (sub_menu_index >= array_length(menu_items))
                            sub_menu_index = 0;

                        if (audio_exists(snd_menuselect))
                            audio_play_sound(snd_menuselect, 1, false);
                    }


                    if (key_accept && array_length(menu_items) > 0) {

                        var selected_item = menu_items[sub_menu_index];
                        var item_type = scr_get_item_type(selected_item);

                        if (selected_item != "Empty Slot" && item_type == "CONSUMABLE") {

                            item_select_state = 1;
                            party_select_index = 0;

                            if (audio_exists(snd_menuselect))
                                audio_play_sound(snd_menuselect, 1, false);
                        }
                    }


                    if (key_cancel) {
                        active_screen = "MAIN";
                    }
                }


                else if (item_select_state == 1) {

                    if (move != 0) {

                        party_select_index += move;

                        if (party_select_index < 0)
                            party_select_index = array_length(party) - 1;

                        if (party_select_index >= array_length(party))
                            party_select_index = 0;

                        if (audio_exists(snd_menuselect))
                            audio_play_sound(snd_menuselect, 1, false);
                    }


                    if (key_accept) {

                        var target = party[party_select_index];
                        var selected_item = menu_items[sub_menu_index];

                        if (target.hp < target.max_hp) {

                            var heal_amt = scr_get_item_value(selected_item);

                            target.hp = min(target.max_hp, target.hp + heal_amt);

                            if (audio_exists(snd_heal))
                                audio_play_sound(snd_heal, 1, false);

                            menu_items[sub_menu_index] = "Empty Slot";

                            item_select_state = 0;
                            active_screen = "MAIN";
                        }
                    }


                    if (key_cancel) {

                        item_select_state = 0;

                        if (audio_exists(snd_menuselect))
                            audio_play_sound(snd_menuselect, 1, false);
                    }
                }

            break;


            // =====================================================
            // EQUIP
            // =====================================================
            case "EQUIP":

                if (equip_select_state == 0) {

                    if (move != 0) {

                        party_select_index += move;

                        if (party_select_index < 0)
                            party_select_index = array_length(party) - 1;

                        if (party_select_index >= array_length(party))
                            party_select_index = 0;

                        if (audio_exists(snd_menuselect))
                            audio_play_sound(snd_menuselect, 1, false);
                    }


                    if (key_accept) {

                        equip_select_state = 1;
                        equip_slot_index = 0;

                        if (audio_exists(snd_menuselect))
                            audio_play_sound(snd_menuselect, 1, false);
                    }


                    if (key_cancel) {
                        active_screen = "MAIN";
                    }
                }


                else if (equip_select_state == 1) {

                    if (move != 0) {

                        equip_slot_index = (equip_slot_index == 0) ? 1 : 0;

                        if (audio_exists(snd_menuselect))
                            audio_play_sound(snd_menuselect, 1, false);
                    }


                    if (key_accept) {

                        equip_select_state = 2;
                        equip_item_index = 0;

                        if (audio_exists(snd_menuselect))
                            audio_play_sound(snd_menuselect, 1, false);
                    }


                    if (key_cancel) {

                        equip_select_state = 0;

                        if (audio_exists(snd_menuselect))
                            audio_play_sound(snd_menuselect, 1, false);
                    }
                }


                else if (equip_select_state == 2) {

                    if (move != 0) {

                        equip_item_index += move;

                        if (equip_item_index < 0)
                            equip_item_index = array_length(menu_items) - 1;

                        if (equip_item_index >= array_length(menu_items))
                            equip_item_index = 0;

                        if (audio_exists(snd_menuselect))
                            audio_play_sound(snd_menuselect, 1, false);
                    }


                    if (key_accept) {

                        var char = party[party_select_index];
                        var chosen_item = menu_items[equip_item_index];
                        var item_type = scr_get_item_type(chosen_item);


                        // WEAPON
                        if (equip_slot_index == 0 &&
                            (item_type == "WEAPON" || chosen_item == "Empty Slot")) {

                            var old_gear = char.weapon;

                            char.weapon = chosen_item;

                            menu_items[equip_item_index] =
                                (old_gear == "None") ? "Empty Slot" : old_gear;

                            if (audio_exists(snd_menuselect))
                                audio_play_sound(snd_menuselect, 1, false);

                            save_game_data();

                            equip_select_state = 1;
                        }


                        // ARMOR
                        else if (equip_slot_index == 1 &&
                                 (item_type == "ARMOR" || chosen_item == "Empty Slot")) {

                            var old_gear = char.armor;

                            char.armor = chosen_item;

                            menu_items[equip_item_index] =
                                (old_gear == "None") ? "Empty Slot" : old_gear;

                            if (audio_exists(snd_menuselect))
                                audio_play_sound(snd_menuselect, 1, false);

                            save_game_data();

                            equip_select_state = 1;
                        }
                    }


                    if (key_cancel) {

                        equip_select_state = 1;

                        if (audio_exists(snd_menuselect))
                            audio_play_sound(snd_menuselect, 1, false);
                    }
                }

            break;


            // =====================================================
            // STAT
            // =====================================================
            case "STAT":

                if (key_cancel) {
                    active_screen = "MAIN";
                }

            break;
        }
    }
}