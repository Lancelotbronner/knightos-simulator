//
//  MemoryView.swift
//  Simulator
//
//  Created by Christophe Bronner on 2025-01-20.
//

import SwiftUI
import libz80e

struct MemoryView: View {
	@Environment(SimulatorModel.self) private var simulator
	@Environment(\.simulatorScene) private var scene
	@State private var selection: Set<UInt16> = []

	var body: some View {
		@Bindable var scene = scene
		ScrollView(.vertical) {
			LazyVStack(pinnedViews: .sectionHeaders) {
				MemoryPage(page: scene.memoryPage, simulator: simulator)
			}
		}
		.monospaced()
		.labelsHidden()
		.textFieldStyle(.plain)
//		.scrollPosition(id: $scene.flashAddress)
	}
}

struct MemoryContent: View {
	@Environment(SimulatorModel.self) private var simulator
	@Environment(\.simulatorScene) private var scene

	var body: some View {
		@Bindable var scene = scene
		List(selection: $scene.memoryPage) {
			ForEach(0..<4) { i in
				Text("$\(i)")
					.id("$\(i)")
			}
		}
		.monospaced()
	}
}

private struct MemoryPage: View {
	let page: Int
	let simulator: SimulatorModel

	private var header: some View {
		VStack(alignment: .leading) {
			Text("Page $\(page)")
				.font(.headline)
		}
	}

	var body: some View {
		Section {
			ForEach(0..<0x4000) {
				MemoryCell(address: UInt16(truncatingIfNeeded: page * 0x4000 + $0), simulator: simulator)
			}
		} header: {
			header
		}
		.id("$\(page)")
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
		.id(address)
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
