public static class Util {
	public static int Mod(int a, int b) {
		int remainder = a % b;
		return remainder < 0 ? remainder + b : remainder;
	}
}