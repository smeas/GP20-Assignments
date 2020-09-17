void keyPressed() {
	if (key == 'g')
		enableGravity = !enableGravity;
	else
		onInput(true);
}

void keyReleased() { onInput(false); }

void onInput(boolean pressed) {
	if (keyCode == LEFT || key == 'a')
		left = pressed;
	else if (keyCode == RIGHT || key == 'd')
		right = pressed;
	else if (keyCode == UP || key == 'w')
		up = pressed;
	else if (keyCode == DOWN || key == 's')
		down = pressed;
}