//
//  CGRectMapToPointsTests.swift
//  RobowarsClient-macOSTests
//
//  Created by Volodymyr Myroniuk on 19.11.2022.
//

import XCTest
@testable import RobowarsClient_macOS

final class CGRectMapToPointsTests: XCTestCase {
    func test_returnsPointsWithCorrectCoordinatesFor1x1Ships() {
        let ships: [CGRect] = [
            CGRect(x: 5, y: 6, width: 1, height: 1),
            CGRect(x: 0, y: 0, width: 1, height: 1),
            CGRect(x: 9, y: 1, width: 1, height: 1),
            CGRect(x: 7, y: 5, width: 1, height: 1)
        ]
        let expectedPoints: [CGPoint] = [
            CGPoint(x: 5, y: 6),
            CGPoint(x: 0, y: 0),
            CGPoint(x: 9, y: 1),
            CGPoint(x: 7, y: 5)
        ]
        
        XCTAssertEqual(ships.mapToPoints(), expectedPoints)
    }
}
