//
//  Calculator.swift
//  Simulator
//
//  Created by Christophe Bronner on 2024-09-09.
//

import SwiftUI

//TI73 = 0,
//TI83p = 1,
//TI83pSE = 2,
//TI84p = 3,
//TI84pSE = 4,
//TI84pCSE = 5

protocol Calculator: AnyObject, Observable {

	/// Commands going into the Device menu.
	associatedtype DeviceCommands: Commands

	/// Displays the calculators' screen.
	associatedtype DisplayView: View

	/// Displays the calculators' keyboard
	associatedtype KeyboardView: View

	init()

	@MainActor @CommandsBuilder
	static var commands: DeviceCommands { get }

	@MainActor @ViewBuilder
	static var displayView: DisplayView { get }

	@MainActor @ViewBuilder
	static var keyboardView: KeyboardView { get }

}

extension Calculator where DeviceCommands == EmptyCommands {
	static var commands: DeviceCommands { EmptyCommands() }
}
