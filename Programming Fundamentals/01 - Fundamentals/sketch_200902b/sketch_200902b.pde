final float CW = 60;                 // character width
final float CH = 120;                // character height
final float CY_LOW = 50;             // y offset where the arc in the 'J' begins
final float WEIGHT = 10;             // stroke weight
final float CPAD = CW + 10 + WEIGHT; // character padding

final float NAME_WIDTH = CPAD * 7;
final float NAME_HEIGHT = CH;

final float COLOR_STEP = 0.004; // color changing step

float colorOffset;
float rot = radians(30);

void setup() {
	size(768, 432);
	strokeWeight(WEIGHT);
	smooth(4); // antialiasing
	
	noFill();
}

void draw() {
	clear();
	background(0xc3c3c3);

	//drawName((width - NAME_WIDTH) / 2, (height - NAME_HEIGHT) / 2, colorOffset);
	translate(width / 2, height / 2);
	rotate(pingPong(rot, radians(60)) - radians(30));
	drawName(-NAME_WIDTH / 2, -NAME_HEIGHT / 2, colorOffset);

	rot += 0.005;
	colorOffset += COLOR_STEP;
}

// Set the stroke color by hue.
void hueColor(float hue) {
	colorMode(HSB, 1);
	stroke(hue % 1, 1, 1);
	colorMode(RGB);
}

float pingPong(float v, float length) {
	v = v % (length * 2);
	return length - abs(v - length);
}

void drawName(float x, float y, float colorOffset) {
	hueColor(0/7f + colorOffset); J(x + CPAD*0, y);
	hueColor(1/7f + colorOffset); O(x + CPAD*1, y);
	hueColor(2/7f + colorOffset); N(x + CPAD*2, y);
	hueColor(3/7f + colorOffset); A(x + CPAD*3, y);
	hueColor(4/7f + colorOffset); T(x + CPAD*4, y);
	hueColor(5/7f + colorOffset); A(x + CPAD*5, y);
	hueColor(6/7f + colorOffset); N(x + CPAD*6, y);
}

// Letters

void J(float x, float y) {	
	line(x, y, x + CW, y);
	line(x + CW, y, x + CW, y + CH - CY_LOW/2);
	arc(x + CW/2, y + CH - CY_LOW/2, CW, CY_LOW, 0, PI);
}

void O(float x, float y) {
	ellipse(x + CW/2, y + CH/2, CW, CH);
}

void N(float x, float y) {
	line(x, y + CH, x, y);
	line(x, y, x + CW, y + CH);
	line(x + CW, y + CH, x + CW, y);
}

void A(float x, float y) {
	line(x, y + CH, x + CW/2, y);
	line(x + CW/2, y, x + CW, y + CH);
	line(x + CW/4, y + CH/2, x + 3*(CW/4), y + CH/2);
}

void T(float x, float y) {
	line(x, y, x + CW, y);
	line(x + CW/2, y, x + CW/2, y + CH);
}
