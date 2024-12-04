//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2024-03-18.
//

public struct Instruction: RawRepresentable {
	public var rawValue: UInt16

	public init(rawValue: UInt16) {
		self.rawValue = rawValue
	}
}
