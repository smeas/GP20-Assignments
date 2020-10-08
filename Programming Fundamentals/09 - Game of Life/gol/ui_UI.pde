class UI {
	public Panel root;

	private boolean leftMousePressed;

	public UI() {
		root = new Panel(new PVector(), new PVector(width, height));
	}

	public void update(float deltaTime) {
		root.update(deltaTime);
	}

	public void draw() {
		root.draw();
	}

	public void mousePressed() {
		if (mouseButton == LEFT) {
			leftMousePressed = true;
			if (root.containsPoint(mouseX, mouseY))
				root.onPressDown(mouseX, mouseY);
		}
	}

	public void mouseReleased() {
		if (mouseButton == LEFT) {
			leftMousePressed = false;
			root.onPressUp(mouseX, mouseY);
		}
	}

	public void mouseMoved() {
		root.onMouseMoved(mouseX, mouseY);
	}
}