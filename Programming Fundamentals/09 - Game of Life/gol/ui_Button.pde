interface Action {
	void invoke();
}

class Button extends UIElement {
	public float textSize;
	public ButtonStyle style;
	public String text;
	public Action action;

	public boolean pressed;
	public boolean hovering;

	public Button(PVector position, PVector size) {
		super(position, size);
	}

	public Button(PVector position, PVector size, ButtonStyle style) {
		super(position, size, style);
		this.style = style;
	}

	public Button(PVector position, PVector size, ButtonStyle style, String text, float textSize, Action action) {
		super(position, size, style);
		this.style = style;
		this.text = text;
		this.textSize = textSize;
		this.action = action;
	}


	public void press() {
		if (pressed) return;
		if (action != null)
			action.invoke();
	}

	@Override
	public void draw() {
		style.apply();
		if (pressed) {
			fill(style.pressColor);
		}
		else if (hovering) {
			if (style.hoverColor != 0)
				fill(style.hoverColor);
		}

		rect(position.x, position.y, size.x, size.y);

		if (text != null) {
			fill(style.textColor);
			textAlign(CENTER, CENTER);
			if (textSize != 0)
				textSize(textSize);

			text(text, position.x + size.x / 2, position.y + size.y / 2);
		}
	}

	@Override
	void onPressDown(float x, float y) {
		press();
		pressed = true;
	}

	@Override
	void onPressUp(float x, float y) {
		pressed = false;
	}

	@Override
	void onMouseMoved(float x, float y) {
		hovering = containsPoint(x, y);
	}
}