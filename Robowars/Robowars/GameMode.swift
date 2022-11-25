//
//  GameMode.swift
//  Robowars
//
//  Created by Vladimir Mironiuk on 28.05.2022.
//

import Foundation

public enum GameMode {
    case classic
    case flyweight
    
    public var battlefieldSize: CGSize {
        switch self {
        case .classic, .flyweight:
            return CGSize(width: 10, height: 10)
        }
    }
    
    public var ships: [CGSize] {
        switch self {
        case .classic:
            return [
                CGSize(width: 1, height: 1),
                CGSize(width: 1, height: 1),
                CGSize(width: 1, height: 1),
                CGSize(width: 1, height: 1),
                CGSize(width: 2, height: 1),
                CGSize(width: 2, height: 1),
                CGSize(width: 2, height: 1),
                CGSize(width: 3, height: 1),
                CGSize(width: 3, height: 1),
                CGSize(width: 4, height: 1),
            ]
        case .flyweight:
            return [
                CGSize(width: 1, height: 1),
                CGSize(width: 1, height: 1),
                CGSize(width: 1, height: 1),
                CGSize(width: 1, height: 1),
                CGSize(width: 1, height: 1),
                CGSize(width: 1, height: 1),
                CGSize(width: 1, height: 1),
                CGSize(width: 1, height: 1),
                CGSize(width: 1, height: 1),
                CGSize(width: 1, height: 1),
            ]
        }
    }
    
    public var title: String {
        switch self {
        case .classic:
            return "Classic"
        case .flyweight:
            return "Flyweight"
        }
    }
}
