class CharacterManager {
	public ArrayList<Character> characters = new ArrayList<Character>();

	public void update(float dt) {
		for (Character character : characters)
			character.update(dt);

		// Character collision check.
		for (int i = 0; i < characters.size(); i++)
		for (int j = 0; j < characters.size(); j++) {
			if (i == j) continue;

			Character c1 = characters.get(i);
			Character c2 = characters.get(j);

			if (c1 instanceof Zombie && c2 instanceof Human) {
				if (c1.collidesWith(c2)) {
					// "Infect" the human.
					Zombie zombie = new Zombie();
					zombie.position.set(c2.position);
					zombie.velocity.set(c2.velocity);
					zombie.radius = c2.radius;
					characters.set(j, zombie);
				}
			}
		}
	}

	public void draw() {
		for (Character character : characters)
			character.draw();
	}

	public void add(Character character) {
		characters.add(character);
	}
}