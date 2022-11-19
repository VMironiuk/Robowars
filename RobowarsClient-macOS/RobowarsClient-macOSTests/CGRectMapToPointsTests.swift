//
//  CGRectMapToPointsTests.swift
//  RobowarsClient-macOSTests
//
//  Created by Volodymyr Myroniuk on 19.11.2022.
//

import XCTest
@testable import RobowarsClient_macOS

final class CGRectMapToPointsTests: XCTestCase {
    func test_returnsSinglePointFor1x1Ship() {
        let ships: [CGRect] = [CGRect(x: 0, y: 0, width: 1, height: 1)]
        
        XCTAssertEqual(ships.mapToPoints(), [.zero])
    }
}
