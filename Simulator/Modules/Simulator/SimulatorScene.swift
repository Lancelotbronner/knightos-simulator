//
//  SimulatorScene.swift
//  Simulator
//
//  Created by Christophe Bronner on 2025-01-26.
//

import SwiftUI
import libz80e

struct SimulatorScene: Scene {
	var body: some Scene {
		WindowGroup("z80e") {
			SimulatorContentView()
		}
	}
}

private struct SimulatorContentView: View {
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
		case .memory: Text("Memory Pages")
		case .flash: FlashContent()
		case .ram: Text("RAM Pages")
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
