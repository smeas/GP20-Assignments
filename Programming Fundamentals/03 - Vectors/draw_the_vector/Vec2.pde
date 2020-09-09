// The instance methods of this class modifies the original vector for
// performance reasons (no structs in java). Use the static methods to get a
// new vector.
//
// The vector returned from the instance methods is just the vector itself.
// This is useful for chaining.

// Static is required here because of how processing and java works...
static class Vec2 {
	public float x, y;

	public Vec2() {}

	public Vec2(float value) {
		this(value, value);
	}

	public Vec2(float x, float y) {
		this.x = x;
		this.y = y;
	}


	public Vec2 clone() {
		return new Vec2(x, y);
	}

	public Vec2 set(float x, float y) {
		this.x = x;
		this.y = y;
		return this;
	}

	public Vec2 set(Vec2 vec) {
		x = vec.x;
		y = vec.y;
		return this;
	}

	public float length() {
		return sqrt(sq(x) + sq(y));
	}

	public float lengthSq() {
		return sq(x) + sq(y);
	}

	public float distance(Vec2 vec) {
		return sqrt(sq(vec.x - x) + sq(vec.y - y));
	}

	public Vec2 rotate(float theta) {
		float oldX = x;
		float sinTheta = sin(theta);
		float cosTheta = cos(theta);

		x = cosTheta * x    - sinTheta * y;
		y = sinTheta * oldX + cosTheta * y;
		return this;
	}

	// Arithmetic

	public Vec2 add(Vec2 vec) {
		return add(vec.x, vec.y);
	}

	public Vec2 add(float x, float y) {
		this.x += x;
		this.y += y;
		return this;
	}

	public Vec2 sub(Vec2 vec) {
		return sub(vec.x, vec.y);
	}

	public Vec2 sub(float x, float y) {
		this.x -= x;
		this.y -= y;
		return this;
	}

	public Vec2 mul(float value) {
		x *= value;
		y *= value;
		return this;
	}

	public Vec2 div(float value) {
		x /= value;
		y /= value;
		return this;
	}


	public String toString() {
		return "(" + x + ", " + y + ")";
	}


	// Static functions

	public static float distance(Vec2 a, Vec2 b) {
		return sqrt(sq(b.x - a.x) + sq(b.y - a.y));
	}

	public static Vec2 rotate(Vec2 vec, float theta) {
		float sinTheta = sin(theta);
		float cosTheta = cos(theta);

		return new Vec2(
			cosTheta * vec.x - sinTheta * vec.y,
			sinTheta * vec.x + cosTheta * vec.y);
	}


	public static Vec2 add(Vec2 a, Vec2 b) {
		return new Vec2(a.x + b.x, a.y + b.y);
	}

	public static Vec2 sub(Vec2 a, Vec2 b) {
		return new Vec2(a.x - b.x, a.y - b.y);
	}

	public static Vec2 mul(Vec2 vec, float value) {
		return new Vec2(vec.x * value, vec.y * value);
	}

	public static Vec2 div(Vec2 vec, float value) {
		return new Vec2(vec.x / value, vec.y / value);
	}
}