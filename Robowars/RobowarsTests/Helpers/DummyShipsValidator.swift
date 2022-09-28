//
//  DummyShipsValidator.swift
//  RobowarsTests
//
//  Created by Vladimir Mironiuk on 18.06.2022.
//

import Foundation
@testable import Robowars

final class DummyShipsValidator: ShipsValidatorProtocol {
    func isValid(ships: [CGRect]) -> Bool {
        true
    }
    
    func update(gameMode: GameMode) {
    }
}
