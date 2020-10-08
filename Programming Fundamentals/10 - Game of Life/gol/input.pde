boolean leftMousePressed;

void keyPressed() {
	if (key == 'p' || key == ' ') {
		setSimulationPaused(!simulationPaused);
	}
	else if (key == 's') {
		grid.step();
	}
	else if (keyCode == java.awt.event.KeyEvent.VK_F3) {
		showFramerate = !showFramerate;
	}
}

void keyReleased() {

}

void mousePressed() {
	if (mouseButton == LEFT) {
		leftMousePressed = true;
		if (grid.isScreenPointInGrid(mouseX, mouseY)) {
			IVec pos = grid.screenPointToGrid(mouseX, mouseY);
			drawingCellState = !grid.get(pos).alive;
		}
	}

	ui.mousePressed();
}

void mouseReleased() {
	if (mouseButton == LEFT) {
		leftMousePressed = false;
	}

	ui.mouseReleased();
}

void mouseMoved() {
	ui.mouseMoved();
}
