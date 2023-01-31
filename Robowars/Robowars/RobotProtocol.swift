//
//  RobotProtocol.swift
//  Robowars
//
//  Created by Vladimir Mironiuk on 28.05.2022.
//

import Foundation

public enum ShootResult: Equatable {
    case miss(CGPoint)
    case hit(CGPoint)
    case kill(CGPoint)
}

public protocol RobotProtocol: AnyObject {
    var ships: [CGRect] { get }
    var name: String { get }
    var winnerMessage: String { get }
    var loserMessage: String { get }

    func update(for gameMode: GameMode)
    func shoot() -> CGPoint
    func shootResult(_ result: ShootResult)
}
