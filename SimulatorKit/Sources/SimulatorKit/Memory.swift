//
//  Memory.swift
//  SimulatorKit
//
//  Created by Christophe Bronner on 2025-01-05.
//

public protocol Memory<Address, Value> {
	associatedtype Address: FixedWidthInteger
	associatedtype Value: FixedWidthInteger

	subscript(_ address: Address) -> Value { get set }

	//TODO: Debug/describe memory address
	//TODO: Request a span of addresses and get an iterator of spans in return?
}

public struct ConstantMemory<Address: FixedWidthInteger, Value: FixedWidthInteger>: Memory {
	public let value: Value

	public init(_ value: Value) {
		self.value = value
	}

	public subscript(address: Address) -> Value {
		get { value }
		set { }
	}
}
