ButtonStyle buttonStyle;
Text speedText;
Button pauseButton;

// 60

void buildUI() {
	buttonStyle = new ButtonStyle();
	buttonStyle.fillColor = color(200);
	buttonStyle.hoverColor = color(180);
	buttonStyle.pressColor = color(127);
	buttonStyle.textColor = color(0);

	Style panelStyle = new Style();
	panelStyle.fillColor = color(230);
	panelStyle.borderColor = color(0);
	panelStyle.borderSize = 1;


	Panel toolbar = new Panel(new PVector(0, width), new PVector(width, height - width), panelStyle);

	pauseButton = new Button(new PVector(10, 10), new PVector(80, 40), buttonStyle, "Pause", 16, new Action() {
		public void invoke() {
			setSimulationPaused(!simulationPaused);
		}
	});
	setSimulationPaused(simulationPaused);
	toolbar.add(pauseButton);

	toolbar.add(new Button(new PVector(100, 10), new PVector(80, 40), buttonStyle, "Step", 16, new Action() {
		public void invoke() {
			grid.step();
		}
	}));

	toolbar.add(new Button(new PVector(width - 90, 10), new PVector(80, 40), buttonStyle, "Clear", 16, new Action() {
		public void invoke() {
			grid.clear();
		}
	}));

	Panel speedPanel = buildSpeedControls();
	speedPanel.position.set((width - speedPanel.size.x) / 2, 10);
	toolbar.add(speedPanel);

	ui.root.add(toolbar);
}


Panel buildSpeedControls() {
	Panel panel = new Panel(new PVector(), new PVector(140, 40));

	Button minus = new Button(new PVector(0, 0), new PVector(40, 40), buttonStyle, "-", 16, new Action() {
		public void invoke() {
			setSimulationSpeed(simulationSpeed / 2);
		}
	});

	Button plus = new Button(new PVector(100, 0), new PVector(40, 40), buttonStyle, "+", 16, new Action() {
		public void invoke() {
			setSimulationSpeed(simulationSpeed * 2);
		}
	});

	speedText = new Text(new PVector(40, 0), new PVector(60, 40), buttonStyle);
	setSimulationSpeed(simulationSpeed);

	panel.add(minus);
	panel.add(plus);
	panel.add(speedText);

	return panel;
}


void setSimulationSpeed(float speed) {
	simulationSpeed = speed;
	speedText.text = speed + "x";
}


void setSimulationPaused(boolean state) {
	simulationPaused = state;
	pauseButton.text = state ? "Resume" : "Pause";
}