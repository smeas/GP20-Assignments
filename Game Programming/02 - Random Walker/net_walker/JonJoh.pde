import java.io.InputStream;
import java.net.Socket;

class JonJoh implements WalkerInterface {
	final String CONTROLLER_HOST = "localhost";
	final int CONTROLLER_PORT = 4000;

	final int UP = 0;
	final int RIGHT = 1;
	final int DOWN = 2;
	final int LEFT = 3;

	final PVector[] directions = {
		new PVector(0, -1),
		new PVector(1, 0),
		new PVector(0, 1),
		new PVector(-1, 0),
	};

	ReceiverThread receiver;
	PVector position = new PVector();
	int screenWidth, screenHeight;
	int currentDir;

	String getName() { return "Jonatan"; }

	PVector getStartPosition(int sizeX, int sizeY) {
		screenWidth = sizeX;
		screenHeight = sizeY;

		println("Hello! :)");
		initConnection();

		// TODO: Don't start in the same spot every time. Or at least not in such a common one.
		position.set(sizeX / 2, sizeY / 2);
		return position.copy();
	}

	PVector update() {
		PVector move;

		// If we are connected to a controller, use the input from it. Otherwise fall back to
		// a simple random implementation.
		if (receiver != null && receiver.getConnected()) {
			currentDir = receiver.value;
		}
		else {
			if (random(1) < 0.1f) {
				currentDir = (int)random(4);
			}

			// Wall detection.
			if (position.x <= 0 || position.x >= screenWidth - 1) {
				currentDir = random(1) < 0.5f ? LEFT : RIGHT;
			}
			else if (position.y <= 0 || position.y >= screenHeight - 1) {
				currentDir = random(1) < 0.5f ? UP : DOWN;
			}
		}

		move = directions[currentDir];

		position.add(move);
		return move;
	}

	void initConnection() {
		try {
			// Start the networking thread.
			receiver = new ReceiverThread(CONTROLLER_HOST, CONTROLLER_PORT);
			receiver.start();
		}
		catch (Exception e) {
			println("Failed to connect: " + e);
		}
	}

	class ReceiverThread extends Thread {
		String host;
		int port;
		Socket socket;
		Object lock = new Object();
		boolean connected;
		int value;

		public ReceiverThread(String host, int port) {
			this.host = host;
			this.port = port;
		}

		//
		// Thread safe getters and setters.
		//

		public boolean getConnected() {
			synchronized (lock) { return connected; }
		}

		public int getValue() {
			synchronized (lock) { return value; }
		}

		void setConnected(boolean value) {
			synchronized (lock) { connected = value; }
		}

		void setValue(int value) {
			synchronized (lock) { this.value = value; }
		}

		@Override
		public void run() {
			while (true) {
				try {
					// Attempt to connect to the controller.
					socket = new Socket(host, port);
					setConnected(true);
					println("Connected");

					receiveLoop();
				}
				catch (Exception e) {
					println("Failed to connect: " + e);
					setConnected(false);
				}

				try {
					// Wait before trying to connect again.
					Thread.sleep(5000);
				}
				catch (InterruptedException e) { /* Unused */ }
			}
		}

		void receiveLoop() {
			try {
				InputStream inputStream = socket.getInputStream();
				byte[] bytes = new byte[4];

				while (true) {
					// Read data from the network stream.
					int bytesRead = inputStream.read(bytes);
					if (bytesRead != 4) { // Not enough data, or connection closed.
						println("Read only " + bytesRead + " bytes. Closing connection.");
						socket.close();
						setConnected(false);
						return;
					}

					// Convert the raw bytes into a direction value.
					int value = bytesToIntLE(bytes) & 3;
					println("Received value: " + value);
					setValue(value);
				}
			}
			catch (Exception e) {
				println("Receive error: " + e);
				setConnected(false);
			}
		}

		// Decode a little endian int from 4 bytes.
		int bytesToIntLE(byte[] bytes) {
			return bytes[0] |
				bytes[1] << 8 |
				bytes[2] << 16 |
				bytes[3] << 24;
		}
	}
}
