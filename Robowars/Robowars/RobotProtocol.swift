//
//  RobotProtocol.swift
//  Robowars
//
//  Created by Vladimir Mironiuk on 28.05.2022.
//

import Foundation

public enum ShootResult {
    case miss, hit, kill
}

public protocol RobotProtocol: AnyObject {
    var ships: [CGRect] { get }
    var name: String { get }
    var winnerMessage: String { get }
    var loserMessage: String { get }

    func set(battlefield: CGRect, ships: [CGSize])
    func shoot() -> CGPoint
    func shootResult(_ result: ShootResult, for coordinate: CGPoint)
}
