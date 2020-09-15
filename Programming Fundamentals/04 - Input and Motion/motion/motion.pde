final float ACCELERATION = 80;
final float MAX_SPEED = 240;
final float DRAG = 20;

PVector position = new PVector();
PVector velocity = new PVector();

boolean up, down, left, right;
float deltaTime;
float oldTime;

void setup() {
	size(800, 800);
	frameRate(60);
}

void draw() {
	background(30);

	float time = millis();
	deltaTime = (time - oldTime) / 1000f;

	PVector input = new PVector();
	if (left) input.x += -1;
	if (right) input.x += 1;
	if (up) input.y += -1;
	if (down) input.y += 1;

	position.add(PVector.mult(velocity, deltaTime));
	velocity.add(PVector.mult(input, ACCELERATION * deltaTime));

	velocity.x = moveTowards(velocity.x, 0, DRAG * deltaTime);
	velocity.y = moveTowards(velocity.y, 0, DRAG * deltaTime);

	velocity.x = clamp(velocity.x, -MAX_SPEED, MAX_SPEED);
	velocity.y = clamp(velocity.y, -MAX_SPEED, MAX_SPEED);

	ellipse(position.x, position.y, 80, 80);

	oldTime = time;
}

void keyPressed() { handleInput(true); }
void keyReleased() { handleInput(false); }
void handleInput(boolean pressed) {
	if (keyCode == LEFT || key == 'a')
		left = pressed;
	else if (keyCode == RIGHT || key == 'd')
		right = pressed;
	else if (keyCode == UP || key == 'w')
		up = pressed;
	else if (keyCode == DOWN || key == 's')
		down = pressed;
}

float sign(float v) { return v < 0 ? -1 : 1; }

float clamp(float value, float min, float max) {
	if (value <= min) return min;
	if (value >= max) return max;
	return value;
}

float moveTowards(float num, float target, float maxStep) {
	if (abs(target - num) <= maxStep)
		return target;

	return num + maxStep * sign(target - num);
}

