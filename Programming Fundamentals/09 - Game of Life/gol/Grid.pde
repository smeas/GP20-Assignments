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
	public PVector position;
	public PVector size;
	public final int gridSizeX, gridSizeY;

	private Cell[][] cells;
	private Cell[][] tempCells;


	public Grid(int gridSizeX, int gridSizeY) {
		this(new PVector(), new PVector(width, height), gridSizeX, gridSizeY);
	}

	public Grid(PVector position, PVector size, int gridSizeX, int gridSizeY) {
		this.position = position;
		this.size = size;
		this.gridSizeX = gridSizeX;
		this.gridSizeY = gridSizeY;

		cells = new Cell[gridSizeX][gridSizeY];
		tempCells = new Cell[gridSizeX][gridSizeY];

		for (int y = 0; y < gridSizeY; y++)
		for (int x = 0; x < gridSizeX; x++) {
			cells[x][y] = new Cell();
			tempCells[x][y] = new Cell();
		}
	}


	public void step() {
		for (int y = 0; y < gridSizeY; y++)
		for (int x = 0; x < gridSizeX; x++) {
			updateCell(x, y);
		}

		for (int y = 0; y < gridSizeY; y++)
		for (int x = 0; x < gridSizeX; x++) {
			cells[x][y].copyFrom(tempCells[x][y]);
		}
	}

	public void draw() {
		stroke(255);

		float cellSizeX = size.x / gridSizeX;
		float cellSizeY = size.y / gridSizeY;

		for (int y = 0; y < gridSizeY; y++)
		for (int x = 0; x < gridSizeX; x++) {
			Cell cell = get(x, y);
			if (cell.alive) {
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

			rect(position.x + x * cellSizeX,
			     position.y + y * cellSizeY, cellSizeX, cellSizeY);
		}
	}

	public Cell get(IVec pos) {
		return get(pos.x, pos.y);
	}

	public Cell get(int x, int y) {
		x = mod(x, gridSizeX);
		y = mod(y, gridSizeY);
		return cells[x][y];
	}

	public void set(IVec pos, boolean value) {
		set(pos.x, pos.y, value);
	}

	public void set(int x, int y, boolean value) {
		x = mod(x, gridSizeX);
		y = mod(y, gridSizeY);
		cells[x][y].setAlive(value);
		tempCells[x][y].setAlive(value);
	}

	public void clear() {
		for (int y = 0; y < gridSizeY; y++)
		for (int x = 0; x < gridSizeX; x++) {
			set(x, y, false);
		}
	}

	public boolean isScreenPointInGrid(float x, float y) {
		return pointInRect(x, y, position.x, position.y, size.x, size.y);
	}

	public IVec screenPointToGrid(float x, float y) {
		float cellSizeX = size.x / gridSizeX;
		float cellSizeY = size.y / gridSizeY;
		int gx = (int)floor(x / cellSizeX - grid.position.x);
		int gy = (int)floor(y / cellSizeY - grid.position.y);
		return new IVec(gx, gy);
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
		x = mod(x, gridSizeX);
		y = mod(y, gridSizeY);
		return tempCells[x][y];
	}

	// private void setTemp(int x, int y, boolean value) {
	// 	x = mod(x, gridSizeX);
	// 	y = mod(y, gridSizeY);
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