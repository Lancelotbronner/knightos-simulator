//
//  eZ80.swift
//  z80e
//
//  Created by Christophe Bronner on 2024-03-18.
//

public protocol eZ80: AnyObject {

	var a1: UInt8 { get set }
	var f1: StatusFlags { get set }
	var bc1: UInt32 { get set }
	var de1: UInt32 { get set }
	var hl1: UInt32 { get set }

	var a2: UInt8 { get set }
	var f2: StatusFlags { get set }
	var bc2: UInt32 { get set }
	var de2: UInt32 { get set }
	var hl2: UInt32 { get set }

	var ix: UInt32 { get set }
	var iy: UInt32 { get set }

	var i: UInt16 { get set }
	var mbase: UInt8 { get set }
	var r: UInt8 { get set }

	var pc: UInt32 { get set }
	var sp: UInt32 { get set }

	var control: ControlFlags { get set }

}

extension eZ80 {

	//MARK: - Derived Registers

	public var b1: UInt8 {
		get { bc1.bytes[0] }
		set { bc1.bytes[0] = newValue }
	}

	public var c1: UInt8 {
		get { bc1.bytes[1] }
		set { bc1.bytes[1] = newValue }
	}

	public var bcu1: UInt8 {
		get { bc1.bytes[2] }
		set { bc1.bytes[2] = newValue }
	}

	public var d1: UInt8 {
		get { de1.bytes[0] }
		set { de1.bytes[0] = newValue }
	}

	public var e1: UInt8 {
		get { de1.bytes[1] }
		set { de1.bytes[1] = newValue }
	}

	public var deu1: UInt8 {
		get { de1.bytes[2] }
		set { de1.bytes[2] = newValue }
	}

	public var h1: UInt8 {
		get { hl1.bytes[0] }
		set { hl1.bytes[0] = newValue }
	}

	public var l1: UInt8 {
		get { hl1.bytes[1] }
		set { hl1.bytes[1] = newValue }
	}

	public var hlu1: UInt8 {
		get { hl1.bytes[2] }
		set { hl1.bytes[2] = newValue }
	}

	public var b2: UInt8 {
		get { bc2.bytes[0] }
		set { bc2.bytes[0] = newValue }
	}

	public var c2: UInt8 {
		get { bc2.bytes[1] }
		set { bc2.bytes[1] = newValue }
	}

	public var bcu2: UInt8 {
		get { bc2.bytes[2] }
		set { bc2.bytes[2] = newValue }
	}

	public var d2: UInt8 {
		get { de2.bytes[0] }
		set { de2.bytes[0] = newValue }
	}

	public var e2: UInt8 {
		get { de2.bytes[1] }
		set { de2.bytes[1] = newValue}
	}

	public var deu2: UInt8 {
		get { de2.bytes[2] }
		set { de2.bytes[2] = newValue }
	}

	public var h2: UInt8 {
		get { hl2.bytes[0] }
		set { hl2.bytes[0] = newValue }
	}

	public var l2: UInt8 {
		get { hl2.bytes[1] }
		set { hl2.bytes[1] = newValue }
	}

	public var hlu2: UInt8 {
		get { hl2.bytes[2] }
		set { hl2.bytes[2] = newValue }
	}

	var ixl: UInt8 {
		get { ix.bytes[0] }
		set { ix.bytes[0] = newValue }
	}

	var ixh: UInt8 {
		get { ix.bytes[1] }
		set { ix.bytes[1] = newValue }
	}

	public var ixu: UInt8 {
		get { ix.bytes[2] }
		set { ix.bytes[2] = newValue }
	}

	var iyl: UInt8 {
		get { iy.bytes[0] }
		set { iy.bytes[0] = newValue }
	}

	var iyh: UInt8 {
		get { iy.bytes[1] }
		set { iy.bytes[1] = newValue }
	}

	public var iyu: UInt8 {
		get { iy.bytes[2] }
		set { iy.bytes[2] = newValue }
	}

	//MARK: - Reset

	public func reset() {
		ix = 0
		iy = 0

		i = 0
		mbase = 0
		r = 0

		pc = 0
		sp = 0

		control = []
	}

	//MARK: - Exchange Instructions

	public func ex() {

	}

	public func exx() {

	}

}
