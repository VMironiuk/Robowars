//
//  Misplacer.swift
//  RobowarsClient-macOS
//
//  Created by Volodymyr Myroniuk on 09.02.2023.
//

import Foundation
import Robowars

class Misplacer: RobotProtocol {
    
    let ships: [CGRect] = []
    
    let name: String = "Misplacer"
    
    let winnerMessage: String = "Winner"
    
    let loserMessage: String = "Loser"
        
    func update(for gameMode: GameMode) {
    }
    
    func shoot() -> CGPoint {
        .zero
    }
    
    func shootResult(_ result: ShootResult) {}
}
