import XCTest
@testable import z80eKit

final class z80eKitTests: XCTestCase {
    func testExample() throws {
		var value: UInt16 = 0xF01
		XCTAssertEqual(value.bytes[0], 0x1)
		XCTAssertEqual(value.bytes[1], 0xF)
		value.bytes[1] = 0x4
		print(value)
		XCTAssertEqual(value.bytes[1], 0x4)
    }
}
