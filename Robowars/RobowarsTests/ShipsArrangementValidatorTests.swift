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
        assertThat(makeSUT(), returns: true, on: makeGivenShips(), message: "Expected \'true\' on default data set")
    }

    func test_isValid_onSadPaths() {
        sadMappers().forEach { (mapper, message) in
            assertThat(makeSUT(), returns: false, on: mapper(makeGivenShips()), message: message)
        }
    }

    // MARK: - Helpers
    
    private func makeSUT() -> ShipsArrangementValidator {
        let battlefield = CGRect(x: 0, y: 0, width: 10, height: 10)
        let ships = makeShips()
        let sut = ShipsArrangementValidator(battlefield: battlefield, ships: ships)
        return sut
    }
    
    private func assertThat(
        _ sut: ShipsArrangementValidator,
        returns expectedResult: Bool,
        on givenShips: [CGRect],
        message: String = "",
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        XCTAssertEqual(expectedResult, sut.isValid(ships: givenShips), message, file: file, line: line)
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
            CGRect(x: 0, y: 1, width: 4, height: 1),
            CGRect(x: 8, y: 2, width: 1, height: 1),
            CGRect(x: 8, y: 5, width: 1, height: 1),
            CGRect(x: 1, y: 3, width: 3, height: 1),
            CGRect(x: 0, y: 5, width: 1, height: 3),
            CGRect(x: 7, y: 7, width: 1, height: 1),
            CGRect(x: 0, y: 9, width: 2, height: 1),
            CGRect(x: 2, y: 6, width: 1, height: 2),
            CGRect(x: 9, y: 9, width: 1, height: 1),
            CGRect(x: 3, y: 9, width: 2, height: 1),
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
    
    private func mapToOverlappedShips(from ships: [CGRect]) -> [CGRect] {
        ships.map { ($0.width == 1 && $0.height == 1) ? CGRect(x: 9, y: 9, width: 1, height: 1) : $0 }
    }
    
    private func mapToTouchedShips(from ships: [CGRect]) -> [CGRect] {
        ships.map { ($0.width == 4 || $0.height == 4) ? CGRect(x: $0.minX, y: $0.minY + 1, width: $0.width, height: $0.height) : $0 }
    }
    
    private func sadMappers() -> [(([CGRect]) -> [CGRect], String)] {
        [
            (mapToInvalidCountOfShips, "\'mapToInvalidCountOfShips\' mapper failed"),
            (mapToInvalidSizesOfShips, "\'mapToInvalidSizesOfShips\' mapper failed"),
            (mapToShipsWithNegativeOriginX, "\'mapToShipsWithNegativeOriginX\' mapper failed"),
            (mapToShipsWithNegativeOriginY, "\'mapToShipsWithNegativeOriginY\' mapper failed"),
            (mapToShipsWithNegativeOrigin, "\'mapToShipsWithNegativeOrigin\' mapper failed"),
            (mapToShipsWithPositiveOriginXOutsideBattlefield, "\'mapToShipsWithPositiveOriginXOutsideBattlefield\' mapper failed"),
            (mapToShipsWithPositiveOriginYOutsideBattlefield, "\'mapToShipsWithPositiveOriginYOutsideBattlefield\' mapper failed"),
            (mapToShipsWithPositiveOriginOutsideBattlefield, "\'mapToShipsWithPositiveOriginOutsideBattlefield\' mapper failed"),
            (mapToShipsOutsideBattlefieldBottom, "\'mapToShipsOutsideBattlefieldBottom\' mapper failed"),
            (mapToShipsOutsideBattlefieldRight, "\'mapToShipsOutsideBattlefieldRight\' mapper failed"),
            (mapToOverlappedShips, "\'mapToOverlappedShips\' mapper failed"),
            (mapToTouchedShips, "\'mapToTouchedShips\' mapper failed"),
        ]
    }
}
