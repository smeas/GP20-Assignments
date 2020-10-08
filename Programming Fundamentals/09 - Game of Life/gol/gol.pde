Grid grid;
float stepTimer;
int oldTime;

// State
boolean simulationPaused;
float simulationSpeed = 8;
boolean drawingCellState = true;

void setup() {
	size(800, 800);

	grid = new Grid(80, 80);
	grid.size.set(800, 600);
	randomizeGrid(0.1f);
}

void update(float deltaTime) {
	// Update simulation
	if (!simulationPaused) {
		stepTimer += deltaTime;
		if (stepTimer >= 1 / simulationSpeed) {
			stepTimer -= 1 / simulationSpeed;
			grid.step();
		}
	}

	// Update drawing
	if (leftMousePressed && grid.isScreenPointInGrid(mouseX, mouseY)) {
		IVec pos = grid.screenPointToGrid(mouseX, mouseY);
		grid.set(pos, drawingCellState);
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
	for (int y = 0; y < grid.gridSizeY; y++)
	for (int x = 0; x < grid.gridSizeX; x++) {
		if (randomChance(probability)) {
			grid.set(x, y, true);
		}
	}
}