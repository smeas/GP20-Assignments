class Zombie extends Character {
	private static final float ARM_THICKNESS = 4;
	private static final float ARM_LENGTH_FACTOR = 1.6f;

	public Zombie() {
		super();
		velocity = randomDirection().mult(ZOMBIE_SPEED);
		_color = color(42, 168, 17);
	}

	@Override
	protected void drawCharacter() {
		// Draw arms.
		fill(32, 128, 13);
		rect(0, radius - ARM_THICKNESS, radius * ARM_LENGTH_FACTOR, ARM_THICKNESS); // right
		rect(0, -radius, radius * ARM_LENGTH_FACTOR, ARM_THICKNESS); // left

		fill(_color);
		super.drawCharacter();
	}
}