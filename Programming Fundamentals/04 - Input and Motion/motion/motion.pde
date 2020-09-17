final float ACCELERATION = 120;
final float MAX_SPEED = 240;
final float DRAG = 25;
final float GRAVITY = 100;
final float BOUNCE_VELOCITY_FRACTION = 0.8f;
final float CHARACTER_SIZE = 52;

PImage characterImage, bgImage;

PVector position = new PVector(400, 400);
PVector velocity = new PVector();

boolean up, down, left, right;
boolean enableGravity;
float deltaTime;
int oldTime;

void setup() {
	size(800, 800);
	frameRate(60);

	characterImage = loadImage("ball_shuck2.png");
	bgImage = loadImage("bg.png");
}

void draw() {
	int time = millis();
	deltaTime = (time - oldTime) / 1000f;

	doMovement();

	background(30);
	image(bgImage, 0, 0);
	drawCharacter();

	oldTime = time;
}

void drawCharacter() {
	image(characterImage, position.x,         position.y, CHARACTER_SIZE, CHARACTER_SIZE);
	// Draw the character again so that it is visible on both sides of the screen when wrapping.
	image(characterImage, position.x - width, position.y, CHARACTER_SIZE, CHARACTER_SIZE);
}

void doMovement() {
	PVector input = new PVector();
	if (left)  input.x += -1;
	if (right) input.x +=  1;
	if (up)    input.y += -1;
	if (down)  input.y +=  1;
	input.normalize();

	// Movement.
	velocity.add(PVector.mult(input, ACCELERATION * deltaTime));
	position.add(PVector.mult(velocity, deltaTime));

	// Gravity and drag.
	if (enableGravity)
		velocity.add(0, GRAVITY * deltaTime);
	else // Hack to prevent drag from cancelling out gravity.
		velocity.y = moveTowards(velocity.y, 0, DRAG * deltaTime);
	velocity.x = moveTowards(velocity.x, 0, DRAG * deltaTime);

	velocity.limit(MAX_SPEED);

	// Screen wrapping and border collision/bouncing.
	position.x = mod(position.x, width);

	if (position.y < 0) {
		position.y = 0;
		velocity.y = -velocity.y * BOUNCE_VELOCITY_FRACTION;
	}
	else if (position.y + CHARACTER_SIZE >= height) {
		position.y = height - CHARACTER_SIZE - 1;
		velocity.y = -velocity.y * BOUNCE_VELOCITY_FRACTION;
	}
}
