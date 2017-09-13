//
//  OpenLocateTests.swift
//
//  Copyright (c) 2017 OpenLocate
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import XCTest
@testable import OpenLocate

class TestConfiguration: Configuration {
    var url: String {
        return "http://www.openlocate.com"
    }

    var headers: Headers?

}

class OpenLocateTests: BaseTestCase {

    func testOpenLocateSharedInstance() {
        // Given
        let openLocate = OpenLocate.shared

        // When
        let newOpenLocate = OpenLocate.shared

        // Then
        XCTAssert(openLocate === newOpenLocate)
    }

    func testOpenLocateDefaultState() {
        // Given
        let openLocate = OpenLocate.shared

        // When
        let isTracking = openLocate.tracking

        // Then
        XCTAssertFalse(isTracking)
    }

    func testStartTrackingWithInvalidToken() {
        // Given
        let openLocate = OpenLocate.shared

        // When
        XCTAssertThrowsError(try openLocate.startTracking(with: TestConfiguration()))
    }

    func testStartTracking() {
        // Given
        let openLocate = OpenLocate.shared

        // When
        XCTAssertThrowsError(try openLocate.startTracking(with: TestConfiguration()))
    }

    func testStopTracking() {
        // Given
        let openLocate = OpenLocate.shared

        // When
        openLocate.stopTracking()
        XCTAssertFalse(openLocate.tracking)
    }
}
