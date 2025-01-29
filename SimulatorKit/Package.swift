// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "SimulatorKit",
	platforms: [
		.macOS(.v15),
	],
	products: [
		.library(name: "SimulatorKit", targets: [
			"SimulatorZ80",
		]),
	],
	targets: [
		.target(name: "CoreSimulator"),
		.target(name: "SimulatorKit", dependencies: ["CoreSimulator"]),
		
		.target(name: "SimulatorZ80", dependencies: ["SimulatorKit"]),
	],
	cLanguageStandard: .c2x
)
