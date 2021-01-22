class JonJoh implements WalkerInterface {
	final int RIGHT = 0;
	final int DOWN = 1;
	final int LEFT = 2;
	final int UP = 3;

	final PVector[] directions = {
		new PVector(1, 0),
		new PVector(0, 1),
		new PVector(-1, 0),
		new PVector(0, -1),
	};

	int SPACING = 5;

	ArrayList<PVector> moves = new ArrayList<PVector>();
	int index;
	PVector position = new PVector();
	int screenWidth, screenHeight;
	int currentDir;

	String getName() { return "Jonatan"; }

	PVector getStartPosition(int sizeX, int sizeY) {
		screenWidth = sizeX;
		screenHeight = sizeY;

		int squareSize = min(sizeX, sizeY);
		int level = maxPeanoLevelForSize(squareSize, SPACING);

		while (peanoSize(level, SPACING + 1) <= squareSize)
			SPACING++;

		println("level: " + level);
		println("spacing: " + SPACING);
		println("size: " + peanoSize(level, SPACING));

		Turtle turt = peanoCurve(level, 0, sizeY - 1);
		moves = turt.moves;

		position.set(new PVector(0, sizeY - 1));
		return position;
	}

	PVector update() {
		PVector move;

		if (index < moves.size()) {
			move = moves.get(index++);
		}
		else {
			if (random(1) < 0.1f) {
				currentDir = (int)random(4);
			}

			if (position.x <= 0 || position.x >= screenWidth - 1) {
				currentDir = random(1) < 0.5f ? LEFT : RIGHT;
			}
			else if (position.y <= 0 || position.y >= screenHeight - 1) {
				currentDir = random(1) < 0.5f ? UP : DOWN;
			}

			move = directions[currentDir];
		}

		position.add(move);
		return move;
	}


	float logn(float value, float n) {
		return log(value) / log(n);
	}

	int peanoSize(int level, int spacing) {
		return ceil((3 + spacing * 3) * pow(3, level - 1) - spacing);
	}

	int maxPeanoLevelForSize(int size, int spacing) {
		return floor(logn((float)(size + SPACING) / (3 + SPACING * 3), 3) + 1);
	}


	Turtle peanoCurve(int levels, int x, int y) {
		Turtle t = new Turtle(width, height, 0, height - 1);
		t.setDirection(UP);
		peanoCurve(t, levels, false);
		return t;
	}

	void peanoCurve(Turtle t, int level, boolean flip) {
		if (level == 0) return;

		// if (level == 1) {
		// 	t.forward(3 + SPACING * 2);
		// 	t.right(flip);
		// 	t.forward(1 + SPACING);
		// 	t.right(flip);
		// 	t.forward(3 + SPACING * 2);
		// 	t.left(flip);
		// 	t.forward(1 + SPACING);
		// 	t.left(flip);
		// 	t.forward(3 + SPACING * 2);
		// }
		// else {
		peanoCurve(t, level - 1, flip);
		t.forward(1 + SPACING);
		peanoCurve(t, level - 1, !flip);
		t.forward(1 + SPACING);
		peanoCurve(t, level - 1, flip);
		t.right(flip);
		t.forward(1 + SPACING);
		t.right(flip);
		peanoCurve(t, level - 1, !flip);
		t.forward(1 + SPACING);
		peanoCurve(t, level - 1, flip);
		t.forward(1 + SPACING);
		peanoCurve(t, level - 1, !flip);
		t.left(flip);
		t.forward(1 + SPACING);
		t.left(flip);
		peanoCurve(t, level - 1, flip);
		t.forward(1 + SPACING);
		peanoCurve(t, level - 1, !flip);
		t.forward(1 + SPACING);
		peanoCurve(t, level - 1, flip);
		//}
	}


	class Turtle {
		public boolean[][] grid;
		public ArrayList<PVector> moves = new ArrayList<PVector>();

		int px, py;
		int direction;

		public Turtle(int gridSizeX, int gridSizeY, int px, int py) {
			this.px = px;
			this.py = py;
			grid = new boolean[gridSizeX][gridSizeY];
			grid[px][py] = true;
		}

		public void setDirection(int r) { direction = r & 3; }
		public void right() { direction = (direction + 1) & 3; }
		public void left() { direction = (direction - 1) & 3; }

		public void right(boolean flip) { if (flip) left(); else right(); }
		public void left(boolean flip) { if (flip) right(); else left(); }

		public void forward(int n) {
			for (int i = 0; i < n; i++) {
				int dx = 0, dy = 0;
				switch (direction) {
					case RIGHT: dx++; break;
					case DOWN: dy++; break;
					case LEFT: dx--; break;
					case UP: dy--; break;
				}

				px += dx;
				py += dy;
				grid[px][py] = true;
				moves.add(new PVector(dx, dy));
			}
		}
	}
}
