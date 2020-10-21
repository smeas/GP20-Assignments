using System;
using System.Linq;

public class EnigmaMachine {
	// https://en.wikipedia.org/wiki/Enigma_rotor_details#Rotor_wiring_tables

	private static readonly string[] wheelConfigs = {
		"JGDQOXUSCAMIFRVTPNEWKBLZYH",
		"NTZPSFBOKMWRCJDIVLAEYUXHGQ",
		"JVIUBHTCDYAKEQZPOSGXNRMWFL",
	};

	private const string reflectorConfig = "QYHOGNECVPUZTFDJAXWMKISRBL";

	private static readonly int[] turnoverPositions = {
		17, // Q-R
		5, // E-F
		//22, // V-W
	};

	public CodeWheel[] wheels; // min 2
	public CodeWheel reflector;

	public EnigmaMachine() {
		wheels = new CodeWheel[3];
		reflector = new CodeWheel(ParseConfig(reflectorConfig));

		for (int i = 0; i < wheels.Length; i++) {
			wheels[i] = new CodeWheel(ParseConfig(wheelConfigs[i]));
		}
	}

	public char PressKey(char chr) {
		int key = CharToIndex(chr);

		Step();

		for (int i = 0; i < wheels.Length; i++) {
			key = wheels[i].Get(key);
		}

		key = reflector.Get(key);

		for (int i = wheels.Length - 1; i >= 0; i--) {
			key = wheels[i].GetReversed(key);
		}

		return IndexToChar(key);
	}

	private void Step() {
		int i = 0;
		while (true) {
			wheels[i].Rotate();
			if (i >= wheels.Length - 1) break;
			if (wheels[i].Offset != turnoverPositions[i])
				break;
			i++;
		}
	}


	public static bool IsValidKey(char key) {
		return key >= 0x41 && key <= 0x5a;
	}

	private static int[] ParseConfig(string config) {
		return config.Select(CharToIndex).ToArray();
	}

	public static int CharToIndex(char chr) {
		int index = (int)chr - 0x41;
		if (index < 0 || index >= 26) throw new Exception("Character out of range.");
		return index;
	}

	public static char IndexToChar(int index) {
		if (index < 0 || index >= 26) throw new Exception("Character index out of range.");
		return (char)(index + 0x41);
	}
}