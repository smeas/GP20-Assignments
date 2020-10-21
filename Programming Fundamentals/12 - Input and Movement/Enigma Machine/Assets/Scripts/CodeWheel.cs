using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

public class CodeWheel {
	private int[] lookupTable;
	private int offset;

	// [0, 26)
	public int Offset {
		get => offset;
		set => offset = Util.Mod(value, 26); // use real modulus to handle negative inputs
	}

	public CodeWheel() : this(Enumerable.Range(0, 26).ToArray()) { }

	public CodeWheel(int[] config) {
		lookupTable = config;
	}

	public void Configure(int[] config) {
		if (config.Length != 26)
			throw new ArgumentException("Configuration is of the wrong length.", nameof(config));
		if (config.Distinct().Count() < 26)
			throw new ArgumentException("Configuration contains duplicate numbers", nameof(config));

		lookupTable = config;
	}

	public void Rotate() {
		Offset++;
	}

	public int Get(int key) {
		if (key < 0 || key >= 26) throw new ArgumentOutOfRangeException(nameof(key));
		return Util.Mod(lookupTable[Util.Mod(key - offset, 26)] + offset, 26);
	}

	public int GetReversed(int key) {
		if (key < 0 || key >= 26) throw new ArgumentOutOfRangeException(nameof(key));
		int index = Util.Mod(Array.IndexOf(lookupTable, Util.Mod(key - offset, 26)) + offset, 26);
		Debug.Assert(index != -1);
		return index;
	}
}