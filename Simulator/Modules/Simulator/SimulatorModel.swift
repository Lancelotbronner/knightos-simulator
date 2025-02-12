//
//  SimulatorModel.swift
//  Simulator
//
//  Created by Christophe Bronner on 2025-01-26.
//

import SwiftUI
@preconcurrency import libz80e

@Observable @MainActor
public final class SimulatorModel {

	init() {
		_asic = .init()
	}

	public init(_ model: ti_device_type) {
		_asic = .init()
		// FIXME: concurrency errors with logging?
		asic_init(&_asic, model)
	}

	deinit {
		asic_deinit(&_asic)
	}

	var asic: asic

	@ObservationIgnored
	var __asic: asic {
		get { _asic }
		_modify { yield &_asic }
	}

	public func tick(_ cycles: Int) {
		asic_tick_cycles(&asic, Int32(truncatingIfNeeded: cycles))
	}
}

@Observable
final class SimulatorSceneModel {
	var route = SimulatorRoute.simulator
	var memoryPage = 0
	var storagePage = 0
	var flashPage = 0
	var flashAddress: Int?
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
	@Entry var simulatorScene = SimulatorSceneModel()
}
