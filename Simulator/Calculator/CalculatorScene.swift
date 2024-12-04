//
//  CalculatorScene.swift
//  Simulator
//
//  Created by Christophe Bronner on 2024-11-10.
//

import SwiftUI

struct CalculatorScene<Model: Calculator>: Scene {
	@State private var model = Model()

	var body: some Scene {
		WindowGroup {
			HStack {
				CalculatorView<Model>()
				DebuggerTi73()
			}
			.environment(model)
		}
		.commands {
			Model.commands
		}
	}
}
