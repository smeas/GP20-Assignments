public class Player {
	public PVector position;
	private PVector velocity;
	private PImage sprite;

	public Player(float x, float y) {
		position = new PVector(x, y);
		velocity = new PVector();
		sprite = loadImage("ball_shuck2.png");
	}

	public void draw() {
		image(sprite, position.x,         position.y, CHARACTER_SIZE, CHARACTER_SIZE);
		// Draw the character again so that it is visible on both sides of the screen when wrapping.
		image(sprite, position.x - width, position.y, CHARACTER_SIZE, CHARACTER_SIZE);
	}

	public void doMovement() {
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
		if (enableGravity){
			velocity.add(0, GRAVITY * deltaTime);

			// Hack to prevent drag from cancelling out gravity.
			velocity.x = moveTowards(velocity.x, 0, DRAG * deltaTime);
		}
		else {
			if (velocity.x != 0 && velocity.y != 0) {
				float speed = velocity.mag();
				float slowdownFactor = moveTowards(speed, 0, DRAG * deltaTime) / speed;
				velocity.mult(slowdownFactor);
			}
		}

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

}