//
//  SimulatorDetail.swift
//  Simulator
//
//  Created by Christophe Bronner on 2025-01-26.
//

import SwiftUI

struct SimulatorDetail: View {
	let simulator: SimulatorModel

	var body: some View {
		switch simulator.route {
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
