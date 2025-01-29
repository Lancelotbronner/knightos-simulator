//
//  SimulatorSidebar.swift
//  Simulator
//
//  Created by Christophe Bronner on 2025-01-26.
//

import SwiftUI

struct SimulatorSidebar: View {
	let simulator: SimulatorModel

	var body: some View {
		@Bindable var simulator = simulator
		List(selection: $simulator.route) {
			NavigationLink("Simulator", value: SimulatorRoute.simulator)
			Section("Components") {
				NavigationLink("CPU", value: SimulatorRoute.cpu)
				NavigationLink("MMU", value: SimulatorRoute.mmu)
			}
			Section("Memory") {
				NavigationLink("Memory", value: SimulatorRoute.memory)
				NavigationLink("Flash", value: SimulatorRoute.flash)
				NavigationLink("RAM", value: SimulatorRoute.ram)
			}
			Section("Peripherals") {
				NavigationLink("Peripherals", value: SimulatorRoute.peripherals)
				NavigationLink("Keyboard", value: SimulatorRoute.keyboard)
			}
		}
	}
}
