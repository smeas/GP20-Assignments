using System;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Net.Sockets;
using System.Windows;
using System.Windows.Input;

namespace WalkerControl {
	public partial class MainWindow {
		private TcpListener server;
		private List<TcpClient> clients = new List<TcpClient>();
		private Direction currentDirection = Direction.Up;

		public MainWindow() {
			InitializeComponent();
		}

		#region Event handlers

		private async void MainWindow_OnLoaded(object sender, RoutedEventArgs e) {
			KeyDown += OnKeyDown;

			// Start the TCP server.
			server = new TcpListener(IPAddress.Any, 4000);
			server.Start();

			try {
				while (true) {
					// Asynchronously accept new client connections.
					TcpClient client = await server.AcceptTcpClientAsync();
					clients.Add(client);
					SendDirection(currentDirection);
					WriteLog($"Client connected: {client.Client.RemoteEndPoint}");
				}
			}
			catch (ObjectDisposedException) { /* This means we're shutting down and can be ignored. */ }
		}

		private void MainWindow_OnClosed(object sender, EventArgs e) {
			// Disconnect all clients and stop the server.
			foreach (TcpClient client in clients) {
				client.Dispose();
			}

			server.Stop();
		}

		private void OnKeyDown(object sender, KeyEventArgs e) {
			switch (e.Key) {
				case Key.W: SendDirection(Direction.Up); break;
				case Key.D: SendDirection(Direction.Right); break;
				case Key.S: SendDirection(Direction.Down); break;
				case Key.A: SendDirection(Direction.Left); break;
			}
		}

		private void UpButton_Click(object sender, RoutedEventArgs e) => SendDirection(Direction.Up);
		private void RightButton_Click(object sender, RoutedEventArgs e) => SendDirection(Direction.Right);
		private void DownButton_Click(object sender, RoutedEventArgs e) => SendDirection(Direction.Down);
		private void LeftButton_Click(object sender, RoutedEventArgs e) => SendDirection(Direction.Left);

		#endregion

		/// <summary>
		/// Send a new direction to all of the clients.
		/// </summary>
		private void SendDirection(Direction dir) {
			currentDirection = dir;
			DirectionLabel.Content = $"Current Direction: {dir}";

			// Convert the direction into raw bytes (little endian).
			byte[] buffer = BitConverter.GetBytes((int)dir);
			for (int i = 0; i < clients.Count; i++) {
				TcpClient client = clients[i];

				try {
					// Send the bytes to the client.
					client.GetStream().Write(buffer, 0, buffer.Length);
				}
				catch (IOException) {
					// Write failed. This usually means that the client has disconnected in some way.
					WriteLog($"Client disconnected: {client.Client.RemoteEndPoint}");
					clients.Remove(client);
					client.Dispose();
					i--;
				}
			}
		}

		private void WriteLog(string line) {
			LogText.Text += line + '\n';
		}


		private enum Direction {
			Up,
			Right,
			Down,
			Left,
		}
	}
}