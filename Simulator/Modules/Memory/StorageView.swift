//
//  StorageView.swift
//  Simulator
//
//  Created by Christophe Bronner on 2025-01-20.
//

import SwiftUI
import libz80e

struct StorageView: View {
	@Environment(SimulatorModel.self) private var simulator
	@State private var selection: Set<Int> = []

	private var pageCount: Int {
		Int(simulator.__asic.mmu.settings.ram_pages)
	}

	var body: some View {
		ScrollView(.vertical) {
			LazyVStack(pinnedViews: .sectionHeaders) {
				ForEach(0..<4, id: \.self) {
					StoragePage(page: $0, simulator: simulator)
				}
			}
		}
		.monospaced()
		.labelsHidden()
		.textFieldStyle(.plain)
	}
}

private struct StoragePage: View {
	let page: Int
	let simulator: SimulatorModel

	private var range: Range<Int> {
		let lowerBound = page * 0x4000
		return Range(uncheckedBounds: (lowerBound, lowerBound + 0x4000))
	}

	var body: some View {
		Section {
			ForEach(range, id: \.self) {
				StorageCell(address: $0, simulator: simulator)
			}
		} header: {
			VStack(alignment: .leading) {
				Text("Page $\(page)")
					.font(.headline)
			}
		}
		.id("$\(page)")
	}
}

private struct StorageCell: View {
	let address: Int
	let simulator: SimulatorModel
	@ScaledMetric private var width = 80

	private var key: Text {
		MemoryLabel.page(address)
		+ Text(":").foregroundStyle(.tertiary)
		+ MemoryLabel.relative(address)
	}

	//TODO: Color based on registers/addressing

	var body: some View {
		@Bindable var simulator = simulator
		HStack {
			key
				.frame(width: width)
			TextField("Value", value: $simulator.__asic.mmu.ram[address], format: .number)
		}
		.id(address)
	}
}

#Preview {
	StorageView()
}
