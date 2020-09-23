class CharacterManager {
	public ArrayList<Character> characters = new ArrayList<Character>();

	public void update(float dt) {
		for (Character character : characters)
			character.update(dt);

		// Character collision check.
		for (int i = 0; i < characters.size(); i++)
		for (int j = 0; j < characters.size(); j++) {
			if (i == j) continue;

			Character char1 = characters.get(i);
			Character char2 = characters.get(j);

			if (char1.collidesWith(char2)) {
				separateCollidingCharacters(char1, char2);

				if (char1 instanceof Zombie && char2 instanceof Human) {
					// "Infect" the human.
					Zombie zombie = new Zombie();
					zombie.position.set(char2.position);
					zombie.velocity.set(char2.velocity);
					zombie.radius = char2.radius;
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

	private void separateCollidingCharacters(Character c1, Character c2) {
		float distance = c1.position.dist(c2.position);
		float intersectionAmount = c1.radius + c2.radius - distance;

		PVector pushDistance = PVector.sub(c2.position, c1.position).normalize().mult(intersectionAmount / 2);
		c1.position.sub(pushDistance);
		c2.position.add(pushDistance);
	}
}