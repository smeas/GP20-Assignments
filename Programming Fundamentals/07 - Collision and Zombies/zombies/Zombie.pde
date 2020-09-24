class Zombie extends Character {
	private static final float ARM_THICKNESS = 4;
	private static final float ARM_LENGTH_FACTOR = 1.6f;
	private static final float TURNING_SPEED = PI/2; // 90°/s

	boolean hasTarget = false;
	private PVector targetDirection = new PVector();

	public Zombie() {
		super();
		velocity = randomDirection().mult(ZOMBIE_SPEED);
		_color = color(42, 168, 17);
	}

	@Override
	public void update(float dt) {
		super.update(dt);
		followClosestHuman(dt);
	}

	@Override
	protected void drawCharacter() {
		// Draw the arms.
		fill(32, 128, 13);
		rect(0, radius - ARM_THICKNESS, radius * ARM_LENGTH_FACTOR, ARM_THICKNESS); // right
		rect(0, -radius, radius * ARM_LENGTH_FACTOR, ARM_THICKNESS); // left

		// Draw the body.
		fill(_color);
		super.drawCharacter();

		// Draw eyes.
		fill(255);
		float eyeScale = 4 * (radius / 10);
		ellipse(radius - 5, eyeScale, eyeScale, eyeScale);
		ellipse(radius - 5, -eyeScale, eyeScale, eyeScale);
	}

	private Human findClosestHuman() {
		float minDistance = Float.POSITIVE_INFINITY;
		Human closestHuman = null;

		for (Character character : characterManager.characters) {
			if (!(character instanceof Human)) continue;

			float distance = distSq(position, character.position);
			if (distance < minDistance) {
				minDistance = distance;
				closestHuman = (Human)character;
			}
		}

		return closestHuman;
	}

	private void followClosestHuman(float dt) {
		Human human = findClosestHuman();
		if (human != null) {
			targetDirection = PVector.sub(human.position, position).normalize();
			hasTarget = true;
		}
		else {
			hasTarget = false;
		}

		if (hasTarget) {
			// Rotate towards the target.
			float currentAngle = atan2(velocity.y, velocity.x);
			float targetAngle = currentAngle + signedAngleBetween(velocity, targetDirection);
			velocity.rotate(moveTowards(currentAngle, targetAngle, TURNING_SPEED * dt) - currentAngle);
		}
	}
}