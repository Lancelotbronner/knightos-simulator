////
////  ProcessorZ80+Execute.swift
////  SimulatorKit
////
////  Created by Christophe Bronner on 2025-01-06.
////
//
//import CoreSimulator
//
//extension ProcessorZ80 {
//	private struct ExecuteContext {
//		var opcode = InstructionZ80()
//		var cycles = 0
//	}
//
//	private func read_byte() -> UInt8 {
//		defer { registers.PC += 1 }
//		return memory[registers.PC]
//	}
//
//	private func read_word() -> UInt16 {
//		var value = UInt16(read_byte())
//		value <<= 8
//		value |= UInt16(read_byte())
//		return value
//	}
//
//	public func execute(cycles: Int) {
//		var context = ExecuteContext()
//
//		while (cycles > 0 || state.prefix != 0) {
//			context.cycles = 0
//			if (state.IFF2 && !state.prefix) {
//				if (state.IFF_wait) {
//					state.IFF_wait = 0
//				} else if (state.interrupt) {
//					state.halted = 0
//					handle_interrupt(&context)
//					break
//				}
//			}
//			if (state.halted) {
//				context.cycles += 4
//				break
//			}
//
//			context.opcode.rawValue = read_byte()
//			var d: Int8
//			var nn, old16, new16, op16: UInt16
//			var old, new, op: UInt8
//			var reset_prefix = true
//
//			let old_r = registers.R
//			registers.R += 1
//			registers.R &= 0x7F
//			registers.R |= old_r & 0x80
//
//			if ((state.prefix & 0xFF) == 0xCB) {
//				let switch_opcode_data = state.prefix >> 8
//				if (switch_opcode_data)
//					context.opcode.rawValue = cpu_read_byte(cpu, registers.PC--)
//
//				switch context.x {
//				case 0: // rot[y] r[z]
//					context.cycles += 4
//					execute_rot(context.y, context.z, switch_opcode_data, &context)
//				case 1: // BIT y, r[z]
//					context.cycles += 4
//					old = read_r(context.z, &context)
//					new = old & (1 << context.y)
//					registers.F = _flag_sign_8(new) | _flag_zero(new)
//					| (context.z == 6 ? _flag_undef_16(registers.WZ) : _flag_undef_8(old))
//					| _flag_parity(new) | __flag_c(registers.flags.C)
//					| FLAG_H
//					break
//				case 2: // RES y, r[z]
//					context.cycles += 4
//					old = read_r(context.z, &context)
//					old &= ~(1 << context.y)
//					if (context.z == 6 && switch_opcode_data) {
//						registers.PC--
//					}
//					write_r(context.z, old, &context)
//					break
//				case 3: // SET y, r[z]
//					context.cycles += 4
//					old = read_r(context.z, &context)
//					old |= 1 << context.y
//					if (context.z == 6 && switch_opcode_data) {
//						registers.PC--
//					}
//					write_r(context.z, old, &context)
//					break
//				}
//
//				if (switch_opcode_data) {
//					registers.PC++
//				}
//			} else if (prefix >> 8 == 0xED) {
//				switch (context.x) {
//				case 1:
//					switch (context.z) {
//					case 0:
//						if (context.y == 6) { // IN (C)
//							context.cycles += 8
//							new = cpu_port_in(cpu, registers.C)
//							registers.F = _flag_sign_8(new) | _flag_undef_8(new)
//							| __flag_c(registers.flags.C) | _flag_zero(new)
//							| _flag_parity(new)
//						} else { // IN r[y], (C)
//							context.cycles += 8
//							new = cpu_port_in(cpu, registers.C)
//							old = read_r(context.y, &context)
//							write_r(context.y, new, &context)
//							registers.F = _flag_sign_8(new) | _flag_undef_8(new)
//							| __flag_c(registers.flags.C) | _flag_zero(new)
//							| _flag_parity(new)
//						}
//						break
//					case 1:
//						if (context.y == 6) { // OUT (C), 0
//											  // This instruction outputs 0 for NMOS z80s, and 0xFF for CMOS z80s.
//											  // TIs are the CMOS variant. Most emulators do *not* emulate this
//											  // correctly, but I have verified through my own research that the
//											  // correct value to output is 0xFF.
//							context.cycles += 8
//							cpu_port_out(cpu, registers.C, 0xFF)
//						} else { // OUT (C), r[y]
//							context.cycles += 8
//							cpu_port_out(cpu, registers.C, read_r(context.y, &context))
//						}
//						break
//					case 2:
//						if (context.q == 0) { // SBC HL, rp[p]
//							context.cycles += 11
//							old16 = registers.HL
//							op16 = read_rp(context.p, &context)
//							registers.WZ = registers.HL -= op16 + registers.flags.C
//							registers.F = _flag_sign_16(registers.HL) | _flag_zero(registers.HL)
//							| _flag_undef_16(registers.HL) | _flag_overflow_16_sub(old16, op16, registers.HL)
//							| _flag_subtract(1) | _flag_carry_16(old16 - op16 - registers.flags.C)
//							| _flag_halfcarry_16_sub(old16, op16, registers.flags.C)
//						} else { // ADC HL, rp[p]
//							context.cycles += 11
//							old16 = registers.HL
//							op16 = read_rp(context.p, &context)
//							registers.WZ = registers.HL += op16 + registers.flags.C
//							registers.F = _flag_sign_16(registers.HL) | _flag_zero(registers.HL)
//							| _flag_undef_16(registers.HL) | _flag_overflow_16_add(old16, op16, registers.HL)
//							| _flag_subtract(0) | _flag_carry_16(old16 + op16 + registers.flags.C)
//							| _flag_halfcarry_16_add(old16, op16, registers.flags.C)
//						}
//						break
//					case 3:
//						if (context.q == 0) { // LD (nn), rp[p]
//							context.cycles += 16
//							registers.WZ = context.nn(&context)
//							cpu_write_word(cpu, registers.WZ, read_rp(context.p, &context))
//						} else { // LD rp[p], (nn)
//							context.cycles += 16
//							registers.WZ = context.nn(&context)
//							write_rp(context.p, cpu_read_word(cpu, registers.WZ), &context)
//						}
//						break
//					case 4: // NEG
//						context.cycles += 4
//						old = registers.A
//						registers.A = -registers.A
//						new = registers.A
//						registers.F = _flag_sign_8(registers.A) | _flag_zero(registers.A)
//						| _flag_undef_8(registers.A) | __flag_pv(old == 0x80)
//						| _flag_subtract(1) | __flag_c(old != 0)
//						| _flag_halfcarry_8_sub(0, old, 0)
//						break
//					case 5:
//						if (context.y == 1) { // RETI
//											  // Note: Does not implement non-maskable interrupts
//							context.cycles += 14
//							registers.PC = pop(cpu)
//							break
//						} else { // RETN
//								 // Note: Does not implement non-maskable interrupts
//							context.cycles += 14
//							registers.PC = pop(cpu)
//							break
//						}
//						break
//					case 6: // IM im[y]
//						context.cycles += 4
//						execute_im(context.y, &context)
//						break
//					case 7:
//						switch (context.y) {
//						case 0: // LD I, A
//							context.cycles += 5
//							registers.I = registers.A
//							break
//						case 1: // LD R, A
//							context.cycles += 5
//							registers.R = registers.A
//							break
//						case 2: // LD A, I
//							context.cycles += 5
//							old = registers.A
//							registers.A = registers.I
//							registers.F = _flag_sign_8(registers.A) | _flag_zero(registers.A)
//							| _flag_undef_8(registers.A) | __flag_pv(IFF2)
//							| _flag_subtract(0) | __flag_c(registers.flags.C)
//							break
//						case 3: // LD A, R
//							context.cycles += 5
//							old = registers.A
//							registers.A = registers.R
//							registers.F = _flag_sign_8(registers.A) | _flag_zero(registers.A)
//							| _flag_undef_8(registers.A) | __flag_pv(IFF2)
//							| _flag_subtract(0) | __flag_c(registers.flags.C)
//							break
//						case 4: // RRD
//							context.cycles += 14
//							old = registers.A
//							new = cpu_read_byte(cpu, registers.HL)
//							registers.A &= 0xF0
//							registers.A |= new & 0x0F
//							new >>= 4
//							new |= old << 4
//							cpu_write_byte(cpu, registers.HL, new)
//							registers.F = __flag_c(registers.flags.C) | _flag_sign_8(registers.A) | _flag_zero(registers.A)
//							| _flag_parity(registers.A) | _flag_undef_8(registers.A)
//							break
//						case 5: // RLD
//							context.cycles += 14
//							old = registers.A
//							new = cpu_read_byte(cpu, registers.HL)
//							registers.A &= 0xF0
//							registers.A |= new >> 4
//							new <<= 4
//							new |= old & 0x0F
//							cpu_write_byte(cpu, registers.HL, new)
//							registers.F = __flag_c(registers.flags.C) | _flag_sign_8(registers.A) | _flag_zero(registers.A)
//							| _flag_parity(registers.A) | _flag_undef_8(registers.A)
//							break
//						default: // NOP (invalid instruction)
//							context.cycles += 4
//							break
//						}
//						break
//					}
//					break
//				case 2:
//					if (context.y >= 4 && context.z < 4) { // bli[y,z]
//						execute_bli(context.y, context.z, &context)
//					} else { // NONI (invalid instruction)
//						context.cycles += 4
//						IFF_wait = 1
//					}
//					break
//				default: // NONI (invalid instruction)
//					context.cycles += 4
//					IFF_wait = 1
//					break
//				}
//			} else {
//				switch (context.x) {
//				case 0:
//					switch (context.z) {
//					case 0:
//						switch (context.y) {
//						case 0: // NOP
//							context.cycles += 4
//							break
//						case 1: // EX AF, AF'
//							context.cycles += 4
//							uint16_t temp = registers._AF
//							registers._AF = registers.AF
//							registers.AF = temp
//							break
//						case 2: // DJNZ d
//							context.cycles += 8
//							d = context.d(&context)
//							registers.B--
//							if (registers.B != 0) {
//								context.cycles += 5
//								registers.WZ = registers.PC += d
//							}
//							break
//						case 3: // JR d
//							context.cycles += 12
//							d = context.d(&context)
//							registers.WZ = registers.PC += d
//							break
//						case 4:
//						case 5:
//						case 6:
//						case 7: // JR cc[y-4], d
//							context.cycles += 7
//							d = context.d(&context)
//							if (read_cc(context.y - 4, &context)) {
//								context.cycles += 5
//								registers.WZ = registers.PC += d
//							}
//							break
//						}
//						break
//					case 1:
//						switch (context.q) {
//						case 0: // LD rp[p], nn
//							context.cycles += 10
//							write_rp(context.p, context.nn(&context), &context)
//							break
//						case 1: // ADD HL, rp[p]
//							context.cycles += 11
//							old16 = HLorIr(&context)
//							op16 = read_rp(context.p, &context)
//							registers.WZ = new16 = HLorIw(&context, old16 + op16)
//							registers.F = __flag_s(registers.flags.S) | _flag_zero(!registers.flags.Z)
//							| _flag_undef_16(new16) | __flag_pv(registers.flags.PV)
//							| _flag_subtract(0) | _flag_carry_16(old16 + op16)
//							| _flag_halfcarry_16_add(old16, op16, 0)
//							break
//						}
//						break
//					case 2:
//						switch (context.q) {
//						case 0:
//							switch (context.p) {
//							case 0: // LD (BC), A
//								context.cycles += 7
//								cpu_write_byte(cpu, registers.BC, registers.A)
//								break
//							case 1: // LD (DE), A
//								context.cycles += 7
//								cpu_write_byte(cpu, registers.DE, registers.A)
//								break
//							case 2: // LD (nn), HL
//								context.cycles += 16
//								registers.WZ = context.nn(&context)
//								cpu_write_word(cpu, registers.WZ, HLorIr(&context))
//								break
//							case 3: // LD (nn), A
//								context.cycles += 13
//								registers.WZ = context.nn(&context)
//								cpu_write_byte(cpu, registers.WZ, registers.A)
//								break
//							}
//							break
//						case 1:
//							switch (context.p) {
//							case 0: // LD A, (BC)
//								context.cycles += 7
//								registers.A = cpu_read_byte(cpu, registers.BC)
//								break
//							case 1: // LD A, (DE)
//								context.cycles += 7
//								registers.A = cpu_read_byte(cpu, registers.DE)
//								break
//							case 2: // LD HL, (nn)
//								context.cycles += 16
//								registers.WZ = context.nn(&context)
//								HLorIw(&context, cpu_read_word(cpu, registers.WZ))
//								break
//							case 3: // LD A, (nn)
//								context.cycles += 13
//								registers.WZ = context.nn(&context)
//								registers.A = cpu_read_byte(cpu, registers.WZ)
//								break
//							}
//							break
//						}
//						break
//					case 3:
//						switch (context.q) {
//						case 0: // INC rp[p]
//							context.cycles += 6
//							write_rp(context.p, read_rp(context.p, &context) + 1, &context)
//							break
//						case 1: // DEC rp[p]
//							context.cycles += 6
//							write_rp(context.p, read_rp(context.p, &context) - 1, &context)
//							break
//						}
//						break
//					case 4: // INC r[y]
//						context.cycles += 4
//						old = read_r(context.y, &context)
//						if (context.y == 6 && prefix >> 8) {
//							registers.PC--
//						}
//
//						new = write_r(context.y, old + 1, &context)
//						registers.F = __flag_c(registers.flags.C) | _flag_sign_8(new) | _flag_zero(new)
//						| _flag_halfcarry_8_add(old, 0, 1) | __flag_pv(old == 0x7F)
//						| _flag_undef_8(new)
//						break
//					case 5: // DEC r[y]
//						context.cycles += 4
//						old = read_r(context.y, &context)
//						if (context.y == 6 && prefix >> 8) {
//							registers.PC--
//						}
//
//						new = write_r(context.y, old - 1, &context)
//						registers.F = __flag_c(registers.flags.C) | _flag_sign_8(new) | _flag_zero(new)
//						| _flag_halfcarry_8_sub(old, 0, 1) | __flag_pv(old == 0x80)
//						| _flag_subtract(1) | _flag_undef_8(new)
//						break
//					case 6: // LD r[y], n
//						context.cycles += 7
//						if (context.y == 6 && prefix >> 8) { // LD (IX/IY + d), n
//							registers.PC++ // Skip the d byte
//						}
//
//						old = context.n(&context)
//
//						if (context.y == 6 && prefix >> 8) {
//							registers.PC -= 2
//						}
//
//						write_r(context.y, old, &context)
//
//						if (context.y == 6 && prefix >> 8) {
//							registers.PC++
//						}
//						break
//					case 7:
//						switch (context.y) {
//						case 0: // RLCA
//							context.cycles += 4
//							old = (registers.A & 0x80) > 0
//							registers.flags.C = old
//							registers.A <<= 1
//							registers.A |= old
//							registers.flags.N = registers.flags.H = 0
//							registers.flags._3 = (registers.A & FLAG_3) > 0
//							registers.flags._5 = (registers.A & FLAG_5) > 0
//							break
//						case 1: // RRCA
//							context.cycles += 4
//							old = (registers.A & 1) > 0
//							registers.flags.C = old
//							registers.A >>= 1
//							registers.A |= old << 7
//							registers.flags.N = registers.flags.H = 0
//							registers.flags._3 = (registers.A & FLAG_3) > 0
//							registers.flags._5 = (registers.A & FLAG_5) > 0
//							break
//						case 2: // RLA
//							context.cycles += 4
//							old = registers.flags.C
//							registers.flags.C = (registers.A & 0x80) > 0
//							registers.A <<= 1
//							registers.A |= old
//							registers.flags.N = registers.flags.H = 0
//							registers.flags._3 = (registers.A & FLAG_3) > 0
//							registers.flags._5 = (registers.A & FLAG_5) > 0
//							break
//						case 3: // RRA
//							context.cycles += 4
//							old = registers.flags.C
//							registers.flags.C = (registers.A & 1) > 0
//							registers.A >>= 1
//							registers.A |= old << 7
//							registers.flags.N = registers.flags.H = 0
//							registers.flags._3 = (registers.A & FLAG_3) > 0
//							registers.flags._5 = (registers.A & FLAG_5) > 0
//							break
//						case 4: // DAA
//							context.cycles += 4
//							old = registers.A
//							daa(&context)
//							break
//						case 5: // CPL
//							context.cycles += 4
//							registers.A = ~registers.A
//							registers.flags.N = registers.flags.H = 1
//							registers.flags._3 = (registers.A & FLAG_3) > 0
//							registers.flags._5 = (registers.A & FLAG_5) > 0
//							break
//						case 6: // SCF
//							context.cycles += 4
//							registers.flags.C = 1
//							registers.flags.N = registers.flags.H = 0
//							registers.flags._3 = (registers.A & FLAG_3) > 0
//							registers.flags._5 = (registers.A & FLAG_5) > 0
//							break
//						case 7: // CCF
//							context.cycles += 4
//							registers.flags.H = registers.flags.C
//							registers.flags.C = !registers.flags.C
//							registers.flags.N = 0
//							registers.flags._3 = (registers.A & FLAG_3) > 0
//							registers.flags._5 = (registers.A & FLAG_5) > 0
//							break
//						}
//						break
//					}
//					break
//				case 1:
//					if (context.z == 6 && context.y == 6) { // HALT
//						context.cycles += 4
//						halted = 1
//					} else { // LD r[y], r[z]
//						context.cycles += 4
//						read_write_r(context.z, context.y, &context)
//					}
//					break
//				case 2: // ALU[y] r[z]
//					execute_alu(context.y, read_r(context.z, &context), &context)
//					break
//				case 3:
//					switch (context.z) {
//					case 0: // RET cc[y]
//						context.cycles += 5
//						if (read_cc(context.y, &context)) {
//							registers.PC = pop(cpu)
//							context.cycles += 6
//						}
//						break
//					case 1:
//						switch (context.q) {
//						case 0: // POP rp2[p]
//							context.cycles += 10
//							write_rp2(context.p, pop(cpu), &context)
//							break
//						case 1:
//							switch (context.p) {
//							case 0: // RET
//								context.cycles += 10
//								registers.PC = pop(cpu)
//								break
//							case 1: // EXX
//								context.cycles += 4
//								uint16_t temp
//								temp = registers._HL registers._HL = registers.HL registers.HL = temp
//								temp = registers._DE registers._DE = registers.DE registers.DE = temp
//								temp = registers._BC registers._BC = registers.BC registers.BC = temp
//								break
//							case 2: // JP HL
//								context.cycles += 4
//								registers.PC = HLorIr(&context)
//								break
//							case 3: // LD SP, HL
//								context.cycles += 6
//								registers.SP = HLorIr(&context)
//								break
//							}
//							break
//						}
//						break
//					case 2: // JP cc[y], nn
//						context.cycles += 10
//						nn = context.nn(&context)
//						if (read_cc(context.y, &context)) {
//							registers.PC = nn
//						}
//						break
//					case 3:
//						switch (context.y) {
//						case 0: // JP nn
//							context.cycles += 10
//							registers.PC = context.nn(&context)
//							break
//						case 1: // 0xCB prefixed opcodes
//							context.cycles += 4
//							prefix &= 0xFF00
//							prefix |= 0x00CB
//							reset_prefix = 0
//							break
//						case 2: // OUT (n), A
//							context.cycles += 11
//							cpu_port_out(cpu, context.n(&context), registers.A)
//							break
//						case 3: // IN A, (n)
//							context.cycles += 11
//							registers.A = cpu_port_in(cpu, context.n(&context))
//							break
//						case 4: // EX (SP), HL
//							context.cycles += 19
//							registers.WZ = cpu_read_word(cpu, registers.SP)
//							cpu_write_word(cpu, registers.SP, HLorIr(&context))
//							HLorIw(&context, registers.WZ)
//							break
//						case 5: // EX DE, HL
//							context.cycles += 4
//							uint16_t temp = registers.HL
//							registers.HL = registers.DE
//							registers.DE = temp
//							break
//						case 6: // DI
//							context.cycles += 4
//							IFF1 = 0
//							IFF2 = 0
//							break
//						case 7: // EI
//							context.cycles += 4
//							IFF1 = 1
//							IFF2 = 1
//							IFF_wait = 1
//							break
//						}
//						break
//					case 4: // CALL cc[y], nn
//						context.cycles += 10
//						nn = context.nn(&context)
//						if (read_cc(context.y, &context)) {
//							context.cycles += 7
//							push(cpu, registers.PC)
//							registers.PC = nn
//						}
//						break
//					case 5:
//						switch (context.q) {
//						case 0: // PUSH r2p[p]
//							context.cycles += 11
//							push(cpu, read_rp2(context.p, &context))
//							break
//						case 1:
//							switch (context.p) {
//							case 0: // CALL nn
//								context.cycles += 17
//								nn = context.nn(&context)
//								push(cpu, registers.PC)
//								registers.PC = nn
//								break
//							case 1: // 0xDD prefixed opcodes
//								context.cycles += 4
//								prefix &= 0xFF
//								prefix |= 0xDD00
//								reset_prefix = 0
//								break
//							case 2: // 0xED prefixed opcodes
//								context.cycles += 4
//								prefix &= 0xFF
//								prefix |= 0xED00
//								reset_prefix = 0
//								break
//							case 3: // 0xFD prefixed opcodes
//								context.cycles += 4
//								prefix &= 0xFF
//								prefix |= 0xFD00
//								reset_prefix = 0
//								break
//							}
//							break
//						}
//						break
//					case 6: // alu[y] n
//						execute_alu(context.y, context.n(&context), &context)
//						break
//					case 7: // RST y*8
//						context.cycles += 11
//						push(context.cpu, registers.PC)
//						registers.PC = context.y * 8
//						break
//					}
//					break
//				}
//			}
//
//			if (reset_prefix) {
//				prefix = 0
//			}
//
//		exit_loop:
//			cycles -= context.cycles
//			if (context.cycles == 0) {
//				z80e_error("cpu", "Error: Unrecognized instruction 0x%02X.", context.opcode)
//				cycles--
//			}
//		}
//		return cycles
//	}
//}
