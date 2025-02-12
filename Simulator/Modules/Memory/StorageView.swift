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
	@Environment(\.simulatorScene) private var scene
	@State private var selection: Set<Int> = []

	var body: some View {
		@Bindable var scene = scene
		ScrollView(.vertical) {
			LazyVStack(pinnedViews: .sectionHeaders) {
				StoragePage(page: scene.storagePage, simulator: simulator)
			}
		}
		.monospaced()
		.labelsHidden()
		.textFieldStyle(.plain)
	}
}

struct StorageContent: View {
	@Environment(SimulatorModel.self) private var simulator
	@Environment(\.simulatorScene) private var scene

	private var pageCount: Int {
		Int(simulator.__asic.mmu.settings.ram_pages)
	}

	var body: some View {
		@Bindable var scene = scene
		List(selection: $scene.storagePage) {
			ForEach(0..<pageCount, id: \.self) { i in
				Text("$\(i)")
					.id("$\(i)")
			}
		}
	}
}

private struct StoragePage: View {
	let page: Int
	let simulator: SimulatorModel

	var body: some View {
		Section {
			ForEach(0..<0x4000) {
				StorageCell(address: page * 0x4000 + $0, simulator: simulator)
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
