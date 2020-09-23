class Character {
	public PVector position;
	public PVector velocity = new PVector();
	public float radius = CHARACTER_RADIUS;
	public color _color;

	public Character() {
		position = randomVector(0, width, 0, height);
	}

	public void update(float dt) {
		position.x += velocity.x * dt;
		position.y += velocity.y * dt;

		screenWrap();
	}

	public void draw() {
		float angle = atan2(velocity.y, velocity.x);

		noStroke();
		fill(_color);

		pushMatrix();
			translate(position.x, position.y);
			rotate(angle);
			drawCharacter();
		popMatrix();

		// Draw additional instances of the character when wrapping.

		final float safeZone = 20;

		if (position.x - radius - safeZone < 0 || position.x + radius + safeZone >= width) {
			pushMatrix();
				translate(position.x - width, position.y);
				rotate(angle);
				drawCharacter();
			popMatrix();
		}

		if (position.y - radius - safeZone < 0 || position.y + radius + safeZone >= height) {
			pushMatrix();
				translate(position.x, position.y - height);
				rotate(angle);
				drawCharacter();
			popMatrix();
		}
	}

	protected void drawCharacter() {
		ellipse(0, 0, radius*2, radius*2);
	}

	public boolean collidesWith(Character other) {
		return circleCollision(position.x, position.y, radius,
		                       other.position.x, other.position.y, other.radius);
	}

	// private void screenCollision() {
	// 	if (position.x - radius < 0 || position.x + radius >= width) {
	// 		position.x = clamp(position.x, radius, width - radius - 1);
	// 		velocity.x = -velocity.x;
	// 	}
	//
	// 	if (position.y - radius < 0 || position.y + radius >= height) {
	// 		position.y = clamp(position.y, radius, height - radius - 1);
	// 		velocity.y = -velocity.y;
	// 	}
	// }

	private void screenWrap() {
		position.x = mod(position.x - radius, width) + radius;
		position.y = mod(position.y - radius, width) + radius;
	}
}
