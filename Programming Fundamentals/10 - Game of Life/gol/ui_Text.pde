class Text extends UIElement {
	public String text;
	public float textSize;

	public Text() {
		super();
	}

	public Text(PVector position, PVector size) {
		super(position, size);
	}

	public Text(PVector position, PVector size, Style style) {
		super(position, size, style);
	}

	@Override
	public void draw() {
		if (text == null) return;

		fill(style.textColor);
		textAlign(CENTER, CENTER);
		if (textSize != 0)
			textSize(textSize);

		text(text, position.x + size.x / 2, position.y + size.y / 2);
	}
}