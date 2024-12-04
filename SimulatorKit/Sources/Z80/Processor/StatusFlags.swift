//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2024-03-18.
//

import EmulationKit

public struct StatusFlags: OptionSet {
	public var rawValue: UInt8

	@inlinable
	public init(rawValue: UInt8) {
		self.rawValue = rawValue
	}

	public static let c = Self(rawValue: 0x1)
	public static let n = Self(rawValue: 0x2)
	public static let pv = Self(rawValue: 0x4)
	public static let h = Self(rawValue: 0x10)
	public static let z = Self(rawValue: 0x40)
	public static let s = Self(rawValue: 0x80)

}

extension StatusFlags {

	/// Carry flag
	@inlinable
	public var c: Bool {
		get { self[.c] }
		set { self[.c] = newValue }
	}

	/// Add/Subtract flag
	@inlinable
	public var n: Bool {
		get { self[.n] }
		set { self[.n] = newValue }
	}

	/// Parity/Overflow
	@inlinable
	public var pv: Bool {
		get { self[.pv] }
		set { self[.pv] = newValue }
	}

	/// Half-Carry
	@inlinable
	public var h: Bool {
		get { self[.h] }
		set { self[.h] = newValue }
	}

	/// Zero
	@inlinable
	public var z: Bool {
		get { self[.z] }
		set { self[.z] = newValue }
	}

	/// Sign
	@inlinable
	public var s: Bool {
		get { self[.s] }
		set { self[.s] = newValue }
	}
}
