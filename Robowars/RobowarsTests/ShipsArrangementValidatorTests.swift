//
//  ShipsArrangementValidatorTests.swift
//  RobowarsTests
//
//  Created by Vladimir Mironiuk on 08.06.2022.
//

import XCTest
import Robowars

class ShipsArrangementValidatorTests: XCTestCase {
    
    func test_isValid_returnsTrueForValidCountAndSizesOfShips() {
        // Given
        let sut = makeSUT()
        // When
        let givenShips = makeGivenShips()
        let result = sut.isValid(ships: givenShips)
        // Then
        XCTAssertTrue(result)
    }
    
    func test_isValid_returnsFalseForInvalidCountOfShips() {
        // Given
        let sut = makeSUT()
        // When
        let givenShips = mapToInvalidCountOfShips(from: makeGivenShips())
        let result = sut.isValid(ships: givenShips)
        // Then
        XCTAssertFalse(result)
    }
    
    func test_isValid_returnsFalseForInvalidSizesOfShips() {
        // Given
        let sut = makeSUT()
        // When
        let givenShips = mapToInvalidSizesOfShips(from: makeGivenShips())
        let result = sut.isValid(ships: givenShips)
        // Then
        XCTAssertFalse(result)
    }
    
    func test_isValid_returnsFalseOnShipsWithNegativeOriginX() {
        // Given
        let sut = makeSUT()
        // When
        let givenShips = mapToShipsWithNegativeOriginX(from: makeGivenShips())
        let result = sut.isValid(ships: givenShips)
        // Then
        XCTAssertFalse(result)
    }
    
    func test_isValid_returnsFalseOnShipsWithNegativeOriginY() {
        // Given
        let sut = makeSUT()
        // When
        let givenShips = mapToShipsWithNegativeOriginY(from: makeGivenShips())
        let result = sut.isValid(ships: givenShips)
        // Then
        XCTAssertFalse(result)
    }
    
    func test_isValid_returnsFalseOnShipsWithNegativeOrigin() {
        // Given
        let sut = makeSUT()
        // When
        let givenShips = mapToShipsWithNegativeOrigin(from: makeGivenShips())
        let result = sut.isValid(ships: givenShips)
        // Then
        XCTAssertFalse(result)
    }
    
    func test_isValid_returnsFalseOnShipsWithPositiveOriginXOutsideBattlefield() {
        // Given
        let sut = makeSUT()
        // When
        let givenShips = mapToShipsWithPositiveOriginXOutsideBattlefield(from: makeGivenShips())
        let result = sut.isValid(ships: givenShips)
        // Then
        XCTAssertFalse(result)
    }
    
    func test_isValid_returnsFalseOnShipsWithPositiveOriginYOutsideBattlefield() {
        // Given
        let sut = makeSUT()
        // When
        let givenShips = mapToShipsWithPositiveOriginYOutsideBattlefield(from: makeGivenShips())
        let result = sut.isValid(ships: givenShips)
        // Then
        XCTAssertFalse(result)
    }
    
    func test_isValid_returnsFalseOnShipsWithPositiveOriginOutsideBattlefield() {
        // Given
        let sut = makeSUT()
        // When
        let givenShips = mapToShipsWithPositiveOriginOutsideBattlefield(from: makeGivenShips())
        let result = sut.isValid(ships: givenShips)
        // Then
        XCTAssertFalse(result)
    }
    
    func test_isValid_returnsFalseOnShipsOutsideBattlefieldBottom() {
        // Given
        let sut = makeSUT()
        // When
        let givenShips = mapToShipsOutsideBattlefieldBottom(from: makeGivenShips())
        let result = sut.isValid(ships: givenShips)
        // Then
        XCTAssertFalse(result)
    }
    
    func test_isValid_returnsFalseOnShipsOutsideBattlefieldRight() {
        // Given
        let sut = makeSUT()
        // When
        let givenShips = mapToShipsOutsideBattlefieldRight(from: makeGivenShips())
        let result = sut.isValid(ships: givenShips)
        // Then
        XCTAssertFalse(result)
    }

    // MARK: - Helpers
    
    private func makeSUT() -> ShipsArrangementValidator {
        let battlefield = CGRect(x: 0, y: 0, width: 10, height: 10)
        let ships = makeShips()
        let sut = ShipsArrangementValidator(battlefield: battlefield, ships: ships)
        return sut
    }
    
    private func makeShips() -> [CGSize] {
        [
            CGSize(width: 1, height: 1),
            CGSize(width: 1, height: 1),
            CGSize(width: 1, height: 1),
            CGSize(width: 1, height: 1),
            CGSize(width: 2, height: 1),
            CGSize(width: 1, height: 2),
            CGSize(width: 1, height: 2),
            CGSize(width: 3, height: 1),
            CGSize(width: 1, height: 3),
            CGSize(width: 1, height: 4),
        ]
    }
    
    private func makeGivenShips() -> [CGRect] {
        [
            CGRect(x: 0, y: 0, width: 4, height: 1),
            CGRect(x: 0, y: 0, width: 1, height: 1),
            CGRect(x: 0, y: 0, width: 1, height: 1),
            CGRect(x: 0, y: 0, width: 3, height: 1),
            CGRect(x: 0, y: 0, width: 1, height: 3),
            CGRect(x: 0, y: 0, width: 1, height: 1),
            CGRect(x: 0, y: 0, width: 2, height: 1),
            CGRect(x: 0, y: 0, width: 1, height: 2),
            CGRect(x: 0, y: 0, width: 1, height: 1),
            CGRect(x: 0, y: 0, width: 2, height: 1),
        ]
    }
    
    private func mapToInvalidCountOfShips(from ships: [CGRect]) -> [CGRect] {
        ships.dropLast()
    }
    
    private func mapToInvalidSizesOfShips(from ships: [CGRect]) -> [CGRect] {
        ships.map { ($0.width == 4 || $0.height == 4) ? CGRect(x: 0, y: 0, width: 4, height: 4) : $0 }
    }
    
    private func mapToShipsWithNegativeOriginX(from ships: [CGRect]) -> [CGRect] {
        ships.map { ($0.width == 4 || $0.height == 4) ? CGRect(x: -1, y: 0, width: $0.width, height: $0.height) : $0 }
    }
    
    private func mapToShipsWithNegativeOriginY(from ships: [CGRect]) -> [CGRect] {
        ships.map { ($0.width == 4 || $0.height == 4) ? CGRect(x: 0, y: -1, width: $0.width, height: $0.height) : $0 }
    }
    
    private func mapToShipsWithNegativeOrigin(from ships: [CGRect]) -> [CGRect] {
        ships.map { ($0.width == 4 || $0.height == 4) ? CGRect(x: -1, y: -1, width: $0.width, height: $0.height) : $0 }
    }
    
    private func mapToShipsWithPositiveOriginXOutsideBattlefield(from ships: [CGRect]) -> [CGRect] {
        ships.map { ($0.width == 4 || $0.height == 4) ? CGRect(x: 11, y: 0, width: $0.width, height: $0.height) : $0 }
    }
    
    private func mapToShipsWithPositiveOriginYOutsideBattlefield(from ships: [CGRect]) -> [CGRect] {
        ships.map { ($0.width == 4 || $0.height == 4) ? CGRect(x: 1, y: 11, width: $0.width, height: $0.height) : $0 }
    }
    
    private func mapToShipsWithPositiveOriginOutsideBattlefield(from ships: [CGRect]) -> [CGRect] {
        ships.map { ($0.width == 4 || $0.height == 4) ? CGRect(x: 12, y: 11, width: $0.width, height: $0.height) : $0 }
    }
    
    private func mapToShipsOutsideBattlefieldBottom(from ships: [CGRect]) -> [CGRect] {
        ships.map { ($0.width == 4 || $0.height == 4) ? CGRect(x: 2, y: 7, width: 1, height: 4) : $0 }
    }
    
    private func mapToShipsOutsideBattlefieldRight(from ships: [CGRect]) -> [CGRect] {
        ships.map { ($0.width == 4 || $0.height == 4) ? CGRect(x: 7, y: 6, width: 4, height: 1) : $0 }
    }
}
