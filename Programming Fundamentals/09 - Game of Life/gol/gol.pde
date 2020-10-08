Grid grid;
UI ui;
float stepTimer;
int oldTime;

// State
boolean simulationPaused;
float simulationSpeed = 8;
boolean drawingCellState = true;

void setup() {
	size(800, 800);

	grid = new Grid(80, 80);
	randomizeGrid(0.1f);

	ui = new UI();
	buildUI();
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

void buildUI() {
	ButtonStyle bs = new ButtonStyle();
	bs.fillColor = color(200);
	bs.hoverColor = color(180);
	bs.pressColor = color(127);
	bs.textColor = color(255, 0, 0);

	Panel toolbar = new Panel(new PVector(200, 280), new PVector(400, 400), new Style(color(230), color(255, 127, 127), 2));

	Button test = new Button(new PVector(100, 100), new PVector(200, 100), bs);
	test.textSize = 24;
	test.text = "Test!";
	test.action = new Action() {
		public void invoke() {
			println("Test");
			t++;
		}
	};

	toolbar.add(test);
	ui.root.add(toolbar);
}