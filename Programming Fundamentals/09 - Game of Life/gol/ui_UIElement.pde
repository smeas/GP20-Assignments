class UIElement {
	public PVector position;
	public PVector size;
	public Style style;

	public UIElement() {
		this(new PVector(), new PVector());
	}

	public UIElement(PVector position, PVector size) {
		this(position, size, new Style());
	}

	public UIElement(PVector position, PVector size, Style style) {
		this.position = position;
		this.size = size;
		this.style = style;
	}


	public boolean containsPoint(PVector point) {
		return containsPoint(point.x, point.y);
	}

	public boolean containsPoint(float x, float y) {
		return pointInRect(x, y, position.x, position.y, size.x, size.y);
	}

	public void update(float deltaTime) {}
	public void draw() {}

	void onPressDown(float x, float y) {}
	void onPressUp(float x, float y) {}
	void onMouseMoved(float x, float y) {}
}