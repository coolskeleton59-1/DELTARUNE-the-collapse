// ========================================================
// SANS GROCERY INTERACTION (THE BACKROOM BRIEFING CORE)
// ========================================================

// 1. Core Portrait Array Handoff: Tracks face shifts across his 5 pages of dialogue!
face_array = [
    spr_sans_normal,       // Page 0: Smiling casual
    spr_sans_darkeyes,     // Page 1: WHITE EYE PUPILS VANISH INSTANTLY
    spr_susie_shocked,     // Page 2: Susie recoils in surprise
    spr_sans_darkeyes      // Page 4: Sans points them to the shelter door
];

// 2. Native Multi-Line Numeric Array Layout (Completely un-bugged with zero text bleeding!)
my_text_array[0] = "* sans: heyya, kris. welcome to the shop.\n* can i interest ya in some premium, triple-priced pickles?";
my_text_array[1] = "* sans: ...\n* ... so, you kids finally remember the freezing air, huh?";
my_text_array[2] = "* Susie: WHAT THE--?! Your eyes! How do you know about that?!"
my_text_array[3] = "* sans: come into the back room.\n* we need to talk about the structural roarings.";

// 3. EXECUTE TRANSITION ROUTINE ON CLOSE
// We hook into your global state framework so the exact frame this dialogue container closes,
// your overworld manager stops h.ogg and transitions the party straight to rm_sans_backroom!
if (global.truce_phase == 3) {
    global.truce_phase = 4; // Advance your timeline data to the backroom briefing phase!
}
