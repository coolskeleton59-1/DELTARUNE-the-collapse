// ========================================================
// RECLAIM RAM & GPU MEMORY HEADROOM (RUNS EVERY 5 SECONDS)
// ========================================================

// 1. Forcefully call GameMaker's native engine garbage collection routine
gc_collect();

// 2. Flush empty audio assets that are trapped in the cache layers
audio_debug(false); 

// 3. Reset the optimization timer loop cycle
alarm[0] = 300;
