//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2024-04-11.
//

extension Instruction {
	public enum R: UInt8 {
		case b, c, d, e, h, l, hl, a
	}

	public enum RP1: UInt8 {
		case bc, de, hl, sp
	}

	public enum RP2: UInt8 {
		case bc, de, hl, af
	}

	public enum CC: UInt8 {
		case nz, z, nc, c, po, pe, p, m
	}

	public enum ALU: UInt8 {
		case add, adc, sub, sbc, and, xor, or, cp
	}

	public enum ROT: UInt8 {
		case rlc, rrc, rl, rr, sla, sra, sll, srl
	}

	public enum IM: UInt8 {
		case i0, i01, i1, i2
	}

	public enum BLI: UInt8 {
		case i0, i01, i1, i2
	}
}
