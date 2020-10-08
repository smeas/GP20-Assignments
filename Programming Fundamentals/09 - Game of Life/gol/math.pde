boolean randomChance(float probability) {
	return random(1) < probability;
}

// Actual modulus (not remainder).
static int mod(int x, int n) {
	return (x % n + n) % n;
}

static boolean pointInRect(float px, float py, float rx, float ry, float rw, float rh) {
	return px >= rx &&
	       py >= ry &&
	       px < rx + rw &&
		   py < ry + rh;
}