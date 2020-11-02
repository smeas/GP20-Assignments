using System;
using UnityEngine;

public class PlayerController : MonoBehaviour {
	[SerializeField] private float speed = 5;

	private new SpriteRenderer renderer;
	private Animator animator;

	private void Start() {
		renderer = GetComponent<SpriteRenderer>();
		animator = GetComponent<Animator>();
	}

	private void Update() {
		float input = Input.GetAxis("Horizontal");
		bool chew = Input.GetKey(KeyCode.Space);

		Vector3 position = transform.position;
		position.x += input * speed * Time.deltaTime;
		transform.position = position;

		if (input > 0)
			renderer.flipX = true;
		else if (input < 0)
			renderer.flipX = false;

		animator.SetFloat("speed", Mathf.Abs(input * speed));
		animator.SetBool("chewing", chew);
	}
}