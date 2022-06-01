//
//  Robot.swift
//  Robowars
//
//  Created by Vladimir Mironiuk on 28.05.2022.
//

import Foundation

public protocol Robot: AnyObject {
    var ships: [CGRect] { get }

    func set(battlefield: CGSize, ships: [CGSize])
}
