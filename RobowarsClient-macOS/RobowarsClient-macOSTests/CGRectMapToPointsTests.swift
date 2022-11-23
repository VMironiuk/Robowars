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
        
        expect(points: expectedPoints, forShips: ships)
    }
    
    func test_returnsPointsWithCorrectCoordinatesFor2x2Ships() {
        let ship: CGRect = CGRect(x: 2, y: 3, width: 2, height: 2)
        let expectedPoints: [CGPoint] = [
            CGPoint(x: 2, y: 3), CGPoint(x: 2, y: 4),
            CGPoint(x: 3, y: 3), CGPoint(x: 3, y: 4)
        ]
        
        expect(points: expectedPoints, forShips: [ship])
    }
    
    func test_returnsPointsWithCorrectCoordinatesFor2x1Ship() {
        let ship: CGRect = CGRect(x: 0, y: 0, width: 2, height: 1)
        let expectedPoints: [CGPoint] = [CGPoint(x: 0, y: 0), CGPoint(x: 1, y: 0)]
        
        expect(points: expectedPoints, forShips: [ship])
    }
    
    func test_returnsPointsWithCorrectCoordinatesFor1x2Ship() {
        let ship: CGRect = CGRect(x: 0, y: 0, width: 1, height: 2)
        let expectedPoints: [CGPoint] = [CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 1)]
        
        expect(points: expectedPoints, forShips: [ship])
    }
    
    func test_returnsPointsWithCorrectCoordinatesFor3x2Ship() {
        let ship: CGRect = CGRect(x: 5, y: 6, width: 3, height: 2)
        let expectedPoints: [CGPoint] = [
            CGPoint(x: 5, y: 6), CGPoint(x: 5, y: 7),
            CGPoint(x: 6, y: 6), CGPoint(x: 6, y: 7),
            CGPoint(x: 7, y: 6), CGPoint(x: 7, y: 7)
        ]
        
        expect(points: expectedPoints, forShips: [ship])
    }
    
    func test_returnsPointsWithCorrectCoordinatesFor2x3Ship() {
        let ship: CGRect = CGRect(x: 5, y: 6, width: 2, height: 3)
        let expectedPoints: [CGPoint] = [
            CGPoint(x: 5, y: 6), CGPoint(x: 5, y: 7), CGPoint(x: 5, y: 8),
            CGPoint(x: 6, y: 6), CGPoint(x: 6, y: 7), CGPoint(x: 6, y: 8)
        ]
        
        expect(points: expectedPoints, forShips: [ship])
    }
    
    // MARK: - Helpers
    
    private func expect(
        points: [CGPoint],
        forShips ships: [CGRect],
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        XCTAssertEqual(ships.mapToPoints(), points, file: file, line: line)
    }
}
