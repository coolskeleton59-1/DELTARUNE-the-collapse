// Configuration variables
fade_speed = 0.02;      // How fast the screen fades (Higher = faster)
target_room = noone;    // The room we want to go to

// State tracking variables
fade_alpha = 0;         // Current transparency (0 = transparent, 1 = solid black)
fade_state = 1;         // 1 = Fading Out to Black, -1 = Fading In from Black

global.game_frozen = true; // Stop all player inputs
