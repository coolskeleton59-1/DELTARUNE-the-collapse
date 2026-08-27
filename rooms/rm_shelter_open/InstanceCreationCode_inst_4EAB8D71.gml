// ========================================================
// THE OLD SHELTER DOORS (SIMPLIFIED AXE-SMASH PORTAL)
// ========================================================

if (global.truce_phase == 4) {
    // 1. Core Portrait Array Handoff
    face_array = [
        -1,                    // Page 0: Narration
        spr_susie_normal,  // Page 1: Susie summons her axe
        spr_noelle_walk_down,       // Page 2: Noelle backs away
        spr_susie_smile,  // Page 3: Susie strikes
        -1                     // Page 4: Darkness takes over
    ];

    // 2. Native Multi-Line Numeric Array Layout (Perfect 640p text scaling!)
    my_text_array = "* (The massive steel shelter doors sit locked and rusted in the center of the clearing.)\n* (A low, terrifying hum vibrates through the cold ground.)";
    my_text_array = "* Susie: Step back, both of you.\n* I'm not wasting time looking for a key.";
    my_text_array = "* Noelle: S-Susie?! What are you doing?! That's solid steel...!";
    my_text_array = "* Susie: (Susie manifests her overworld axe, her eyes flaring with crimson Determination.)\n* Susie: Watch me.";
    my_text_array = "* (CRASH!!!)\n* (The axe splits the steel plates completely open, unleashing a roaring, glitched pitch-black vortex!)";

} else {
    // Fallback if they click it before completing the storyline steps
    face_array = [-1];
    my_text = "* (The massive steel shelter doors are rusted shut.)";
}
