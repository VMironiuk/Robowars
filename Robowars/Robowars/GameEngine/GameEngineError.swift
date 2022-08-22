//
//  GameEngineError.swift
//  Robowars
//
//  Created by Volodymyr Myroniuk on 13.08.2022.
//

import Foundation

public enum GameEngineError: Error {
    case invalidFirstRobotShipsArrangement
    case invalidSecondRobotShipsArrangement
    case invalidConstruction
}

extension GameEngineError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidFirstRobotShipsArrangement:
            return "First robot has incorrect ships placement"
        case .invalidSecondRobotShipsArrangement:
            return "Second robot has incorrect ships placement"
        case .invalidConstruction:
            return "Game engine did not constructed completely"
        }
    }
}