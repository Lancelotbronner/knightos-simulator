//
//  AsicButton.swift
//  Simulator
//
//  Created by Christophe Bronner on 2024-11-10.
//

import SwiftUI
import libz80e

struct AsicButton: View {
	@Environment(CalculatorTi73.self) private var calculator
	let key: libz80e.key

	var body: some View {
		// ?
		Text("key")
	}
}
