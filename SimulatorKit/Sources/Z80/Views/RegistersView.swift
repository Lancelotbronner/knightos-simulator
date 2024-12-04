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
//public struct RegistersView: View {
//	@Environment(ObservableZ80.self) private var z80: ObservableZ80
//
//	public init() { }
//
//	public var body: some View {
//		VStack {
//			Grid {
//				GridRow {
//					Text("AF")
//						.foregroundStyle(.secondary)
//					Text(String(z80.af1, radix: 16, uppercase: true))
//					Text("AF'")
//						.foregroundStyle(.secondary)
//					Text(String(z80.af2, radix: 16, uppercase: true))
//				}
//				GridRow {
//					Text("BC")
//						.foregroundStyle(.secondary)
//					Text(String(z80.bc1, radix: 16, uppercase: true))
//					Text("BC'")
//						.foregroundStyle(.secondary)
//					Text(String(z80.bc2, radix: 16, uppercase: true))
//				}
//				GridRow {
//					Text("DE")
//						.foregroundStyle(.secondary)
//					Text(String(z80.de1, radix: 16, uppercase: true))
//					Text("DE'")
//						.foregroundStyle(.secondary)
//					Text(String(z80.de2, radix: 16, uppercase: true))
//				}
//				GridRow {
//					Text("HL")
//						.foregroundStyle(.secondary)
//					Text(String(z80.hl1, radix: 16, uppercase: true))
//					Text("HL'")
//						.foregroundStyle(.secondary)
//					Text(String(z80.hl2, radix: 16, uppercase: true))
//				}
//				Divider()
//				GridRow {
//					Text("IX")
//						.foregroundStyle(.secondary)
//					Text(String(z80.ix, radix: 16, uppercase: true))
//					Text("IY")
//						.foregroundStyle(.secondary)
//					Text(String(z80.iy, radix: 16, uppercase: true))
//				}
//				GridRow {
//					Text("PC")
//						.foregroundStyle(.secondary)
//					Text(String(z80.pc, radix: 16, uppercase: true))
//					Text("SP")
//						.foregroundStyle(.secondary)
//					Text(String(z80.sp, radix: 16, uppercase: true))
//				}
//				GridRow {
//					Text("IR")
//						.foregroundStyle(.secondary)
//					Text(String(z80.ir, radix: 16, uppercase: true))
//					Text("WZ")
//						.foregroundStyle(.secondary)
//					Text("????")
//				}
//				GridRow {
//					Text("IR")
//						.foregroundStyle(.secondary)
//					Text(String(z80.ir, radix: 16, uppercase: true))
//					Text("WZ")
//						.foregroundStyle(.secondary)
//					Text("????")
//				}
//			}
//			Divider()
//			Grid {
//				GridRow {
//					Text("Data")
//						.foregroundStyle(.secondary)
//					Text(String(z80.data, radix: 16, uppercase: true))
//					Text(String(z80.data, radix: 2, uppercase: true))
//				}
//				GridRow {
//					Text("Address")
//						.foregroundStyle(.secondary)
//					Text(String(z80.address, radix: 16, uppercase: true))
//					Text(String(z80.address, radix: 2, uppercase: true))
//				}
//			}
//		}
//		.monospaced()
//	}
//}
//
//@available(macOS 14, *)
//#Preview {
//	let z80 = ObservableZ80()
//	return RegistersView()
//		.environment(z80)
//}
//#endif
