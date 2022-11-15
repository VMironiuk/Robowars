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
        []
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
    
    func set(battlefield: CGRect, ships: [CGSize]) {
    }
    
    func shoot() -> CGPoint {
        .zero
    }
    
    func shootResult(_ result: ShootResult) {
    }
}
