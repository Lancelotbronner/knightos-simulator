//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2024-03-18.
//

import EmulationKit

public struct ControlFlags: OptionSet {
	public var rawValue: UInt8

	public init(rawValue: UInt8) {
		self.rawValue = rawValue
	}

	public static let adl = Self(rawValue: 0x1)
	public static let madl = Self(rawValue: 0x2)
	public static let ief1 = Self(rawValue: 0x4)
	public static let ief2 = Self(rawValue: 0x8)

	/// Address and Data Long mode, indicates the current memory mode of the CPU.
	///
	/// An ADL mode bit reset to 0 indicates that the CPU is operating in Z80 MEMORY mode with 16-bit Z80-style addresses offset by the 8-bit MBASE register.
	/// An ADL mode bit set to 1 indicates that the CPU is operating in ADL mode with 24-bit linear addressing.
	///
	/// The default for the ADL mode bit is reset (cleared to 0).
	/// The ADL mode bit can only be changed by those instructions that allow persistent memory mode changes, interrupts, and traps.
	/// The ADL mode bit cannot be directly written to.
	public var adl: Bool {
		get { rawValue.bits[0] }
		set { rawValue.bits[0] = newValue }
	}

	/// Mixed-ADL, configures the CPU to execute programs containing code that uses both ADL and Z80 MEMORY modes.
	///
	/// The MADL control bit is explained in more detail in Interrupts in Mixed Memory Mode Applications on page 36.
	/// An additional explanation is available in the Mixed-Memory Mode Applications on page 34.
	public var madl: Bool {
		get { rawValue.bits[1] }
		set { rawValue.bits[1] = newValue }
	}

	/// Interrupt Enable Flags (IEF1 and IEF2)—in the CPU, there are two interrupt enable flags that are set or reset using the Enable Interrupt (EI) and Disable Interrupt (DI) instructions.
	///
	/// When IEF1 is reset to 0, a maskable interrupt cannot be accepted by the CPU.
	/// The Interrupt Enable flags are described in more detail in Interrupts on page 36.
	public var ief1: Bool {
		get { rawValue.bits[2] }
		set { rawValue.bits[2] = newValue }
	}

	public var ief2: Bool {
		get { rawValue.bits[3] }
		set { rawValue.bits[3] = newValue }
	}

}


