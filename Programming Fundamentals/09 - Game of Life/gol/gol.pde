static final float STEP_DELAY = 1/8f;

Grid grid = new Grid(80, 80);
float stepTimer;
int oldTime;

void setup() {
	size(800, 800);

	randomizeGrid(0.25f);
}

void update(float deltaTime) {
	stepTimer += deltaTime;
	if (stepTimer >= STEP_DELAY) {
		stepTimer -= STEP_DELAY;
		grid.step();
	}
}

void draw() {
	int time = millis();
	float deltaTime = (time - oldTime) / 1000f;

	update(deltaTime);
	grid.draw();

	oldTime = time;
}

void randomizeGrid(float probability) {
	for (int y = 0; y < grid.sizeY; y++)
	for (int x = 0; x < grid.sizeX; x++) {
		if (randomChance(probability)) {
			grid.set(x, y, true);
		}
	}
}