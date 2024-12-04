//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2024-04-11.
//

import EmulationKit

public struct Instruction: RawRepresentable {
	public var rawValue: UInt32

	@inlinable
	public init(rawValue: UInt32) {
		self.rawValue = rawValue
	}

	@inlinable
	public init(opcode: OpcodeView) {
		rawValue = 0
		rawValue.bytes[0] = opcode.rawValue
	}

	@inlinable
	public init(prefix: UInt8, opcode: OpcodeView) {
		rawValue = 0
		rawValue.bytes[0] = prefix
		rawValue.bytes[1] = opcode.rawValue
	}

	@inlinable
	public init(prefix p1: UInt8, _ p2: UInt8, opcode: OpcodeView) {
		rawValue = 0
		rawValue.bytes[0] = p1
		rawValue.bytes[1] = p2
		rawValue.bytes[2] = opcode.rawValue
	}
}
