// A simple clock that keeps track of time and delta time.
class Clock {
	private int time;
	private float deltaTime;

	public float tick() {
		int currentTime = millis();
		deltaTime = (currentTime - time) / 1000f;
		time = currentTime;
		return deltaTime;
	}

	public float time() { return time / 1000f; }
	public float deltaTime() { return deltaTime; }

	public void reset() {
		time = 0;
	}
}