final float ACCELERATION = 120;
final float MAX_SPEED = 240;
final float DRAG = 25;
final float GRAVITY = 100;
final float BOUNCE_VELOCITY_FACTOR = 0.8f;
final float CHARACTER_SIZE = 52;

PImage characterImage, bgImage;

PVector position = new PVector(400, 400);
PVector velocity = new PVector();

boolean up, down, left, right;
boolean enableGravity;
float deltaTime;
float oldTime;

void setup() {
	size(800, 800);
	frameRate(60);

	characterImage = loadImage("ball_shuck2.png");
	bgImage = loadImage("bg.png");
}

void draw() {
	background(30);

	float time = millis();
	deltaTime = (time - oldTime) / 1000f;

	doMovement();
	image(bgImage, 0, 0);
	drawCharacter();

	oldTime = time;
}

void keyPressed() {
	if (key == 'g')
		enableGravity = !enableGravity;
	else
		onInput(true);
}

void keyReleased() { onInput(false); }

void onInput(boolean pressed) {
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

// Modulus
float mod(float x, float n) { return (x % n + n) % n; }

void drawCharacter() {
	image(characterImage, position.x, position.y, CHARACTER_SIZE, CHARACTER_SIZE);
	image(characterImage, position.x + width, position.y, CHARACTER_SIZE, CHARACTER_SIZE);
	image(characterImage, position.x - width, position.y, CHARACTER_SIZE, CHARACTER_SIZE);
}

void doMovement() {
	PVector input = new PVector();
	if (left)  input.x += -1;
	if (right) input.x +=  1;
	if (up)    input.y += -1;
	if (down)  input.y +=  1;

	// Movement
	position.add(PVector.mult(velocity, deltaTime));
	velocity.add(PVector.mult(input, ACCELERATION * deltaTime));

	// Gravity and drag
	if (enableGravity)
		velocity.add(0, GRAVITY * deltaTime);
	else
		velocity.y = moveTowards(velocity.y, 0, DRAG * deltaTime);
	velocity.x = moveTowards(velocity.x, 0, DRAG * deltaTime);

	velocity.x = clamp(velocity.x, -MAX_SPEED, MAX_SPEED);
	velocity.y = clamp(velocity.y, -MAX_SPEED, MAX_SPEED);

	// Screen wrapping and border collision
	position.x = mod(position.x, width);

	if (position.y < 0) {
		position.y = 0;
		velocity.y = -velocity.y * BOUNCE_VELOCITY_FACTOR;
	}
	else if (position.y + CHARACTER_SIZE >= height) {
		position.y = height - CHARACTER_SIZE - 1;
		velocity.y = -velocity.y * BOUNCE_VELOCITY_FACTOR;
	}

	//println(velocity);
}
