// 1. MASTER STORY FILTER: If we are still in the intro autopilot phase, delete her!
if (global.truce_phase == 0) {
    instance_destroy(); // Vaporizes her from the bedroom map instantly on game boot!
    exit; // Stops the rest of this script from running
}

// 2. TRUCE GAMEPLAY SETUP: This code ONLY runs if global.truce_phase is 1 or higher!
image_speed = 0; // Turn off automatic animation loops

