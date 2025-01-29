//
//  SimulatorScene.swift
//  Simulator
//
//  Created by Christophe Bronner on 2025-01-26.
//

import SwiftUI

struct SimulatorScene: Scene {
	var body: some Scene {
		WindowGroup("z80e") {
			SimulatorContentView()
		}
	}
}

private struct SimulatorContentView: View {
	@State private var simulator = SimulatorModel()

	var body: some View {
		NavigationSplitView {
			SimulatorSidebar(simulator: simulator)
		} detail: {
			SimulatorDetail(simulator: simulator)
		}
		.environment(\.simulator, simulator)
	}
}
