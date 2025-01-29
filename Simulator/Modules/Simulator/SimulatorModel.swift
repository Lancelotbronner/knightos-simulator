//
//  SimulatorModel.swift
//  Simulator
//
//  Created by Christophe Bronner on 2025-01-26.
//

import SwiftUI
import libz80e

@Observable
public final class SimulatorModel {

	public init() {
		_asic = .init()
		asic_init(&_asic, TI73)
	}

	var route = SimulatorRoute.simulator
	var asic: asic

	var __asic: asic {
		get { _asic }
		_modify { yield &_asic }
	}

	public func tick(_ cycles: Int) {
		asic_tick_cycles(&__asic, Int32(truncatingIfNeeded: cycles))
	}
}

enum SimulatorRoute: Hashable {
	case simulator

	case cpu
	case mmu

	case memory
	case flash
	case ram

	case peripherals
	case keyboard
}

extension EnvironmentValues {
	@Entry var simulator = SimulatorModel()
}
