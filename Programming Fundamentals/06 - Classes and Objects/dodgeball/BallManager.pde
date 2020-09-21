class BallManager {
	private ArrayList<Ball> balls = new ArrayList<Ball>();

	public void update() {
		for (int i = 0; i < balls.size(); i++) {
			Ball ball = balls.get(i);
			ball.update();

			if (ball.collidesWith(player)) {
				gameOver = true;
			}

			// Ball, ball collision.
			for (int j = 0; j < balls.size(); j++) {
				if (j == i) continue; // no self collision

				Ball ball2 = balls.get(j);

				if (ball.collidesWith(ball2)) {
					PVector direction = PVector.sub(ball.position, ball2.position).normalize();

					ball.velocity = PVector.mult(direction, ball.velocity.mag());
					ball2.velocity = PVector.mult(direction, -ball2.velocity.mag());
				}
			}
		}
	}

	public void draw() {
		for (int i = 0; i < balls.size(); i++)
			balls.get(i).draw();
	}

	public void spawnBall() {
		float x, y;
		do {
			x = random(BALL_RADIUS, width - BALL_RADIUS - 1);
			y = random(BALL_RADIUS, width - BALL_RADIUS - 1);
		} while (distSq(x, y, player.position.x, player.position.y) < sq(200));

		Ball ball = new Ball(x, y, BALL_RADIUS, BALL_COLOR);
		ball.randomizeVelocity(0.4f * 40, 5.0f * 40);
		balls.add(ball);
	}

	public void reset() {
		balls.clear();
	}
}