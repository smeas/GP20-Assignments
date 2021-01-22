WalkerInterface walker;
PVector walkerPos;

void setup() {
	size(640, 480);
	frameRate(1000);

	walker = new JonJoh();
	walkerPos = walker.getStartPosition(width, height).copy();
}

void draw() {
	point(walkerPos.x, walkerPos.y);

	PVector delta = walker.update();
	if (delta.x == -1 && delta.y ==  0 ||
	    delta.x ==  1 && delta.y ==  0 ||
		delta.x ==  0 && delta.y ==  1 ||
		delta.x ==  0 && delta.y == -1);
	else
		println("Bad delta: " + delta);

	walkerPos.add(delta);
}