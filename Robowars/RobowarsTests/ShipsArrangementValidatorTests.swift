//
//  ShipsArrangementValidatorTests.swift
//  RobowarsTests
//
//  Created by Vladimir Mironiuk on 08.06.2022.
//

import XCTest

final class ShipsArrangementValidator {
    private let battlefield: CGSize
    private let ships: [CGSize]
    
    init(battlefield: CGSize, ships: [CGSize]) {
        self.battlefield = battlefield
        self.ships = ships
    }
    
    func isValid(ships: [CGRect]) -> Bool {
        isValidCountAndSizesOf(ships: ships)
    }
    
    private func isValidCountAndSizesOf(ships: [CGRect]) -> Bool {
        let sortedGivenShips = ships
            .map { CGSize(width: $0.width, height: $0.height) }
            .sorted(by: <)
            .map { $0.width < $0.height ? CGSize(width: $0.height, height: $0.width) : $0 }
        let sortedSelfShips = self.ships
            .sorted(by: <)
            .map { $0.width < $0.height ? CGSize(width: $0.height, height: $0.width) : $0 }
        return sortedGivenShips == sortedSelfShips
    }
}

extension CGSize: Comparable {
    public static func < (lhs: CGSize, rhs: CGSize) -> Bool {
        (lhs.width * lhs.height) < (rhs.width * rhs.height)
    }
}

class ShipsArrangementValidatorTests: XCTestCase {
    
    func test_isValid_returnsTrueForValidCountAndSizesOfShips() {
        // Given
        let battlefield = CGSize(width: 10, height: 10)
        let ships = [
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
        let sut = ShipsArrangementValidator(battlefield: battlefield, ships: ships)
        // When
        let givenShips = [
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
        let result = sut.isValid(ships: givenShips)
        // Then
        XCTAssertTrue(result)
    }
}
