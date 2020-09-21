final float ACCELERATION = 240;
final float MAX_SPEED = 240;
final float DRAG = 60;
final float GRAVITY = 100;
final float BOUNCE_VELOCITY_FRACTION = 0.8f;
final float CHARACTER_SIZE = 52;

final float BALL_RADIUS = 15;
final color BALL_COLOR = color(255, 50, 50);
final float BALL_SPAWN_DELAY = 3;
final float MAX_BALLS = 100;

final boolean PAUSE_ON_GAME_OVER = true;

boolean up, down, left, right;
boolean enableGravity;
float ballSpawnTimer;
float timeSurvived;
float deltaTime;
int oldTime;

Player player;
BallManager ballManager;
PImage bgImage;
boolean gameOver = false;

void setup() {
	size(800, 800);

	bgImage = loadImage("bg.png");
	player = new Player((width - CHARACTER_SIZE) / 2f, (height - CHARACTER_SIZE) / 2f);
	ballManager = new BallManager();
}

void draw() {
	int time = millis();
	deltaTime = (time - oldTime) / 1000f;

	update();

	background(30);
	image(bgImage, 0, 0);

	ballManager.draw();
	player.draw();

	if (gameOver) {
		fill(255);
		textSize(72);
		textAlign(CENTER);
		text("Game Over", width / 2, height / 2);
		textSize(36);
		text("You survived for " + (int)timeSurvived + " seconds", width / 2, height / 2 + 50);
	}

	oldTime = time;
}

void update() {
	if (gameOver && PAUSE_ON_GAME_OVER) return;
	timeSurvived += deltaTime;
	player.doMovement();

	ballManager.update();
	ballSpawnTimer += deltaTime;
	if (ballSpawnTimer >= BALL_SPAWN_DELAY) {
		ballSpawnTimer -= BALL_SPAWN_DELAY;
		if (ballManager.ballCount() < MAX_BALLS)
			ballManager.spawnBall();
	}
}

void reset() {
	gameOver = false;
	timeSurvived = 0;
	ballManager.reset();
}
