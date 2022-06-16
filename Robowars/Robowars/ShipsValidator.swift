//
//  ShipsValidator.swift
//  Robowars
//
//  Created by Vladimir Mironiuk on 16.06.2022.
//

import Foundation

public protocol ShipsValidator: AnyObject {
    func isValid(ships: [CGRect]) -> Bool
}
