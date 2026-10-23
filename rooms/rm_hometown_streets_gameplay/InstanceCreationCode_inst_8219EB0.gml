// ========================================================
// NOELLE AWAKENING DIALOGUE (NATIVE ARRAY COUPLING)
// ========================================================

if (global.truce_phase == 2) {
    // 1. Core Portrait Array Handoff
    face_array = [
        spr_noellestill, spr_noellestill, spr_susie_normal, spr_susie_normal, 
        spr_noellestill, -1, spr_noellestill, spr_noellestill, 
        spr_noellestill, spr_susie_smile
    ];

    // 2. Native Multi-Page Array Channels (Completely avoids character bleed!)
    my_text_array[0] = "* Noelle: Oh! Hey Kris! Hey Susie!\n* Are you guys heading out to...";
    my_text_array[1] = "* Noelle: ... wait.\n* Wh... why are you looking at me like that...?";
    my_text_array[2] = "* Susie: Noelle. Look at my eyes.\n* Remember the snow.";
    my_text_array[3] = "* Susie: Remember the freezing dark.\n* Remember what happened to Cyber World.";
    my_text_array[4] = "* Kris: (You grab Noelle's hand.)\n* (Your soul flashes a cold, piercing crimson.)";
    my_text_array[5] = "* Noelle: (...!)";
    my_text_array[6] = "* Noelle: (Her eyes widen in absolute, paralyzing terror.)";
    my_text_array[7] = "* Noelle: It... it wasn't a dream...\n* The loop... it's happening again, isn't it?";
    my_text_array[8] = "* Susie: Yeah. And we're fixing it this time.\n* Come with us. We're finding Sans.";

}