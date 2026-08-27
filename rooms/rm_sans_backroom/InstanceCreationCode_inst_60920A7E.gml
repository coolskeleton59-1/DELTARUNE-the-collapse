// ========================================================
// THE SANS LOUNGE BRIEFING (PUNCHY CHARACTER-SAFE DRAFT)
// ========================================================

if (global.truce_phase == 4) {
    
    face_array = [
        spr_sans_normal,       // Page 0: Casual smile
        spr_sans_darkeyes,     // Page 1: WHITE EYE PUPILS VANISH INSTANTLY
        spr_susie_shocked,     // Page 2: Susie snaps
        spr_sans_darkeyes,     // Page 3: Blank stare
        spr_noellestill,       // Page 4: Noelle shivers
        spr_sans_normal,       // Page 5: Winks it off
       spr_susiestandstill     // Page 6: Susie steps up
    ];

    // Locked safely inside your single, solid white 3px border frame layout!
    my_text_array[0] = "* sans: y'know, normally i don't let customers behind the counter.\n* bad for business. people might think i'm working.";
    my_text_array[1] = "* sans: but uh... you three look like you just watched the sky fall apart.\n* ... or maybe you're just tired of waking up in the library?";
    my_text_array[2] = "* Susie: Hey! What do you know about that?! Talk, bonehead!";
    my_text_array[3] = "* sans: whoa, easy there, big girl.";
    my_text_array[4] = "* Noelle: (He... he feels the resets too... the world is looping right under our feet...)";
    my_text_array[5] = "* sans: if you're looking for answers, don't ask me. i'm off the clock.\n* but the old cellar doors south of town... they've been making a weird clicking sound lately.";
    my_text_array[6] = "* Susie: The shelter doors down south...?! Got it.\n* Kris, Noelle, let's move. We're breaking into that cellar.";

} else {
    // Fallback dialogue once he has delivered the authentic briefing
    face_array = [spr_sans_normal];
    my_text = "* sans: stay safe out there, kids.\n* wouldn't want you to get lost on a nice day like today.";
}
