//
//  SimulatorContentView.swift
//  Simulator
//
//  Created by Christophe Bronner on 2025-02-12.
//

import SwiftUI
import libz80e

struct SimulatorContentView: View {
	@State private var scene = SimulatorSceneModel()
	@State private var simulator = SimulatorModel(TI73)

	var body: some View {
		NavigationSplitView {
			SimulatorSidebar()
		} content: {
			SimulatorContent()
		} detail: {
			SimulatorDetail()
		}
		.environment(simulator)
		.environment(\.simulatorScene, scene)
	}
}

private struct SimulatorContent: View {
	@Environment(\.simulatorScene) private var scene

	var body: some View {
		switch scene.route {
		case .simulator: Text("Simulator")
		case .cpu: Text("CPU")
		case .mmu: Text("MMU")
		case .memory: MemoryContent()
		case .flash: FlashContent()
		case .ram: StorageContent()
		case .peripherals: Text("Peripherals")
		case .keyboard: Text("Keyboard")
		}
	}
}

private struct SimulatorDetail: View {
	@Environment(\.simulatorScene) private var scene

	var body: some View {
		switch scene.route {
		case .simulator: Text("Simulator")
		case .cpu: Text("CPU")
		case .mmu: Text("MMU")
		case .memory: MemoryView()
		case .flash: FlashView()
		case .ram: StorageView()
		case .peripherals: Text("Peripherals")
		case .keyboard: Text("Keyboard")
		}
	}
}

