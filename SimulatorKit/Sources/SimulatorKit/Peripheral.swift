//
//  Peripheral.swift
//  SimulatorKit
//
//  Created by Christophe Bronner on 2025-01-05.
//

public protocol Peripheral<Value> {
	associatedtype Value: FixedWidthInteger

	/// Communicates with the peripheral.
	var value: Value { get set }

	/// Name of the peripheral as described to the user.
	var name: String? { get }

	/// Short description of the peripheral as described to the user.
	var summary: String? { get }

	/// Status of the peripheral.
	var status: String? { get }
}

public extension Peripheral {
	var name: String? { nil }
	var summary: String? { nil }
	var status: String? { nil }
}
