using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

public class PlayerController : MonoBehaviour {
	private enum MovementMethod { Translate, AddForce, Velocity, MovePosition }

	[SerializeField] private MovementMethod movementMethod;
	[SerializeField] private float movementSpeed;

	private new Rigidbody2D rigidbody;


	private void Awake() {
		rigidbody = GetComponent<Rigidbody2D>();
	}

	private void Update() {
		if (movementMethod == MovementMethod.Translate)
			TranslateMovement();
		else if (movementMethod == MovementMethod.Velocity)
			VelocityMovement();
	}

	private void FixedUpdate() {
		if (movementMethod == MovementMethod.AddForce)
			AddForceMovement();
		else if (movementMethod == MovementMethod.MovePosition)
			MovePositionMovement();
	}


	private void TranslateMovement() {
		transform.Translate(GetInputVector() * (movementSpeed * Time.deltaTime));
	}

	private void AddForceMovement() {
		rigidbody.AddForce(GetInputVector() * movementSpeed);
	}

	private void VelocityMovement() {
		rigidbody.velocity = GetInputVector() * movementSpeed;
	}

	private void MovePositionMovement() {
		rigidbody.MovePosition(rigidbody.position + GetInputVector() * (movementSpeed * Time.deltaTime));
	}


	private static Vector2 GetInputVector() {
		Vector2 inputVector = new Vector2(Input.GetAxis("Horizontal"), Input.GetAxis("Vertical"));
		if (inputVector.sqrMagnitude > 1)
			inputVector.Normalize();

		return inputVector;
	}
}