void setup() {
	size(800, 800);
}

void draw() {
	background(0xffffff);
	drawPCurve(100, 100);
}

void drawPCurve(float x, float y) {
	float sw = 400;
	float sh = 400;
	int numLines = 32;

	float xStep = sw / numLines;
	float yStep = sh / numLines;

	// Draw axes
	line(x, y, x, y + sh);
	line(x, y + sh, x + sw, y + sh);

	// Draw lines
	for (int i = 0; i < numLines; i++) {
		float y1 = yStep * i;
		float x2 = xStep * i;

		line(x, y + y1, x + x2, y + sh);
	}
}