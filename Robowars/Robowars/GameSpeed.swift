//
//  GameSpeed.swift
//  Robowars
//
//  Created by Volodymyr Myroniuk on 06.02.2023.
//

import Foundation

public enum GameSpeed: String, CaseIterable {
    case slow = "Slow"
    case fast = "Fast"
    case blazinglyFast = "Blazingly Fast"
    
    public var timeInterval: TimeInterval {
        switch self {
        case .slow: return 0.05
        case .fast: return 0.01
        case .blazinglyFast: return 0.0
        }
    }
}
