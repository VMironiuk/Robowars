//
//  Robot.swift
//  Robowars
//
//  Created by Vladimir Mironiuk on 28.05.2022.
//

import Foundation

public enum ShootResult {
    case miss, hit, kill
}

public protocol Robot: AnyObject {
    var ships: [CGRect] { get }

    func set(battlefield: CGSize, ships: [CGSize])
    func shoot() -> CGPoint
    func shootResult(_ result: ShootResult, for coordinate: CGPoint)
}
