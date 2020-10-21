using System;
using System.Collections;
using System.Text;
using UnityEngine;
using UnityEngine.UI;

public class EnigmaMachineController : MonoBehaviour {
	[SerializeField] private Transform[] codeWheels = new Transform[3];
	[SerializeField] private Transform[] keys = new Transform[26];
	[SerializeField] private Text outputText;
	[SerializeField] private AudioClip clickSound;

	[Header("Key press")]
	[SerializeField] private AnimationCurve keyPressCurve;
	[SerializeField] private float keyPressDuration = 0.2f;
	[SerializeField] private float keyPressAmount = 0.1f;

	private readonly EnigmaMachine machine = new EnigmaMachine();
	private readonly StringBuilder outputBuilder = new StringBuilder();
	private readonly Coroutine[] keyPressRoutines = new Coroutine[26];

	private Camera mainCamera;
	private AudioSource audioSource;

	private void Start() {
		outputText.text = "";
		mainCamera = Camera.main;
		audioSource = GetComponent<AudioSource>();
	}

	private void Update() {
		AcceptString(Input.inputString);

		if (Input.GetMouseButtonDown(0)) {
			Ray ray = mainCamera.ScreenPointToRay(Input.mousePosition);
			if (Physics.Raycast(ray, out RaycastHit hit) && hit.transform.CompareTag("Key")) {
				int index = Array.IndexOf(keys, hit.transform);
				if (index == -1) return;

				char chr = EnigmaMachine.IndexToChar(index);
				if (EnigmaMachine.IsValidKey(chr)) {
					AcceptChar(chr);
				}
			}
		}
	}


	private void AcceptString(string input) {
		bool changed = false;

		foreach (char chr in input.ToUpper()) {
			if (!EnigmaMachine.IsValidKey(chr))
				continue;

			PressKey(chr);
			changed = true;
		}

		if (changed) UpdateVisuals();
	}

	private void AcceptChar(char chr) {
		if (!EnigmaMachine.IsValidKey(chr))
			return;

		PressKey(chr);
		UpdateVisuals();
	}

	private void PressKey(char chr) {
		char result = machine.PressKey(chr);
		AppendOutputChar(result);

		int keyIndex = EnigmaMachine.CharToIndex(chr);
		if (keyPressRoutines[keyIndex] == null) {
			keyPressRoutines[keyIndex] = StartCoroutine(CoPressKey(keyIndex));
		}

		audioSource.PlayOneShot(clickSound);
	}

	private void UpdateVisuals() {
		UpdateCodeWheelRotations();
		outputText.text = outputBuilder.ToString();
	}

	private void AppendOutputChar(char chr) {
		if ((outputBuilder.Length + 1) % 6 == 0)
			outputBuilder.Append(' ');
		outputBuilder.Append(chr);
	}

	private void UpdateCodeWheelRotations() {
		const float step = 360 / 26f;

		for (int i = 0; i < 3; i++) {
			float angle = -machine.wheels[i].Offset * step;
			codeWheels[i].localRotation = Quaternion.AngleAxis(angle, Vector3.right);
		}
	}

	private IEnumerator CoPressKey(int keyIndex) {
		Transform key = keys[keyIndex];
		float startHeight = key.localPosition.y;
		float endHeight = startHeight - keyPressAmount;

		float time = 0;
		while (true) {
			time += Time.deltaTime;
			if (time >= keyPressDuration) break;

			float t = keyPressCurve.Evaluate(time / keyPressDuration);
			float height = startHeight + (endHeight - startHeight) * t;

			Vector3 keyPosition = key.localPosition;
			keyPosition.y = height;
			key.localPosition = keyPosition;

			yield return null;
		}

		keyPressRoutines[keyIndex] = null;
	}
}