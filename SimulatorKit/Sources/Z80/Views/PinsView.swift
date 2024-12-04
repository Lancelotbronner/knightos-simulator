////
////  File.swift
////  
////
////  Created by Christophe Bronner on 2024-03-18.
////
//
//#if canImport(SwiftUI)
//import SwiftUI
//
//@available(macOS 14, *)
//public struct PinsView: View {
//	@Environment(ObservableZ80.self) private var z80: ObservableZ80
//
//	public init() { }
//
//	public var body: some View {
//		@Bindable var z80 = z80
//		HStack(alignment: .top) {
//			VStack(alignment: .trailing) {
//				Toggle("D0", isOn: $z80.data.bits[0])
//				Toggle("D1", isOn: $z80.data.bits[1])
//				Toggle("D2", isOn: $z80.data.bits[2])
//				Toggle("D3", isOn: $z80.data.bits[3])
//				Toggle("D4", isOn: $z80.data.bits[4])
//				Toggle("D5", isOn: $z80.data.bits[5])
//				Toggle("D6", isOn: $z80.data.bits[6])
//				Toggle("D7", isOn: $z80.data.bits[7])
//				Toggle("M1", isOn: $z80.control[.m1])
//				Toggle("MREQ", isOn: $z80.control[.mreq])
//				Toggle("IORQ", isOn: $z80.control[.iorq])
//				Toggle("RD", isOn: $z80.control[.read])
//				Toggle("WR", isOn: $z80.control[.wr])
//				Toggle("RFSH", isOn: $z80.control[.rfsh])
//				Toggle("HALT", isOn: $z80.control[.halt])
//				Toggle("INT", isOn: $z80.control[.int])
//				Toggle("NMI", isOn: $z80.control[.nmi])
//				Toggle("WAIT", isOn: $z80.control[.wait])
//			}
//			Rectangle()
//				.stroke()
//				.overlay {
//					Text("Z80 CPU")
//				}
//			VStack(alignment: .leading) {
//				Toggle("A0", isOn: $z80.address.bits[0])
//				Toggle("A1", isOn: $z80.address.bits[1])
//				Toggle("A2", isOn: $z80.address.bits[2])
//				Toggle("A3", isOn: $z80.address.bits[3])
//				Toggle("A4", isOn: $z80.address.bits[4])
//				Toggle("A5", isOn: $z80.address.bits[5])
//				Toggle("A6", isOn: $z80.address.bits[6])
//				Toggle("A7", isOn: $z80.address.bits[7])
//				Toggle("A8", isOn: $z80.address.bits[8])
//				Toggle("A9", isOn: $z80.address.bits[9])
//				Toggle("A10", isOn: $z80.address.bits[10])
//				Toggle("A11", isOn: $z80.address.bits[11])
//				Toggle("A12", isOn: $z80.address.bits[12])
//				Toggle("A13", isOn: $z80.address.bits[13])
//				Toggle("A14", isOn: $z80.address.bits[14])
//				Toggle("A15", isOn: $z80.address.bits[15])
//			}
//		}
//	}
//}
//
//@available(macOS 14, *)
//#Preview {
//	let z80 = ObservableZ80()
//	return PinsView()
//		.environment(z80)
//}
//#endif
