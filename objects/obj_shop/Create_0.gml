/// obj_shop - Create

// --------------------------------------------------
// SHOP CONFIGURATION
// --------------------------------------------------

shop_items = [];

shop_selection = 0;
shop_state = "MAIN";
shop_buy_scroll = 0;
shop_sell_scroll = 0;
// ============================================================
// TALK MENU
// ============================================================

shop_talk_options = [
    "About the shop",
    "About the shopkeeper",
    "About the town",
    "Never mind"
];
shop_talk_dialogue = [
    "* It's a pretty strange shop.",
    "* The shopkeeper looks at you.",
    "* You don't know much about this town."
];



// --------------------------------------------------
// UI
// --------------------------------------------------

shop_font = fnt_menu_sub;

shop_text_scale = 0.75;

// 640x480 native GUI coordinates
shop_left = 40;
shop_top = 40;

shop_right = 600;
shop_bottom = 440;
shop_dialogue_active = false;