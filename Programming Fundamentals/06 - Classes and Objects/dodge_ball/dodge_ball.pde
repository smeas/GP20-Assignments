final float ACCELERATION = 240;
final float MAX_SPEED = 240;
final float DRAG = 60;
final float GRAVITY = 100;
final float BOUNCE_VELOCITY_FRACTION = 0.8f;
final float CHARACTER_SIZE = 52;

final float BALL_RADIUS = 20;
final color BALL_COLOR = color(255, 50, 50);
final boolean PAUSE_ON_GAME_OVER = true;

boolean up, down, left, right;
boolean enableGravity;
float deltaTime;
int oldTime;

Player player;
ArrayList<Ball> balls = new ArrayList<Ball>();
PImage bgImage;
boolean gameOver = false;

void setup() {
	size(800, 800);

	bgImage = loadImage("bg.png");
	player = new Player((width - CHARACTER_SIZE) / 2f, (height - CHARACTER_SIZE) / 2f);

	createBalls();
}

void draw() {
	int time = millis();
	deltaTime = (time - oldTime) / 1000f;

	update();

	background(30);
	image(bgImage, 0, 0);

	for (int i = 0; i < balls.size(); i++)
		balls.get(i).draw();

	player.draw();

	if (gameOver) {
		fill(255);
		textSize(72);
		textAlign(CENTER);
		text("Game Over", width / 2, height / 2);
	}

	oldTime = time;
}

void update() {
	if (gameOver && PAUSE_ON_GAME_OVER) return;
	player.doMovement();

	// Update balls.
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

void createBalls() {
	for (int i = 0; i < 10; i++) {
		float x, y;
		do {
			x = random(BALL_RADIUS, width - BALL_RADIUS - 1);
			y = random(BALL_RADIUS, width - BALL_RADIUS - 1);
		} while (distSq(x, y, player.position.x, player.position.y) < sq(200));

		Ball ball = new Ball(x, y, BALL_RADIUS, BALL_COLOR);
		ball.randomizeVelocity(0.4f * 40, 5.0f * 40);
		balls.add(ball);
	}
}
