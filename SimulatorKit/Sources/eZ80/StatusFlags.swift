//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2024-03-18.
//

public struct StatusFlags: OptionSet {
	public var rawValue: UInt8

	public init(rawValue: UInt8) {
		self.rawValue = rawValue
	}

	public static let c = Self(rawValue: 0x1)
	public static let n = Self(rawValue: 0x2)
	public static let pv = Self(rawValue: 0x4)
	public static let h = Self(rawValue: 0x10)
	public static let z = Self(rawValue: 0x40)
	public static let s = Self(rawValue: 0x80)

	/// Carry flag
	public var c: Bool {
		get { rawValue.bits[0] }
		set { rawValue.bits[0] = newValue }
	}

	/// Add/Subtract flag
	public var n: Bool {
		get { rawValue.bits[1] }
		set { rawValue.bits[1] = newValue }
	}

	/// Parity/Overflow
	public var pv: Bool {
		get { rawValue.bits[2] }
		set { rawValue.bits[2] = newValue }
	}

	/// Half-Carry
	public var h: Bool {
		get { rawValue.bits[4] }
		set { rawValue.bits[4] = newValue }
	}

	/// Zero
	public var z: Bool {
		get { rawValue.bits[6] }
		set { rawValue.bits[6] = newValue }
	}

	/// Sign
	public var s: Bool {
		get { rawValue.bits[7] }
		set { rawValue.bits[7] = newValue }
	}
}
