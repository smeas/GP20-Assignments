float sign(float v) { return v < 0 ? -1 : 1; }

float clamp(float value, float min, float max) {
	if (value <= min) return min;
	if (value >= max) return max;
	return value;
}

// Move 'num' towards (but not past) 'target' for a maximum distance of 'maxStep'
float moveTowards(float num, float target, float maxStep) {
	if (abs(target - num) <= maxStep)
		return target;

	return num + maxStep * sign(target - num);
}

// Modulus (not remainder)
float mod(float x, float n) { return (x % n + n) % n; }