// ROOM CHANGE RECYCLER: Safely purges unused asset memory only during clean black loading transitions!
gc_collect();

// ========================================================
// AUTOMATED PARTY RECOVERY ENGINE (SAVE FILE LOAD FIX)
// ========================================================

// 1. Check if the player is actively inside a real overworld gameplay room
// (Add any other overworld rooms where the party walks around here, like rm_street_north!)
var _is_gameplay_room = (room != rm_main_menu && room != Room1);

if (_is_gameplay_room) {
    // 2. TIMELINE CHECK: Only spawn her if her memories are already woke up (Phase 3)!
    if (variable_global_exists("truce_phase") && global.truce_phase >= 3) {
        
        // 3. ABSENCE CHECK: If her persistent object instance is currently missing from RAM
        if (!instance_exists(obj_noelle_follower)) {
            
            // Look up where Kris is currently standing in the room grid layers
            if (instance_exists(obj_kris_hollow)) {
                var _kx = obj_kris_hollow.x;
                var _ky = obj_kris_hollow.y;
                var _kd = obj_kris_hollow.depth;
                
                // 4. SPAWN RECOVERY INSTANCE: Materialize her right at Kris's physical coordinates!
                var _recovered_noelle = instance_create_depth(_kx, _ky, _kd, obj_noelle_follower);
                
                // 5. SCALE ENFORCEMENT: Ensure her visual assets match her official 2x dimensions!
                if (instance_exists(_recovered_noelle)) {
                    _recovered_noelle.image_xscale = 2;
                    _recovered_noelle.image_yscale = 2;
                }
            }
        }
    }
}
