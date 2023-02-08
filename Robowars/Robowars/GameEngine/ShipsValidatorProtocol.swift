//
//  ShipsValidatorProtocol.swift
//  Robowars
//
//  Created by Vladimir Mironiuk on 16.06.2022.
//

import Foundation

protocol ShipsValidatorProtocol: AnyObject {
    func isValid(ships: [CGRect]) -> Bool
    func update(gameMode: GameMode)
}
