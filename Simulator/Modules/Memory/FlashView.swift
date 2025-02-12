//
//  FlashView.swift
//  Simulator
//
//  Created by Christophe Bronner on 2025-01-20.
//

import SwiftUI
import libz80e

struct FlashView: View {
	@Environment(SimulatorModel.self) private var simulator
	@Environment(\.simulatorScene) private var scene
	@State private var selection: Set<Int> = []

	var body: some View {
		@Bindable var scene = scene
		ScrollView(.vertical) {
			LazyVStack(pinnedViews: .sectionHeaders) {
				FlashPage(page: scene.flashPage, simulator: simulator)
			}
		}
		.monospaced()
		.labelsHidden()
		.textFieldStyle(.plain)
		.scrollPosition(id: $scene.flashAddress)
	}
}

struct FlashContent: View {
	@Environment(SimulatorModel.self) private var simulator
	@Environment(\.simulatorScene) private var scene

	private var pageCount: Int {
		Int(simulator.__asic.mmu.settings.flash_pages)
	}

	var body: some View {
		@Bindable var scene = scene
		List(selection: $scene.flashPage) {
			ForEach(0..<pageCount, id: \.self) { i in
				Text("$\(i)")
					.id("$\(i)")
			}
		}
		.monospaced()
	}
}

private struct FlashPage: View {
	let page: Int
	let simulator: SimulatorModel

	private var range: Range<Int> {
		let lowerBound = page * 0x4000
		return Range(uncheckedBounds: (lowerBound, lowerBound + 0x4000))
	}

	var body: some View {
		Section {
			ForEach(0..<0x4000) { i in
				FlashCell(address: page * 0x4000 + i, simulator: simulator)
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

private struct FlashCell: View {
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
			TextField("Value", value: $simulator.__asic.mmu.flash[address], format: .number)
		}
		.id(address)
	}
}

#Preview {
	FlashView()
}

