final int NUM_POINTS = 30;

enum TrigFunction { Sin, Cos, Tan }

void setup() {
	size(800, 800);
}

void draw() {
	background(30);

	strokeWeight(6);

	stroke(120);
	drawSpiral(400, 400, 150, NUM_POINTS);

	stroke(255);
	drawCircle(400, 400, 150, NUM_POINTS);

	stroke(255, 0, 0);
	drawTrigCurve(TrigFunction.Sin, 400, 150, NUM_POINTS, 1, millis() / 1000f);

	stroke(0, 255, 0);
	drawTrigCurve(TrigFunction.Cos, 400, 150, NUM_POINTS, 1, millis() / 1000f);

	stroke(0, 0, 255);
	drawTrigCurve(TrigFunction.Tan, 400, 150, NUM_POINTS * 2, 1, millis() / 1000f);
}

void drawTrigCurve(TrigFunction func, float yPos, float ySize, int numPoints, float frequency, float offset) {
	float spacing = (float)width / numPoints;
	for (float x = spacing / 2f; x < width; x += spacing) {
		float xRad = (x / width * TWO_PI + offset) * frequency;
		float y = yPos + trigFunction(func, xRad) * ySize;
		point(x, y);
	}
}

float trigFunction(TrigFunction func, float x) {
	switch (func) {
		case Sin: return sin(x);
		case Cos: return cos(x);
		case Tan: return tan(x);
		default:  return 0;
	}
}

void drawCircle(float xPos, float yPos, float radius, int numPoints) {
	float step = TWO_PI / numPoints;
	for (float angle = 0; angle < TWO_PI; angle += step) {
		float x = cos(angle) * radius;
		float y = sin(angle) * radius;
		point(xPos + x, yPos + y);
	}
}

void drawSpiral(float xPos, float yPos, float radius, int numPoints) {
	float step = TWO_PI / numPoints;
	for (float angle = 0; angle < TWO_PI; angle += step) {
		float x = cos(angle) * radius * (1 - angle / TWO_PI);
		float y = sin(angle) * radius * (1 - angle / TWO_PI);
		point(xPos + x, yPos + y);
	}
}
