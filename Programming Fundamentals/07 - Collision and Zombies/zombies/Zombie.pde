class Zombie extends Character {
	public Zombie() {
		super();
		velocity = randomDirection().mult(ZOMBIE_SPEED);
		_color = color(42, 168, 17);
	}
}