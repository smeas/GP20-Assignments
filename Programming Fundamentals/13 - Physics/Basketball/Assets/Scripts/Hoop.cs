using System;
using UnityEngine;
using UnityEngine.UI;

public class Hoop : MonoBehaviour {
	[SerializeField] private Text scoreText;

	private int score;

	private void Start() {
		UpdateScoreText();
	}

	private void OnTriggerEnter2D(Collider2D other) {
		if (other.attachedRigidbody.velocity.y < 0 && other.CompareTag("Ball")) {
			score++;
			UpdateScoreText();
		}
	}

	private void UpdateScoreText() {
		scoreText.text = $"Score: {score}";
	}
}