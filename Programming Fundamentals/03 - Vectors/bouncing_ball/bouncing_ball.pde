
float ballSpeed = 0.01f;

PVector ballSize = new PVector(100, 100);
PVector ballPos = new PVector(400, 400);
PVector ballVel = new PVector(0, 0);

void setup() {
	size(800, 800);
}

void draw() {
	updateBall();

	background(30);
	noStroke();

	ellipse(ballPos.x, ballPos.y, ballSize.x, ballSize.y);

	if (mousePressed) {
		stroke(255, 0, 0);
		strokeWeight(4);
		line(ballPos.x, ballPos.y, mouseX, mouseY);
	}
}

void updateBall() {
	ballPos.add(ballVel);

	// Screen collision

	if (ballPos.x - ballSize.x / 2 < 0) {
		ballPos.x = ballSize.x / 2;
		ballVel.x = -ballVel.x;
	}

	if (ballPos.y - ballSize.y / 2 < 0) {
		ballPos.y = ballSize.y / 2;
		ballVel.y = -ballVel.y;
	}

	if (ballPos.x + ballSize.x / 2 > width) {
		ballPos.x = width - ballSize.x / 2;
		ballVel.x = -ballVel.x;
	}

	if (ballPos.y + ballSize.y / 2 > height) {
		ballPos.y = height - ballSize.y / 2;
		ballVel.y = -ballVel.y;
	}
}

void mouseReleased() {
	PVector circleToMouse = new PVector(mouseX, mouseY).sub(ballPos);
	ballVel.set(circleToMouse).mult(ballSpeed);
}