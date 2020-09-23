class Human extends Character {
	public Human() {
		super();
		velocity = randomDirection().mult(HUMAN_SPEED);
		_color = color(255, 219, 143);
	}
}
