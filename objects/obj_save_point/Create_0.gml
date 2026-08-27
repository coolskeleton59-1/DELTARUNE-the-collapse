event_inherited();

// Tell your text box engine what sentence to type when Kris reads this spark!
my_text = "* (The light of the timeline shines through the darkness.)\n* (File saved.)";

// Safety check: Explicitly deactivates face portraits for this object
face_array = -1; 

// Local trackers for the slot selection pop-up
is_selecting_slot = false;
local_slot_index = 0; // 0 = Slot 1, 1 = Slot 2, 2 = Slot 3, 3 = Cancel
