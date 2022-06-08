//
//  ShipsArrangementValidator.swift
//  Robowars
//
//  Created by Vladimir Mironiuk on 08.06.2022.
//

import Foundation

public final class ShipsArrangementValidator {
    private let battlefield: CGRect
    private let ships: [CGSize]
    
    public init(battlefield: CGRect, ships: [CGSize]) {
        self.battlefield = battlefield
        self.ships = ships
    }
    
    public func isValid(ships: [CGRect]) -> Bool {
        isValidCountAndSizesOf(ships: ships) && isShipsInsideBattlefield(ships)
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
    
    private func isShipsInsideBattlefield(_ ships: [CGRect]) -> Bool {
        ships.filter { !battlefield.contains($0) }.isEmpty
    }
}

extension CGSize: Comparable {
    public static func < (lhs: CGSize, rhs: CGSize) -> Bool {
        (lhs.width * lhs.height) < (rhs.width * rhs.height)
    }
}
