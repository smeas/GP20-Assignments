Grid grid;
UI ui;
float stepTimer;
int oldTime;

// State
boolean simulationPaused;
float simulationSpeed = 8;
boolean drawingCellState = true;

void setup() {
	size(800, 860);

	grid = new Grid(new PVector(0, 0), new PVector(width, width), 80, 80);
	randomizeGrid(0.1f);

	ui = new UI();
	buildUI();
}

void update(float deltaTime) {
	// Update simulation
	if (!simulationPaused) {
		stepTimer += deltaTime;
		if (stepTimer >= 1 / simulationSpeed) {
			stepTimer = 0;
			grid.step();
		}
	}

	// Update drawing
	if (leftMousePressed && grid.isScreenPointInGrid(mouseX, mouseY)) {
		IVec pos = grid.screenPointToGrid(mouseX, mouseY);
		grid.set(pos, drawingCellState);
	}

	ui.update(deltaTime);
}

void draw() {
	int time = millis();
	float deltaTime = (time - oldTime) / 1000f;

	update(deltaTime);
	grid.draw();

	ui.draw();

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