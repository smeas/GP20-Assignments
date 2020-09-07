final PVector ZERO = new PVector(0, 0);
final float ANGLE = 45;
final int LINES = 32;

ParabolicCurve cornerCurve = new ParabolicCurve(
	new PVector(400, 0),
	new PVector(0, 400), LINES);

ParabolicCurve middleCurve = new ParabolicCurve(
	new PVector(400, 0),
	new PVector(400, 0).rotate(radians(ANGLE)), LINES);

void setup() {
	size(800, 800);
	frameRate(60);
	smooth();
}

void draw() {
	background(159,21,231);

	drawCorners();

	translate(400, 400);
	rotate(millis() / 1800f);
	scale(1 - pingPong(millis() / 10000f, 0.3));

	for (int i = 0; i < 360/ANGLE; i++) {
		rotate(radians(ANGLE));
		middleCurve.draw();
	}
}

void drawCorners() {
	drawAt(cornerCurve, 0,     0,      0);
	drawAt(cornerCurve, width, 0,      PI/2);
	drawAt(cornerCurve, width, height, 2*PI/2);
	drawAt(cornerCurve, 0,     height, 3*PI/2);
}

// Ping pongs a number between 0 and 'length'.
float pingPong(float v, float length) {
	v = v % (length * 2);
	return length - abs(v - length);
}

void drawAt(Drawable drawable, float x, float y, float rot) {
	pushMatrix();
	translate(x, y);
	rotate(rot);
	drawable.draw();
	popMatrix();
}

interface Drawable {
	void draw();
}

class ParabolicCurve implements Drawable {
	private PVector axis1, axis2;
	private int numLines;

	public ParabolicCurve(PVector axis1, PVector axis2, int numLines) {
		this.axis1 = axis1;
		this.axis2 = axis2;
		this.numLines = numLines;
	}

	public void draw() {
		// Draw axes
		line(0, 0, axis1.x, axis1.y);
		line(0, 0, axis2.x, axis2.y);

		// Draw lines
		for (int i = 0; i < numLines; i++) {
			if (i % 3 == 0)
				stroke(234, 2, 171);
			else
				stroke(255, 102, 199);

			PVector p1 = PVector.lerp(axis1, ZERO, 1f / numLines * i);
			PVector p2 = PVector.lerp(axis2, ZERO, 1 - 1f / numLines * (i + 1));

			line(p1.x, p1.y, p2.x, p2.y);
		}
	}
}
