//
//  CalculatorTi73.swift
//  Simulator
//
//  Created by Christophe Bronner on 2024-09-09.
//

import SwiftUI
import libz80e

@Observable
public final class CalculatorTi73 {

	public init() {
		_asic = .init()
		asic_init(&_asic, TI73)
	}

	var asic: asic

	var __asic: asic {
		get { _asic }
		_modify { yield &_asic }
	}

	public func tick(_ cycles: Int) {
		asic_tick_cycles(&asic, Int32(truncatingIfNeeded: cycles))
	}

	func update() {
		withMutation(keyPath: \.asic) { }
	}

	func access<Result>(_ transform: () -> Result) -> Result {
		access(keyPath: \.asic)
		return transform()
	}
}

extension CalculatorTi73: Calculator {
	static var displayView: some View {
		Text("Ti-73")
	}

	static var keyboardView: some View {
		Grid {
			GridRow {
				AsicButton(key: K_FUNCTIONS)
			}
		}
	}
}
