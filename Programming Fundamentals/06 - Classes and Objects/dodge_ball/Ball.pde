class Ball {
	public PVector position;
	public PVector velocity;
	public color col = color(255);
	public float radius;

	Ball(float x, float y, float radius, color col) {
		position = new PVector(x, y);
		velocity = new PVector();
		this.col = col;
		this.radius = radius;
	}

	public void update() {
		position.x += velocity.x * deltaTime;
		position.y += velocity.y * deltaTime;

		// Wall collision.
		if (position.x - radius < 0 || position.x + radius >= width) {
			position.x = clamp(position.x, radius, width - radius - 1);
			velocity.x = -velocity.x;
		}

		if (position.y - radius < 0 || position.y + radius >= height) {
			position.y = clamp(position.y, radius, height - radius - 1);
			velocity.y = -velocity.y;
		}
	}

	public void draw() {
		noStroke();
		fill(col);
		ellipse(position.x, position.y, radius * 2, radius * 2);
	}

	public void randomizeVelocity(float min, float max) {
		float a = random(2 * PI);
		velocity.x = cos(a);
		velocity.y = sin(a);
		velocity.mult(random(min, max));
	}

	public boolean collidesWith(Player player) {
		float r = CHARACTER_SIZE / 2;
		return circleCollision(position.x, position.y, radius,
			player.position.x + r, player.position.y + r, r);
	}

	public boolean collidesWith(Ball other) {
		return circleCollision(position.x, position.y, radius,
			other.position.x, other.position.y, other.radius);
	}
}