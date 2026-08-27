function scr_get_item_type(_item_name) {
    switch(_item_name) {
        case "Dark Candy":    return "CONSUMABLE";
        case "Choco Diamond": return "CONSUMABLE";
        case "LuminShroom":   return "CONSUMABLE";
        case "ReviveMint":    return "CONSUMABLE";
        
        case "SpookSword":    return "WEAPON";
        case "BraveAxe":      return "WEAPON";
         case "MOSS": return "CONSUMABLE";
        case "RangersHat":    return "ARMOR";
        case "AmberPin":      return "ARMOR";
        
        default:              return "EMPTY";
    }
}

function scr_get_item_value(_item_name) {
    switch(_item_name) {
        case "Dark Candy":    return 40;
        case "Choco Diamond": return 80;
		 case "MOSS": return 10000000000;
        case "LuminShroom":   return 30;
        case "ReviveMint":    return 999; // Full heal marker
        
        case "SpookSword":    return 12; // ATK Power
        case "BraveAxe":      return 18; // ATK Power
        
        case "RangersHat":    return 4;  // DEF Power
        case "AmberPin":      return 6;  // DEF Power
        
        default:              return 0;
    }
}

function scr_get_item_desc(_item_name) {
    switch(_item_name) {
        case "Dark Candy":    return "Heals 40 HP. Concentrated darkness flavor.";
        case "Choco Diamond": return "Heals 80 HP. Rich, sharp diamond cocoa block.";
        case "LuminShroom":   return "Heals 30 HP. Shines softly in the darkness.";
        case "ReviveMint":    return "Brings a fallen ally back to life instantly.";
        
        case "SpookSword":    return "Weapon: ATK +12. Crafted from ancient polished bones.";
        case "BraveAxe":      return "Weapon: ATK +18. Heavy cleaver forged for power.";
         case "MOSS": return "the supreme food.";
        case "RangersHat":    return "Armor: DEF +4. Sturdy wide-brim ranger wear.";
        case "AmberPin":      return "Armor: DEF +6. A glowing gemstone pin, warm to hold.";
        
        default:              return "";
    }
}
