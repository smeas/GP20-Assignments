float sign(float v) {
	return v < 0 ? -1 : 1;
}

float clamp(float value, float min, float max) {
	if (value <= min) return min;
	if (value >= max) return max;
	return value;
}

// Move 'num' towards (but not past) 'target' for a maximum distance of 'maxStep'.
float moveTowards(float num, float target, float maxStep) {
	if (abs(target - num) <= maxStep)
		return target;

	return num + maxStep * sign(target - num);
}

// Modulus (not remainder).
float mod(float x, float n) {
	return (x % n + n) % n;
}

// Distance squared.
float distSq(PVector a, PVector b) {
	return distSq(a.x, a.y, b.x, b.y);
}

float distSq(float x1, float y1, float x2, float y2) {
	return sq(x2 - x1) + sq(y2 - y1);
}

boolean circleCollision(float x1, float y1, float radius1, float x2, float y2, float radius2) {
	float maxDistance = radius1 + radius2;

	if (abs(x1 - x2) > maxDistance || abs(y1 - y2) > maxDistance) {
		return false;
	}
	else if (dist(x1, y1, x2, y2) > maxDistance) {
		return false;
	}

	return true;
}

// Stupid `PVector.angleBetween` always returns a positive angle...
float signedAngleBetween(PVector a, PVector b) {
	return atan2(a.x*b.y - a.y*b.x, a.x*b.x + a.y*b.y);
}

// Random

PVector randomVector(float high) {
	return randomVector(0, high);
}

PVector randomVector(float low, float high) {
	return randomVector(low, high, low, high);
}

PVector randomVector(float xLow, float xHigh, float yLow, float yHigh) {
	return new PVector(random(xLow, xHigh), random(yLow, yHigh));
}

PVector randomDirection() {
	return randomVector(-1, 1).normalize();
}

color randomColor() {
	return color(random(255), random(255), random(255));
}

boolean randomChance(float probability) {
	return random(1) < probability;
}
