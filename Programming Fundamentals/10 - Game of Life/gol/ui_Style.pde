class Style {
	public color fillColor;
	public color borderColor;
	public float borderSize;
	public color textColor;

	public Style() {
		this(color(0, 0, 0, 0), color(0, 0, 0, 0), 0);
	}

	public Style(color fillColor) {
		this(fillColor, color(0, 0, 0, 0), 0);
	}

	public Style(color fillColor, color borderColor, float borderSize) {
		this.fillColor = fillColor;
		this.borderColor = borderColor;
		this.borderSize = borderSize;
	}

	public void apply() {
		if (alpha(fillColor) != 0) {
			fill(fillColor);
		}
		else {
			noFill();
		}

		if (borderSize > 0) {
			stroke(borderColor);
			strokeWeight(borderSize);
		}
		else {
			noStroke();
		}
	}
}

class ButtonStyle extends Style {
	public color hoverColor;
	public color pressColor;

	public ButtonStyle() {
		super(color(0, 0, 0, 0), color(0, 0, 0, 0), 0);
	}

	public ButtonStyle(color fillColor) {
		super(fillColor);
	}

	public ButtonStyle(color fillColor, color borderColor, float borderSize) {
		super(fillColor, borderColor, borderSize);
	}
}