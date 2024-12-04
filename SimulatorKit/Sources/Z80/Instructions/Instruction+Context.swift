//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2024-04-11.
//

extension Instruction {
	public struct ExecutionContext {

		@usableFromInline
		var _prefix: UInt16

		@usableFromInline
		var _opcode: Instruction.OpcodeView

		public var instruction: Instruction {
			didSet {
				_prefix = instruction.prefix
				_opcode = instruction.opcode(prefix: _prefix)
			}
		}

		/// The total number of clock periods executed during this instruction
		public var cycles = 0

		/// The number of clock periods executed so far
		public var tcycles = 0

		/// The number of machine cycles executed so far
		public var mcycles = 0

		@usableFromInline
		init(instruction: Instruction) {
			self.instruction = instruction
			let prefix = instruction.prefix
			_prefix = prefix
			_opcode = instruction.opcode(prefix: prefix)
		}
	}
}
