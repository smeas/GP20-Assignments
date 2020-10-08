boolean randomChance(float probability) {
	return random(1) < probability;
}

// Actual modulus (not remainder).
static int mod(int x, int n) {
	return (x % n + n) % n;
}