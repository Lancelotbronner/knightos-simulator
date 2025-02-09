//
//  FlashView.swift
//  Simulator
//
//  Created by Christophe Bronner on 2025-01-20.
//

import SwiftUI
import libz80e

struct FlashView: View {
	@Environment(\.simulator) private var simulator
	@State private var selection: Set<Int> = []

	private var pageCount: Int {
		Int(simulator.__asic.mmu.settings.flash_pages)
	}

	var body: some View {
		ScrollView(.vertical) {
			LazyVStack(pinnedViews: .sectionHeaders) {
				ForEach(0..<pageCount, id: \.self) { i in
					FlashPage(page: i, simulator: simulator)
				}
			}
		}
		.monospaced()
		.labelsHidden()
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
			ForEach(range, id: \.self) {
				FlashCell(address: $0, simulator: simulator)
			}
		} header: {
			VStack(alignment: .leading) {
				Text("Page $\(range.lowerBound/0x4000)")
					.font(.headline)
			}
		}
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
	}
}

#Preview {
	FlashView()
}

