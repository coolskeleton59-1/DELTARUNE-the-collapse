function scr_shop_get_stock() {
    return [
        "Dark Candy",
        "Choco Diamond",
        "LuminShroom"
    ];
}

function scr_shop_get_price(_item_name) {
    switch (_item_name) {
        case "Dark Candy":
            return 40;

        case "Choco Diamond":
            return 80;

        case "LuminShroom":
            return 30;

        case "ReviveMint":
            return 100;

        case "SpookSword":
            return 150;

        case "BraveAxe":
            return 250;

        case "RangersHat":
            return 100;

        case "AmberPin":
            return 125;

        case "MOSS":
            return 1;
    }

    return -1;
}