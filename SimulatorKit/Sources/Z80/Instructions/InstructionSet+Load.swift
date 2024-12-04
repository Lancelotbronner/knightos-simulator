//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2024-04-11.
//

extension Instruction {

	/// `EX AF, AF'`
	@inlinable
	public static func exchangeAF() -> Instruction {
		Instruction(opcode: OpcodeView(x: 0, z: 0, y: 1))
	}

	/// `DJNZ d`
	@inlinable
	public static func djnz(d: Int8) -> Instruction {
		Instruction(opcode: OpcodeView(x: 0, z: 0, y: 2))
	}

	//MARK: - Load Instructions

//	/// The contents of source are copied to destination.
//	@inlinable
//	public static func load(_ destination: R, from source: R) -> Instruction {
//		Instruction(rawValue: 0x40, destination.rawValue &<< 3, source.rawValue)
//	}
//
//	/// The contents of source are copied to destination.
//	@inlinable
//	public static func load(_ destination: R, from source: UInt8) -> Instruction {
//		var rawValue = 0x40
//		Instruction(rawValue: 0x40, destination.rawValue &<< 3, 0b110)
//	}

}
