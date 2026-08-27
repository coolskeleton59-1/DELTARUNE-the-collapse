// ========================================================
// PARTY DEDUPLICATION ENGINE (ANTI-CLONE GUARD)
// ========================================================

// If multiple copies of Noelle exist in the new room layer, destroy the newborn copy!
if (instance_number(obj_noelle_follower) >0) {
    // Check if THIS specific instance is the newly spawned room duplicate
    if (id != instance_find(obj_noelle_follower, 0)) {
        instance_destroy();
        exit;
    }
}
