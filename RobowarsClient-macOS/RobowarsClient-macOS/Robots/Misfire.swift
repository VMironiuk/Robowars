//
//  Misfire.swift
//  RobowarsClient-macOS
//
//  Created by Volodymyr Myroniuk on 12.11.2022.
//

import Foundation
import Robowars

final class Misfire: RobotProtocol {
    var ships: [CGRect] {
        [
            CGRect(x: 0, y: 0, width: 1, height: 4),
            CGRect(x: 0, y: 5, width: 1, height: 3),
            CGRect(x: 0, y: 9, width: 2, height: 1),
            CGRect(x: 2, y: 0, width: 3, height: 1),
            CGRect(x: 6, y: 0, width: 2, height: 1),
            CGRect(x: 9, y: 4, width: 1, height: 1),
            CGRect(x: 3, y: 6, width: 1, height: 1),
            CGRect(x: 7, y: 7, width: 1, height: 1),
            CGRect(x: 3, y: 9, width: 2, height: 1),
            CGRect(x: 4, y: 3, width: 1, height: 1)
        ]
    }
    
    var name: String {
        "Misfire"
    }
    
    var winnerMessage: String {
        "I won"
    }
    
    var loserMessage: String {
        "I lose"
    }
    
    func set(battlefieldSize: CGSize, shipSizes: [CGSize]) {
    }
    
    func shoot() -> CGPoint {
        .zero
    }
    
    func shootResult(_ result: ShootResult) {
    }
}
