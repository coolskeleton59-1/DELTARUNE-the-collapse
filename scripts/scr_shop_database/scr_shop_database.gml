function scr_shop_get_item(_item_name) {
    switch (_item_name) {
        case "Dark Candy":
            return {
                name: "Dark Candy",
                price: 40
            };

        case "Choco Diamond":
            return {
                name: "Choco Diamond",
                price: 80
            };

        case "LuminShroom":
            return {
                name: "LuminShroom",
                price: 30
            };

        case "ReviveMint":
            return {
                name: "ReviveMint",
                price: 100
            };

        case "SpookSword":
            return {
                name: "SpookSword",
                price: 150
            };

        case "BraveAxe":
            return {
                name: "BraveAxe",
                price: 250
            };

        case "MOSS":
            return {
                name: "MOSS",
                price: 1
            };

        case "RangersHat":
            return {
                name: "RangersHat",
                price: 100
            };

        case "AmberPin":
            return {
                name: "AmberPin",
                price: 125
            };
    }

    return undefined;
}
