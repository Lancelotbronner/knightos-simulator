// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "SimulatorKit",
	platforms: [
		.macOS(.v14),
	],
	products: [
		.library(name: "SimulatorKit", targets: [
			"SimulatorZ80",
		]),
	],
	targets: [
		.target(name: "SimulatorZ80"),
	]
)
