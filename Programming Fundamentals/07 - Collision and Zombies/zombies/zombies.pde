final float HUMAN_SPEED = 50;
final float ZOMBIE_SPEED_MULTIPLIER = 0.7f;
final float ZOMBIE_SPEED = HUMAN_SPEED * ZOMBIE_SPEED_MULTIPLIER;
final float CHARACTER_RADIUS = 10;

CharacterManager characterManager = new CharacterManager();
Clock clock = new Clock();
float totalTime;
boolean gameOver = false;

void setup() {
	size(800, 800);

	// Add 99 zombies and 1 human.
	for (int i = 0; i < 99; i++)
		characterManager.add(new Human());
	characterManager.add(new Zombie());
}

void update() {
	float dt = clock.tick();

	characterManager.update(dt);

	if (!gameOver)
		totalTime += dt;
	gameOverCheck();
}

void draw() {
	update();

	background(30);
	characterManager.draw();

	if (gameOver) {
		fill(255);
		textAlign(CENTER, CENTER);
		textSize(42);
		text("The zombies have taken over!", width/2, height/2);
		textSize(24);
		text("All humans extinct after " + (int)totalTime + " seconds.", width/2, height/2 + 42);
	}
}

void gameOverCheck() {
	if (gameOver) return;

	// Check if all humans have become zombies.
	boolean allZombies = true;
	for (Character character : characterManager.characters) {
		if (character instanceof Human) {
			allZombies = false;
			break;
		}
	}

	// If so, the game is over.
	if (allZombies) {
		gameOver = true;
	}
}
