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
	drawGrid();

	oldTime = time;
}

boolean randomChance(float probability) {
	return random(1) < probability;
}

void drawGrid() {
	stroke(127);

	float cellSize = width / grid.width;
	for (int y = 0; y < grid.width; y++)
	for (int x = 0; x < grid.height; x++) {
		if (grid.get(x, y))
			fill(0);
		else
			fill(255);

		rect(x * cellSize, y * cellSize, cellSize, cellSize);
	}
}

void randomizeGrid(float probability) {
	for (int y = 0; y < grid.width; y++)
	for (int x = 0; x < grid.height; x++) {
		if (randomChance(probability)) {
			grid.set(x, y, true);
		}
	}
}