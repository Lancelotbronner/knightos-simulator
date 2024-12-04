//
//  DebuggerTi73.swift
//  Simulator
//
//  Created by Christophe Bronner on 2024-11-10.
//

import SwiftUI
import libz80e

struct DebuggerTi73: View {
	@Environment(CalculatorTi73.self) private var calculator
	@State private var write = UInt8.zero

	var body: some View {
		var keyboard_device = device()
		let _ = port_keyboard(&keyboard_device, &calculator.__asic.keyboard)
		Form {
			Section("Keyboard") {
				LabeledContent("Keys", value: String(calculator.asic.keyboard.keys, radix: 2))
				LabeledContent("Mask", value: String(calculator.asic.keyboard.mask, radix: 2))
				LabeledContent("READ", value: calculator.access { device_read(&keyboard_device) }, format: .number)
				TextField("WRITE", value: $write, format: .number)
					.onSubmit {
						device_write(&keyboard_device, write)
						write = 0
						calculator.update()
					}
			}
		}
	}
}
