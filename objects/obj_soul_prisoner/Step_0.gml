// 1. Get arrow key presses
var _move_x = keyboard_check(vk_right) - keyboard_check(vk_left);
var _move_y = keyboard_check(vk_down) - keyboard_check(vk_up);

// 2. Apply movement
x += _move_x * move_speed;
y += _move_y * move_speed;

// 3. Clamp coordinates to the invisible walls
x = clamp(x, cage_left, cage_right);
y = clamp(y, cage_top, cage_bottom);

if (global.truce_phase >1) {
	
	visible = false;
	
}
	