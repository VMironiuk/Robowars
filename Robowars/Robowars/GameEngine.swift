//
//  GameEngine.swift
//  Robowars
//
//  Created by Vladimir Mironiuk on 28.05.2022.
//

import Foundation

public protocol GameEngineProtocol: AnyObject {
    var isValid: Bool { get }
    
    func start()
    func setFirstRobot(_ robot: Robot)
    func setSecondRobot(_ robot: Robot)
}
