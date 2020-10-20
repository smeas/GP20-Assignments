using System;
using UnityEngine;

public class PlayerController : MonoBehaviour {
	[SerializeField] private float speed;
	[SerializeField] private float jumpForce;
	[SerializeField] private Collider2D groundTrigger;

	private new Rigidbody2D rigidbody;

	private float moveInput;
	private bool jumpInput;
	private bool isGrounded;

	private void Awake() {
		rigidbody = GetComponent<Rigidbody2D>();
	}

	private void Update() {
		moveInput = Input.GetAxis("Horizontal");

		if (Input.GetButtonDown("Jump") && isGrounded) {
			jumpInput = true;
		}
	}

	private void FixedUpdate() {
		Vector2 velocity = rigidbody.velocity;
		velocity.x = moveInput * speed;

		if (jumpInput) {
			velocity.y += jumpForce;
			jumpInput = false;
		}

		rigidbody.velocity = velocity;
	}

	private void OnTriggerEnter2D(Collider2D other) => UpdateGrounded();
	private void OnTriggerExit2D(Collider2D other) => UpdateGrounded();

	private void UpdateGrounded() {
		isGrounded = groundTrigger.IsTouchingLayers();
	}
}