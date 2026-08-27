// Follower animation tracker
face_direction = 3; // Default to facing down (0=Right, 1=Up, 2=Left, 3=Down)
image_speed = 0;

// Assign your true Susie directional walk animation sheets here!
sprite_walk[0] = spr_noelle_walk_right; 
sprite_walk[1] = spr_noelle_walk_up;    
sprite_walk[2] = spr_noelle_walk_left;  
sprite_walk[3] = spr_noelle_walk_down;  

// PERMANENT LAYER SCALE ENFORCEMENT
// Anchors her asset dimensions to 2x size across all automated state code loops
image_xscale = 2;
image_yscale = 2;
