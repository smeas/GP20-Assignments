class Human extends Character {
	private static final float SIZE_VARIATION = 2;
	private static final int COLOR_VARIATION = 30;

	public Human() {
		super();
		radius += random(-SIZE_VARIATION, SIZE_VARIATION);
		velocity = randomDirection().mult(HUMAN_SPEED);
		_color = color(255 + random(-COLOR_VARIATION, COLOR_VARIATION),
		               219 + random(-COLOR_VARIATION, COLOR_VARIATION),
		               143 + random(-COLOR_VARIATION, COLOR_VARIATION));
	}
}
