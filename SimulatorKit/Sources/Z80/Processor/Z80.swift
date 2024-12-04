//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2024-05-13.
//

import EmulationKit

public struct ProcessorZ80 {

	public var control: ControlPins = []

	public var r1: UInt64 = 0
	public var r2: UInt64 = 0

	public var ix: UInt16 = 0
	public var iy: UInt16 = 0
	public var ir: UInt16 = 0

	public var pc: UInt16 = 0
	public var sp: UInt16 = 0

	public var status: StatusFlags = []

	public var data: UInt8 = 0
	public var address: UInt16 = 0

	public var devices: [any Device] = []

	/// Provides a device at the specified port
	@inlinable
	public func device(at port: UInt8) -> AnyDevice {
		AnyDevice(devices[Int(port)])
	}
}

extension ProcessorZ80 {

	//MARK: - Derived Registers

	@inlinable
	public var af1: UInt16 {
		get { r1.uint16[0] }
		set { r1.uint16[0] = newValue }
	}

	@inlinable
	public var a1: UInt8 {
		get { r1.bytes[0] }
		set { r1.bytes[0] = newValue }
	}

	@inlinable
	public var f1: StatusFlags {
		get { StatusFlags(rawValue: r1.bytes[1]) }
		set { r1.bytes[1] = newValue.rawValue }
	}

	@inlinable
	public var bc1: UInt16 {
		get { r1.uint16[1] }
		set { r1.uint16[1] = newValue }
	}

	@inlinable
	public var b1: UInt8 {
		get { r1.bytes[2] }
		set { r1.bytes[2] = newValue }
	}

	@inlinable
	public var c1: UInt8 {
		get { r1.bytes[3] }
		set { r1.bytes[3] = newValue }
	}

	@inlinable
	public var de1: UInt16 {
		get { r1.uint16[2] }
		set { r1.uint16[2] = newValue }
	}

	@inlinable
	public var d1: UInt8 {
		get { r1.bytes[4] }
		set { r1.bytes[4] = newValue }
	}

	@inlinable
	public var e1: UInt8 {
		get { r1.bytes[5] }
		set { r1.bytes[5] = newValue }
	}

	@inlinable
	public var hl1: UInt16 {
		get { r1.uint16[3] }
		set { r1.uint16[3] = newValue }
	}

	@inlinable
	public var h1: UInt8 {
		get { r1.bytes[6] }
		set { r1.bytes[6] = newValue }
	}

	@inlinable
	public var l1: UInt8 {
		get { r1.bytes[7] }
		set { r1.bytes[7] = newValue }
	}

	@inlinable
	public var af2: UInt16 {
		get { r2.uint16[0] }
		set { r2.uint16[0] = newValue }
	}

	@inlinable
	public var a2: UInt8 {
		get { r2.bytes[0] }
		set { r2.bytes[0] = newValue }
	}

	@inlinable
	public var f2: StatusFlags {
		get { StatusFlags(rawValue: r2.bytes[1]) }
		set { r2.bytes[1] = newValue.rawValue }
	}

	@inlinable
	public var bc2: UInt16 {
		get { r2.uint16[1] }
		set { r2.uint16[1] = newValue }
	}

	@inlinable
	public var b2: UInt8 {
		get { r2.bytes[2] }
		set { r2.bytes[2] = newValue }
	}

	@inlinable
	public var c2: UInt8 {
		get { r2.bytes[3] }
		set { r2.bytes[3] = newValue }
	}

	@inlinable
	public var de2: UInt16 {
		get { r2.uint16[2] }
		set { r2.uint16[2] = newValue }
	}

	@inlinable
	public var d2: UInt8 {
		get { r2.bytes[4] }
		set { r2.bytes[4] = newValue }
	}

	@inlinable
	public var e2: UInt8 {
		get { r2.bytes[5] }
		set { r2.bytes[5] = newValue}
	}

	@inlinable
	public var hl2: UInt16 {
		get { r2.uint16[3] }
		set { r2.uint16[3] = newValue }
	}

	@inlinable
	public var h2: UInt8 {
		get { r2.bytes[6] }
		set { r2.bytes[6] = newValue }
	}

	@inlinable
	public var l2: UInt8 {
		get { r2.bytes[7] }
		set { r2.bytes[7] = newValue }
	}

	@inlinable
	public var ixl: UInt8 {
		get { ix.bytes[0] }
		set { ix.bytes[0] = newValue }
	}

	@inlinable
	public var ixh: UInt8 {
		get { ix.bytes[1] }
		set { ix.bytes[1] = newValue }
	}

	@inlinable
	public var iyl: UInt8 {
		get { iy.bytes[0] }
		set { iy.bytes[0] = newValue }
	}

	@inlinable
	public var iyh: UInt8 {
		get { iy.bytes[1] }
		set { iy.bytes[1] = newValue }
	}

	@inlinable
	public var i: UInt8 {
		get { ir.bytes[0] }
		set { ir.bytes[0] = newValue }
	}

	@inlinable
	public var r: UInt8 {
		get { ir.bytes[1] }
		set { ir.bytes[1] = newValue }
	}

	//MARK: - Power Management

	@inlinable
	public mutating func reset() {
		ix = 0
		iy = 0
		ir = 0
		pc = 0
		sp = 0
		control = []
	}

}
