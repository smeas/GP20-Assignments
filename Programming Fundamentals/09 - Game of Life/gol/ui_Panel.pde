class Panel extends UIElement {
	public ArrayList<UIElement> elements = new ArrayList<UIElement>();

	public Panel() {
		super();
	}

	public Panel(PVector position, PVector size) {
		super(position, size);
	}

	public Panel(PVector position, PVector size, Style style) {
		super(position, size, style);
	}


	public void add(UIElement element) {
		elements.add(element);
	}

	@Override
	public void update(float deltaTime) {
		for (UIElement elem : elements) {
			elem.update(deltaTime);
		}
	}

	@Override
	public void draw() {
		pushMatrix();
			translate(position.x, position.y);

			style.apply();
			rect(0, 0, size.x, size.y);

			for (UIElement elem : elements) {
				elem.draw();
			}

		popMatrix();
	}

	@Override
	void onPressDown(float x, float y) {
		for (UIElement elem : elements) {
			if (elem.containsPoint(x - position.x, y - position.y))
				elem.onPressDown(x - position.x, y - position.y);
		}
	}

	@Override
	void onPressUp(float x, float y) {
		for (UIElement elem : elements) {
			elem.onPressUp(x - position.x, y - position.y);
		}
	}

	@Override
	void onMouseMoved(float x, float y)  {
		for (UIElement elem : elements) {
			elem.onMouseMoved(x - position.x, y - position.y);
		}
	}
}