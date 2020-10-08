final color ALIVE_COLOR_START = color(85, 198, 250);
final color ALIVE_COLOR_END = color(9, 121, 173);
final int ALIVE_COLOR_STEPS = 8;

final color DEAD_COLOR_START = color(255, 200, 200);
final color DEAD_COLOR_END = color(255);
final int DEAD_COLOR_STEPS = 2;

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

		for (int y = 0; y < gridSizeY; y++)
		for (int x = 0; x < gridSizeX; x++) {
			initCell(cells, x, y);
			initCell(tempCells, x, y);
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
				fill(lerpColor(ALIVE_COLOR_START, ALIVE_COLOR_END, (float)cell.age / ALIVE_COLOR_STEPS));
			}
			else {
				fill(lerpColor(DEAD_COLOR_START, DEAD_COLOR_END, (float)cell.age / DEAD_COLOR_STEPS));
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
		Cell cell = cells[x][y];
		Cell tempCell = tempCells[x][y];
		int aliveNeighbors = getAliveNeighborCount(cell);

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

	private int getAliveNeighborCount(Cell cell) {
		int aliveCount = 0;
		for (int i = 0; i < NEIGHBOR_COUNT; i++) {
			if (cell.neighbors[i].alive)
				aliveCount++;
		}

		return aliveCount;
	}

	private void initCell(Cell[][] array, int px, int py) {
		Cell cell = array[px][py];
		for (int i = 0; i < NEIGHBOR_COUNT; i++) {
			int x = mod(px + neighborOffsets[i][0], gridSizeX);
			int y = mod(py + neighborOffsets[i][1], gridSizeY);
			cell.neighbors[i] = array[x][y];
		}
	}
}