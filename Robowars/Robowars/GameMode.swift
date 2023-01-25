//
//  GameMode.swift
//  Robowars
//
//  Created by Vladimir Mironiuk on 28.05.2022.
//

import Foundation

public enum GameMode: CaseIterable {
    case classic
    case flyweight
    case middleweight
    case heavyweight
    case superHeavyweight
    
    public var battlefieldSize: CGSize {
        switch self {
        case .classic, .flyweight, .middleweight:
            return CGSize(width: 10, height: 10)
        case .heavyweight:
            return CGSize(width: 20, height: 20)
        case .superHeavyweight:
            return CGSize(width: 30, height: 30)
        }
    }
    
    public var shipSizes: [CGSize] {
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
        case .middleweight:
            return [
                CGSize(width: 3, height: 2),
                CGSize(width: 3, height: 2),
                CGSize(width: 3, height: 2),
                CGSize(width: 3, height: 2),
                CGSize(width: 3, height: 2),
                CGSize(width: 3, height: 2),
            ]
        case .heavyweight:
            return [
                CGSize(width: 4, height: 3),
                CGSize(width: 4, height: 3),
                CGSize(width: 4, height: 3),
                CGSize(width: 4, height: 3),
                CGSize(width: 4, height: 3),
                CGSize(width: 4, height: 3),
                CGSize(width: 4, height: 3),
                CGSize(width: 4, height: 3),
                CGSize(width: 4, height: 3),
                CGSize(width: 4, height: 3),
            ]
        case .superHeavyweight:
            return [
                CGSize(width: 6, height: 5),
                CGSize(width: 6, height: 5),
                CGSize(width: 6, height: 5),
                CGSize(width: 6, height: 5),
                CGSize(width: 6, height: 5),
                CGSize(width: 6, height: 5),
                CGSize(width: 6, height: 5),
                CGSize(width: 6, height: 5),
                CGSize(width: 6, height: 5),
                CGSize(width: 6, height: 5),
            ]
        }
    }
    
    public var title: String {
        switch self {
        case .classic:
            return "Classic"
        case .flyweight:
            return "Flyweight"
        case .middleweight:
            return "Middleweight"
        case .heavyweight:
            return "Heavyweight"
        case .superHeavyweight:
            return "Super Heavyweight"
        }
    }
}
