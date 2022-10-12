//
//  GameMode.swift
//  Robowars
//
//  Created by Vladimir Mironiuk on 28.05.2022.
//

import Foundation

public enum GameMode {
    case classic
    
    public func battlefield() -> CGRect {
        switch self {
        case .classic:
            return CGRect(x: 0, y: 0, width: 10, height: 10)
        }
    }
    
    public func ships() -> [CGSize] {
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
        }
    }
    
    public func title() -> String {
        switch self {
        case .classic:
            return "Classic"
        }
    }
}
