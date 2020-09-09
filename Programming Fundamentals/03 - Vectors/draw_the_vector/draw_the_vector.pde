Vec2 targetVector;
Vec2 currentVector;
Vec2 p1, p2;
boolean lineDone;
boolean showHelp = true;
boolean leftMouseDown;

float score; // 0..1
int attempts;

void setup() {
	size(800, 800);
	smooth();

	reset();
}

void draw() {
	background(30);

	if (leftMouseDown) {
		p2.set(mouseX, mouseY);
	}

	currentVector = Vec2.sub(p2, p1);

	if (leftMouseDown || lineDone) {
		drawVector(p1, p2);
	}

	drawInfoText();
}

void mousePressed() {
	if (mouseButton == LEFT) {
		p1.set(mouseX, mouseY);
		leftMouseDown = true;
		lineDone = false;
		showHelp = false;
	}
	else if (mouseButton == RIGHT) {
		reset();
	}
}

void mouseReleased() {
	if (mouseButton == LEFT) {
		p2.set(mouseX, mouseY);
		leftMouseDown = false;
		lineDone = true;
		attempts += 1;
		score = calculateDistanceScore(currentVector, targetVector);
	}
}


void reset() {
	p1 = new Vec2();
	p2 = new Vec2();
	targetVector = new Vec2(
		int(random(width * 0.1f, width * 0.2f)),
		int(random(height * 0.1f, width * 0.2f)));
	lineDone = false;
	attempts = 0;
	score = 0;
}

void drawVector(Vec2 start, Vec2 end) {
	strokeWeight(1);
	stroke(0, 255, 0);
	line(start.x, start.y, end.x, start.y);
	stroke(0, 255, 255);
	line(end.x, start.y, end.x, end.y);

	strokeWeight(4);
	stroke(255, 0, 0);
	line(start.x, start.y, end.x, end.y);
}

void drawInfoText() {
	textSize(14);
	textAlign(CENTER);

	if (showHelp)
		text("Try to draw a vector of the same length as the target vector.", width / 2, height / 2);

	if (lineDone)
		text("Right click for a new vector.", width / 2, height - 26);

	textAlign(LEFT);
	text("Target vector: " + vectorInfo(targetVector, lineDone), 10, 26);
	if (lineDone)
		text("Your vector: " + vectorInfo(currentVector, true), 10, 52);

	textAlign(RIGHT);
	text("Score: " + int(score * 100) + "%", width - 10, 26);
	text("Attempts: " + attempts, width - 10, 26*2);
}

String vectorInfo(Vec2 vector, boolean showLength) {
	if (showLength)
		return vector + " length = " + vector.length();
	return vector.toString();
}

// Returns a 0..1 value based on how close the length of 'vector' is to that of 'target'.
float calculateDistanceScore(Vec2 vector, Vec2 target) {
	float targetLength = target.length();
	float currentLength = vector.length();

	float distance = abs(currentLength - targetLength);
	return 1 - clamp(distance, 0, targetLength) / targetLength;
}

float clamp(float v, float min, float max) {
	if (v <= min) return min;
	if (v >= max) return max;
	return v;
}
