//
//  DummyShipsValidator.swift
//  RobowarsTests
//
//  Created by Vladimir Mironiuk on 18.06.2022.
//

import Foundation
import Robowars

final class DummyShipsValidator: ShipsValidator {
    func isValid(ships: [CGRect]) -> Bool {
        true
    }
}
