//
//  CalculatorView.swift
//  Simulator
//
//  Created by Christophe Bronner on 2024-09-09.
//

import SwiftUI

struct CalculatorView<Model: Calculator>: View {
	var body: some View {
		VStack {
			Model.displayView
			Model.keyboardView
		}
	}
}
