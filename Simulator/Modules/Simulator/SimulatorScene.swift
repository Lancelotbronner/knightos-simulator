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
