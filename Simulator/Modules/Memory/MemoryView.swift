//
//  MemoryView.swift
//  Simulator
//
//  Created by Christophe Bronner on 2025-01-20.
//

import SwiftUI
@preconcurrency import libz80e

struct MemoryView: View {
	@Environment(\.simulator) private var simulator
	@State private var selection: Set<UInt16> = []

	var body: some View {
		ScrollView(.vertical) {
			LazyVStack(pinnedViews: .sectionHeaders) {
				ForEach(0..<4, id: \.self) {
					MemoryPage(page: $0, simulator: simulator)
				}
			}
		}
		.monospaced()
		.labelsHidden()
		.textFieldStyle(.plain)
	}
}

private struct MemoryPage: View {
	let page: Int
	let simulator: SimulatorModel

	private var range: Range<UInt16> {
		let lowerBound = UInt16(truncatingIfNeeded: page * 0x4000)
		return Range(uncheckedBounds: (lowerBound, lowerBound + 0x4000))
	}

	private var header: some View {
		VStack(alignment: .leading) {
			Text("Page \(page)")
				.font(.headline)
		}
	}

	var body: some View {
		Section {
			ForEach(range, id: \.self) {
				MemoryCell(address: $0, simulator: simulator)
			}
		} header: {
			header
		}
	}
}

private struct MemoryCell: View {
	@ScaledMetric private var width = 80
	let address: UInt16
	let simulator: SimulatorModel

	var body: some View {
		let binding = Binding<UInt8> {
			mmu_destination(&simulator.__asic.mmu, address).pointee
		} set: {
			mmu_destination(&simulator.__asic.mmu, address).pointee = $0
		}
		HStack {
			MemoryLabel(address: address, simulator: simulator)
				.frame(width: width)
			TextField("Value", value: binding, format: .number)
		}
	}
}

struct MemoryLabel: View {
	let address: UInt16
	let simulator: SimulatorModel

	nonisolated
	static func page(_ address: Int) -> Text {
		let hex = String(address/0x4000, radix: 16)
		var result = Text(hex)
		if hex.count < 2 {
			result = Text(String(repeating: "0", count: 2-hex.count)) + result
		}
		return result
	}

	nonisolated
	static func relative(_ address: Int) -> Text {
		let hex = String(address%0x4000, radix: 16)
		var result = Text(hex)
		if hex.count < 4 {
			result = Text(String(repeating: "0", count: 4-hex.count)) + result
		}
		return result
	}

	private var label: Text {
		let bank = mmu_bank(&simulator.__asic.mmu, UInt32(address)/0x4000)
		var result = bank.flash ? Text("F") : Text("R")
		result = result + Text(":").foregroundStyle(.tertiary)
		result = result + Self.page(Int(address))
		result = result + Text(":").foregroundStyle(.tertiary)
		result = result + Self.relative(Int(address))
		return result
	}

//	func color(for simulator: CalculatorTi73) -> Color {
//		switch true {
//		case rawValue == Int(simulator.__asic.cpu.registers.PC): .cyan
//		//TODO: yellow on active
//		default: .primary
//		}
//	}

	var body: some View {
		label
	}
}

#Preview {
	MemoryView()
}
