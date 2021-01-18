PShader cloudyShader;

void setup() {
	size(1200, 800, P2D);
	smooth(4);

	cloudyShader = loadShader("cloudy.glsl");
	cloudyShader.set("resolution", width, height);
}

void draw() {
	background(30);
	stroke(255);

	cloudyShader.set("time", millis() * 0.001f);
	filter(cloudyShader);

	float r = min(width, height) * 0.15f;
	float xStep = width / 3;
	float yStep = height / 2;

	int i = 0;
	for (float x = 0; x < 3; x++)
	for (float y = 0; y < 2; y++) {
		drawCoolThing(i, xStep / 2 + xStep * x, yStep / 2 + yStep * y, r);
		i++;
	}
}

void drawCoolThing(int id, float x, float y, float radius) {
	float time = millis() / 4000f;
	switch (id) {
		case 0: drawFancyCircle(x, y, radius, 110, 24, 37, time); break; // Swirl
		case 1: drawFancyCircle(x, y, radius, 82, 8, 9, time); break;    // Octagons
		case 2: drawFancyCircle(x, y, radius, 64, 32, 32, time); break;  // Dual spikes
		case 3: drawFancyCircle(x, y, radius, 80, 40, 30, time); break;  // Snowflake
		case 4: drawFancyCircle(x, y, radius, 80, 8, 30, time); break;   // "Rings"
	}
}

void drawFancyCircle(float xPos, float yPos, float radius, float numPoints, int skip, float distFreq, float offset) {
	float step = TWO_PI / numPoints;
	for (int i = 0; i < numPoints; i++) {
		float c = (sin(i / numPoints * TWO_PI + offset) + 1) * 0.5f;
		stroke(lerpColor(#f42069, #b4d455, c));

		float a1 = step * i;
		float a2 = step * ((i + skip) % numPoints);

		float r1 = radius + sin(a1 * distFreq + millis() / 1000f) * (radius / 2f);
		float r2 = radius + sin(a2 * distFreq + millis() / 1000f) * (radius / 2f);

		float p1x = xPos + cos(a1 + offset) * r1;
		float p1y = yPos + sin(a1 + offset) * r1;
		float p2x = xPos + cos(a2 + offset) * r2;
		float p2y = yPos + sin(a2 + offset) * r2;

		line(p1x, p1y, p2x, p2y);
	}
}
