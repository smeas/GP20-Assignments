float SW = 400;
float SH = 400;

void setup() {
	size(800, 800);
}

void draw() {
	background(0xffffff);
	drawPCurve(100, 100);
}

void drawPCurve(float x, float y) {
	int numLines = 32;

	float xStep = SW / numLines;
	float yStep = SH / numLines;

	// Draw axes
	stroke(0, 0, 0);
	line(x, y, x, y + SH);
	line(x, y + SH, x + SW, y + SH);

	// Draw lines
	for (int i = 0; i < numLines; i++) {
		if (i % 3 == 0)
			stroke(0, 0, 0);
		else
			stroke(128, 128, 128);

		float y1 = yStep * i;
		float x2 = xStep * i;

		line(x, y + y1, x + x2, y + SH);
	}
}
