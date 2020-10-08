class IVec {
	int x, y;

	public IVec() {}
	public IVec(int x, int y) {
		this.x = x;
		this.y = y;
	}

	@Override
	public String toString() {
		return "(" + x + ", " + y + ")";
	}
}