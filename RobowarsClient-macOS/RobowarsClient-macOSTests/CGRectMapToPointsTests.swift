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
        let (ships, expectedPoints) = make1x1ShipsWithPoints()
        expect(points: expectedPoints, forShips: ships)
    }
    
    func test_returnsPointsWithCorrectCoordinatesFor2x2Ships() {
        let (ships, expectedPoints) = make2x2ShipsWithPoints()
        expect(points: expectedPoints, forShips: ships)
    }
    
    func test_returnsPointsWithCorrectCoordinatesFor2x1Ship() {
        let (ships, expectedPoints) = make2x1ShipsWithPoints()
        expect(points: expectedPoints, forShips: ships)
    }
    
    func test_returnsPointsWithCorrectCoordinatesFor1x2Ship() {
        let (ships, expectedPoints) = make1x2ShipsWithPoints()
        expect(points: expectedPoints, forShips: ships)
    }
    
    func test_returnsPointsWithCorrectCoordinatesFor3x2Ship() {
        let (ships, expectedPoints) = make3x2ShipsWithPoints()
        expect(points: expectedPoints, forShips: ships)
    }
    
    func test_returnsPointsWithCorrectCoordinatesFor2x3Ship() {
        let (ships, expectedPoints) = make2x3ShipsWithPoints()
        expect(points: expectedPoints, forShips: ships)
    }
    
    // MARK: - Helpers
    
    private func expect(
        points: [CGPoint],
        forShips ships: [CGRect],
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        XCTAssertEqual(ships.points, points, file: file, line: line)
    }
    
    private func make1x1ShipsWithPoints() -> (ships: [CGRect], points: [CGPoint]) {
        (
            ships: [
                CGRect(x: 5, y: 6, width: 1, height: 1),
                CGRect(x: 0, y: 0, width: 1, height: 1),
                CGRect(x: 9, y: 1, width: 1, height: 1),
                CGRect(x: 7, y: 5, width: 1, height: 1)
            ],
            points: [
                CGPoint(x: 5, y: 6),
                CGPoint(x: 0, y: 0),
                CGPoint(x: 9, y: 1),
                CGPoint(x: 7, y: 5)
            ]
        )
    }
    
    private func make2x2ShipsWithPoints() -> (ships: [CGRect], points: [CGPoint]) {
        (
            ships: [CGRect(x: 2, y: 3, width: 2, height: 2)],
            points: [
                CGPoint(x: 2, y: 3), CGPoint(x: 2, y: 4),
                CGPoint(x: 3, y: 3), CGPoint(x: 3, y: 4)
            ]
        )
    }
    
    private func make2x1ShipsWithPoints() -> (ships: [CGRect], points: [CGPoint]) {
        (
            ships: [CGRect(x: 0, y: 0, width: 2, height: 1)],
            points: [CGPoint(x: 0, y: 0), CGPoint(x: 1, y: 0)]
        )
    }
    
    private func make1x2ShipsWithPoints() -> (ships: [CGRect], points: [CGPoint]) {
        (
            ships: [CGRect(x: 0, y: 0, width: 1, height: 2)],
            points: [CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 1)]
        )
    }
    
    private func make3x2ShipsWithPoints() -> (ships: [CGRect], points: [CGPoint]) {
        (
            ships: [CGRect(x: 5, y: 6, width: 3, height: 2)],
            points: [
                CGPoint(x: 5, y: 6), CGPoint(x: 5, y: 7),
                CGPoint(x: 6, y: 6), CGPoint(x: 6, y: 7),
                CGPoint(x: 7, y: 6), CGPoint(x: 7, y: 7)
            ]
        )
    }
    
    private func make2x3ShipsWithPoints() -> (ships: [CGRect], points: [CGPoint]) {
        (
            ships: [CGRect(x: 5, y: 6, width: 2, height: 3)],
            points: [
                CGPoint(x: 5, y: 6), CGPoint(x: 5, y: 7), CGPoint(x: 5, y: 8),
                CGPoint(x: 6, y: 6), CGPoint(x: 6, y: 7), CGPoint(x: 6, y: 8)
            ]
        )
    }
}
