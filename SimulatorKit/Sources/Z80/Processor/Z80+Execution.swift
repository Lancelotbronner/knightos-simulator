//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2024-04-11.
//

extension ProcessorZ80 {

	@inlinable
	public func tcycle() {
		// Execute a single T-cycle
	}

	@inlinable
	public func mcycle() {
		// Complete current M-cycle if tcycles
	}

	@inlinable
	public func execute(_ instruction: Instruction) {
		let prefix = instruction.prefix
		let opcode = instruction.opcode(prefix: prefix)
		switch prefix {
		case 0: _i0(opcode)
		case 0xCB: _iCB(opcode)
		case 0xED: _iED(opcode)
		case 0xDD: _iDD(opcode)
		case 0xFD: _iFD(opcode)
		case 0xDDCB: _iDDCB(opcode)
		case 0xFDCB: _iFDCB(opcode)
		default: preconditionFailure("Invalid prefix \(prefix)")
		}
	}

	@usableFromInline
	func _i0(_ opcode: Instruction.OpcodeView) {

	}

	@usableFromInline
	func _iCB(_ opcode: Instruction.OpcodeView) {

	}

	@usableFromInline
	func _iED(_ opcode: Instruction.OpcodeView) {

	}

	@usableFromInline
	func _iDD(_ opcode: Instruction.OpcodeView) {

	}

	@usableFromInline
	func _iFD(_ opcode: Instruction.OpcodeView) {

	}

	@usableFromInline
	func _iDDCB(_ opcode: Instruction.OpcodeView) {

	}

	@usableFromInline
	func _iFDCB(_ opcode: Instruction.OpcodeView) {

	}

}
