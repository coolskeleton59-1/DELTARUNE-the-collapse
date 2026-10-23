// How fast the heart moves per frame
move_speed = 3;

// DYNAMIC CAGE: This tells GameMaker to look at where you dropped the heart 
// on the grid, and build the invisible walls exactly 40 pixels around it.
cage_left   = x - 11; 
cage_right  = x + 11;
cage_top    = y - 9;
cage_bottom = y + 10;
