static final int NEIGHBOR_COUNT = 8;

int[][] neighborOffsets = {
	{-1, -1},
	{ 0, -1},
	{ 1, -1},
	{-1,  0},
	{ 1,  0},
	{-1,  1},
	{ 0,  1},
	{ 1,  1},
};

// Actual modulus (not remainder).
static int mod(int x, int n) {
	return (x % n + n) % n;
}

class Grid {
	public final int width, height;
	private boolean[][] cells;
	private boolean[][] tempCells;

	public Grid(int width, int height) {
		this.width = width;
		this.height = height;
		cells = new boolean[width][height];
		tempCells = new boolean[width][height];
	}

	public void step() {
		for (int y = 0; y < height; y++)
		for (int x = 0; x < width; x++) {
			boolean alive = get(x, y);
			int aliveNeighbors = getAliveNeighbors(x, y);

			if (alive) {
				if (aliveNeighbors < 2 || aliveNeighbors > 3) {
					setTemp(x, y, false);
				}
			}
			else if (aliveNeighbors == 3) {
				setTemp(x, y, true);
			}
		}

		for (int y = 0; y < height; y++)
		for (int x = 0; x < width; x++) {
			cells[x][y] = tempCells[x][y];
		}
	}

	public boolean get(int x, int y) {
		x = mod(x, width);
		y = mod(y, height);
		return cells[x][y];
	}

	public void set(int x, int y, boolean value) {
		x = mod(x, width);
		y = mod(y, height);
		cells[x][y] = value;
		tempCells[x][y] = value;
	}

	public void clear() {
		for (int y = 0; y < height; y++)
		for (int x = 0; x < width; x++) {
			set(x, y, false);
		}
	}

	private void setTemp(int x, int y, boolean value) {
		x = mod(x, width);
		y = mod(y, height);
		tempCells[x][y] = value;
	}

	private int getAliveNeighbors(int x, int y) {
		int alive = 0;
		for (int i = 0; i < NEIGHBOR_COUNT; i++) {
			if (get(x + neighborOffsets[i][0], y + neighborOffsets[i][1])) {
				alive++;
			}
		}

		return alive;
	}
}