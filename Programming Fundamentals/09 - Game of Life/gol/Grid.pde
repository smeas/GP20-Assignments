static final int NEIGHBOR_COUNT = 8;

static int[][] neighborOffsets = {
	{-1, -1},
	{ 0, -1},
	{ 1, -1},
	{-1,  0},
	{ 1,  0},
	{-1,  1},
	{ 0,  1},
	{ 1,  1},
};

class Grid {
	public final int sizeX, sizeY;

	private Cell[][] cells;
	private Cell[][] tempCells;

	public Grid(int sizeX, int sizeY) {
		this.sizeX = sizeX;
		this.sizeY = sizeY;

		cells = new Cell[sizeX][sizeY];
		tempCells = new Cell[sizeX][sizeY];

		for (int y = 0; y < sizeY; y++)
		for (int x = 0; x < sizeX; x++) {
			cells[x][y] = new Cell();
			tempCells[x][y] = new Cell();
		}
	}

	public void step() {
		for (int y = 0; y < sizeY; y++)
		for (int x = 0; x < sizeX; x++) {
			updateCell(x, y);
		}

		for (int y = 0; y < sizeY; y++)
		for (int x = 0; x < sizeX; x++) {
			cells[x][y].copyFrom(tempCells[x][y]);
		}
	}

	public void draw() {
		stroke(255);

		float cellSize = width / sizeX;
		for (int y = 0; y < sizeY; y++)
		for (int x = 0; x < sizeX; x++) {
			Cell cell = get(x, y);
			if (cell.alive) {
				fill(0);
				// Reds
				// 235, 64, 52
				// 148, 30, 22

				// Blues
				// 85, 198, 250
				// 52, 177, 235
				// 9, 121, 173

				fill(lerpColor(color(85, 198, 250), color(9, 121, 173), cell.age / 8f));
			}
			else {
				fill(lerpColor(color(255, 200, 200), color(255), cell.age / 2f));
			}

			rect(x * cellSize, y * cellSize, cellSize, cellSize);
		}
	}

	public Cell get(int x, int y) {
		x = mod(x, sizeX);
		y = mod(y, sizeY);
		return cells[x][y];
	}

	public void set(int x, int y, boolean value) {
		x = mod(x, sizeX);
		y = mod(y, sizeY);
		cells[x][y].setAlive(value);
		tempCells[x][y].setAlive(value);
	}

	public void clear() {
		for (int y = 0; y < sizeY; y++)
		for (int x = 0; x < sizeX; x++) {
			set(x, y, false);
		}
	}

	private void updateCell(int x, int y) {
		Cell cell = get(x, y);
		Cell tempCell = getTemp(x, y);
		int aliveNeighbors = getAliveNeighborCount(x, y);

		tempCell.age++;
		if (cell.alive) {
			if (aliveNeighbors < 2 || aliveNeighbors > 3) {
				tempCell.setAlive(false);
			}
		}
		else if (aliveNeighbors == 3) {
			tempCell.setAlive(true);
		}
	}

	public Cell getTemp(int x, int y) {
		x = mod(x, sizeX);
		y = mod(y, sizeY);
		return tempCells[x][y];
	}

	// private void setTemp(int x, int y, boolean value) {
	// 	x = mod(x, sizeX);
	// 	y = mod(y, sizeY);
	// 	tempCells[x][y].setAlive(value);
	// }

	private int getAliveNeighborCount(int x, int y) {
		int aliveCount = 0;
		for (int i = 0; i < NEIGHBOR_COUNT; i++) {
			Cell neighbor = get(x + neighborOffsets[i][0], y + neighborOffsets[i][1]);
			if (neighbor.alive) {
				aliveCount++;
			}
		}

		return aliveCount;
	}
}