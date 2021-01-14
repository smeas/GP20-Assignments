final int NUM_POINTS = 30;

enum TrigFunction { Sin, Cos, Tan, InvTan }

void setup() {
	size(800, 800);
}

void draw() {
	background(20);
	strokeWeight(6);

	float t = millis() / 1000f;

	strokeWeight(1);
	drawSinLines(400, 150, NUM_POINTS, 1, t);
	strokeWeight(6);


	noStroke();
	fill(255, 2, 210, 4);
	ellipse(400, 400, 300, 300);


	stroke(255, 0, 0);
	drawTrigCurve(TrigFunction.Sin, 400, 150, NUM_POINTS, 1, t);

	stroke(0, 255, 0);
	drawTrigCurve(TrigFunction.Cos, 400, 150, NUM_POINTS, 1, t + PI / 2);

	stroke(0, 0, 255);
	drawTrigCurve(TrigFunction.Tan, 400, 150, NUM_POINTS * 2, 1, t);


	stroke(120);
	drawSpiral(400, 400, 150, NUM_POINTS * 2, t * 0.7f, -t * 0.5f);
	//drawSpiral(400, 400, 150, NUM_POINTS, 1, -t * 0.5f + PI);

	stroke(160);
	drawCircle(400, 400, 150, NUM_POINTS, -t * 0.5f);
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
		case InvTan: return 1f / tan(x);
		default:  return 0;
	}
}

void drawSinLines(float yPos, float ySize, int numPoints, float frequency, float offset) {
	float spacing = (float)width / numPoints;
	for (float x = spacing / 2f; x < width; x += spacing) {
		float xRad = (x / width * TWO_PI + offset) * frequency;
		float s = sin(xRad);
		float y1 = yPos + s * ySize;
		float y2 = yPos + -s * ySize;

		gradLine(x, y1, x, y2, 20, color(255, 0, 0, 30), color(0, 255, 0, 30));
	}
}

void gradLine(float x1, float y1, float x2, float y2, int segments, color color1, color color2) {
	float dx = x2 - x1;
	float dy = y2 - y1;
	float tStep = 1f / segments;

	for (int seg = 0; seg < segments; seg++) {
		float t = (float)seg / segments;
		color col = lerpColor(color1, color2, t);
		stroke(col);

		float tNext = t + tStep;
		line(
			x1 + dx * t,
			y1 + dy * t,
			x1 + dx * tNext,
			y1 + dy * tNext
		);
	}
}

void drawCircle(float xPos, float yPos, float radius, int numPoints, float offset) {
	float step = TWO_PI / numPoints;
	for (float angle = 0; angle < TWO_PI; angle += step) {
		float x = cos(angle + offset) * radius;
		float y = sin(angle + offset) * radius;
		point(xPos + x, yPos + y);
	}
}

void drawSpiral(float xPos, float yPos, float radius, int numPoints, float frequency, float offset) {
	float step = TWO_PI / numPoints;
	for (float angle = 0; angle < TWO_PI; angle += step) {
		stroke(lerpColor(color(30), color(198, 0, 255), (angle / TWO_PI)));

		float x = cos(angle * frequency + offset) * radius * (1 - angle / TWO_PI);
		float y = sin(angle * frequency + offset) * radius * (1 - angle / TWO_PI);
		point(xPos + x, yPos + y);
	}
}
