//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2024-04-11.
//

public protocol Device: AnyObject {
	var port: UInt8 { get set }
}

public struct AnyDevice {
	@usableFromInline let _device: any Device

	@inlinable
	public var port: UInt8 {
		get { _device.port }
		set { _device.port = newValue }
	}

	@inlinable
	public init(_ device: any Device) {
		_device = device
	}

	//TODO: Device registry for decodable
}
