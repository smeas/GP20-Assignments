PVector ZERO = new PVector(0, 0);
float ANGLE = 45;
int LINES = 32;

ParabolicCurve curve = new ParabolicCurve(
	new PVector(400, 0),
	new PVector(400, 0).rotate(radians(ANGLE)), LINES);

void setup() {
	size(800, 800);
}

void draw() {
	background(0xffffff);
	translate(400, 400);
	
	for (int i = 0; i < 360/ANGLE; i++) {
		rotate(radians(ANGLE));
		curve.draw();
	}
}

class ParabolicCurve {
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
				stroke(0, 0, 0);
			else
				stroke(128, 128, 128);

			PVector p1 = PVector.lerp(axis1, ZERO, 1f / numLines * i);
			PVector p2 = PVector.lerp(axis2, ZERO, 1 - 1f / numLines * (i + 1));

			line(p1.x, p1.y, p2.x, p2.y);
		}
	}
}
