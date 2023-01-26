//
//  Randomator.swift
//  RobowarsClient-macOS
//
//  Created by Volodymyr Myroniuk on 25.01.2023.
//

import Foundation
import Robowars

class Randomator: RobotProtocol {
    private let model: String
    
    private var battlefieldSize: CGSize = .zero
    
    var ships: [CGRect] = []
    
    var name: String {
        "Randomator \(model)"
    }
    
    var winnerMessage: String {
        "TODO: add a winner message"
    }
    
    var loserMessage: String {
        "TODO: add a loser message"
    }
    
    init(model: String) {
        self.model = model
    }
    
    func update(for gameMode: GameMode) {
        self.battlefieldSize = gameMode.battlefieldSize
        updateShips(from: gameMode.shipSizes)
    }
    
    func shoot() -> CGPoint {
        // TODO: add implementation
        .zero
    }
    
    func shootResult(_ result: ShootResult) {
        // TODO: add implementation
    }
    
    private func updateShips(from shipSizes: [CGSize]) {
        // TODO: add implementation
    }
}
