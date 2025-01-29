//
//  ProcessorZ80.swift
//  SimulatorKit
//
//  Created by Christophe Bronner on 2025-01-05.
//

import CoreSimulator
import SimulatorKit

/// Ti CMOS z80s
public final class ProcessorZ80 {

	public init() { }

	public var registers = RegistersZ80()
	public var state = StateZ80()

	// TODO: Vector<100, any Peripheral<UInt8>>
	public var peripherals: [(any Peripheral<UInt8>)?] = .init(repeating: nil, count: 100)

	public var memory: any Memory<UInt16, UInt8> = ConstantMemory(0)
	public var delegate: (any Delegate)?

	public protocol Delegate {
		func register(_ register: RegisterZ80, of processor: ProcessorZ80, read value: inout UInt16)
		func register(_ register: RegisterZ80, of processor: ProcessorZ80, write value: inout UInt16)
		//TODO: Peripherals are basically just Memory<PortZ80, UInt8>?
		func peripheral(_ peripheral: PortZ80, of processor: ProcessorZ80, read value: inout UInt16)
		func peripheral(_ peripheral: PortZ80, of processor: ProcessorZ80, write value: inout UInt16)
	}

}

public struct PortZ80: RawRepresentable, Sendable {
	public let rawValue: UInt8

	@inlinable
	public init(rawValue: UInt8) {
		self.rawValue = rawValue
	}
}

public struct RegisterZ80: RawRepresentable, Sendable {
	public let rawValue: UInt32

	@inlinable
	public init(rawValue: UInt32) {
		self.rawValue = rawValue
	}

	public static let A = Self(rawValue: 0x1)
	public static let F = Self(rawValue: 0x2)
	public static let AF = Self(rawValue: 0x4)
	public static let _AF = Self(rawValue: 0x8)
	public static let B = Self(rawValue: 0x10)
	public static let C = Self(rawValue: 0x20)
	public static let BC = Self(rawValue: 0x40)
	public static let _BC = Self(rawValue: 0x80)

	public static let D = Self(rawValue: 0x0100)
	public static let E = Self(rawValue: 0x0200)
	public static let DE = Self(rawValue: 0x0400)
	public static let _DE = Self(rawValue: 0x0800)
	public static let H = Self(rawValue: 0x1000)
	public static let L = Self(rawValue: 0x2000)
	public static let HL = Self(rawValue: 0x4000)
	public static let _HL = Self(rawValue: 0x8000)

	public static let PC = Self(rawValue: 0x010000)
	public static let SP = Self(rawValue: 0x020000)
	public static let I = Self(rawValue: 0x040000)
	public static let R = Self(rawValue: 0x080000)
	public static let IXH = Self(rawValue: 0x100000)
	public static let IXL = Self(rawValue: 0x200000)
	public static let IX = Self(rawValue: 0x400000)
	public static let IYH = Self(rawValue: 0x800000)

	public static let IYL = Self(rawValue: 0x01000000)
	public static let IY = Self(rawValue: 0x02000000)
}
