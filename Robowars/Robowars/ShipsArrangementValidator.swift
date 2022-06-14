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
        isValidCountAndSizesOf(ships: ships) && isShipsInsideBattlefield(ships) && !isCollisionBetween(ships: ships)
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
    
    private func isCollisionBetween(ships: [CGRect]) -> Bool {
        for i in 0..<ships.count {
            for j in (i + 1)..<ships.count {
                if ships[i].intersects(ships[j]) || ships[i].touches(ships[j]) {
                    return true
                }
            }
        }
        return false
    }
}

extension CGSize: Comparable {
    public static func < (lhs: CGSize, rhs: CGSize) -> Bool {
        (lhs.width * lhs.height) < (rhs.width * rhs.height)
    }
}

extension CGRect {
    func touches(_ rect2: CGRect) -> Bool {
        if minX > rect2.maxX || rect2.minX > maxX { return false }
        if minY > rect2.maxY || rect2.minY > maxY { return false }
        return true
    }
}
