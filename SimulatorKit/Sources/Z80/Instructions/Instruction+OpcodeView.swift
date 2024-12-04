//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2024-05-12.
//

import EmulationKit

extension Instruction {
	public struct OpcodeView: RawRepresentable {
		public var rawValue: UInt8

		@inlinable
		public init(rawValue: UInt8) {
			self.rawValue = rawValue
		}

		@inlinable
		public init(x: UInt8, z: UInt8, y: UInt8) {
			self.init(rawValue: (x &<< 6) | z | (y &<< 3))
		}

		@inlinable
		public init(x: UInt8, z: UInt8, q: UInt8, p: UInt8) {
			self.init(x: x, z: z, y: q | (p &<< 1))
		}
	}

	@inlinable
	var prefix: UInt16 {
		let byte0: UInt16 = rawValue.bytes[0]
		return switch byte0 {
		case 0xDD, 0xFD: rawValue.bytes[1] == 0xCB ? (0xCB00 | byte0) : byte0
		case 0xCB, 0xED: byte0
		default: 0
		}
	}

	@usableFromInline
	func _opcode(prefix: UInt16) -> UInt8 {
		switch prefix {
		case 0xDD, 0xFD, 0xCB, 0xED: rawValue.bytes[1]
		case 0xDDCB, 0xFDCB: rawValue.bytes[2]
		default: rawValue.bytes[0]
		}
	}

	@usableFromInline
	var _opcode: UInt8 {
		let byte0 = rawValue.bytes[0]
		switch byte0 {
		case 0xDD, 0xFD:
			let byte1 = rawValue.bytes[1]
			return byte1 == 0xCB ? rawValue.bytes[2] : byte1
		case 0xCB, 0xED: 
			return rawValue.bytes[1]
		default: 
			return byte0
		}
	}

	@inlinable
	public var opcode: OpcodeView {
		OpcodeView(rawValue: _opcode)
	}

	@inlinable
	public func opcode(prefix: UInt16) -> OpcodeView {
		OpcodeView(rawValue: _opcode(prefix: prefix))
	}
}

extension Instruction.OpcodeView {
	// http://www.z80.info/decoding.htm

	@inlinable
	public var x: UInt8 {
		rawValue.bits[6...7]
	}

	@inlinable
	public var y: UInt8 {
		rawValue.bits[3...5]
	}

	@inlinable
	public var z: UInt8 {
		rawValue.bits[0...2]
	}

	@inlinable
	public var p: UInt8 {
		rawValue.bits[4...5]
	}

	@inlinable
	public var q: Bool {
		rawValue.bits[3]
	}

}
