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
    
    private var shoots: [CGPoint] = []
    
    private(set) var ships: [CGRect] = []
    
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
        updateShips(for: gameMode)
        refreshShoots()
    }
    
    func shoot() -> CGPoint {
        let randomIndex = Int.random(in: .zero..<shoots.count)
        return shoots.remove(at: randomIndex)
    }
    
    func shootResult(_ result: ShootResult) {}
    
    private func updateShips(for gameMode: GameMode) {
        ships = RandomatorShipsProvider.makeShips(for: gameMode)
    }
    
    private func refreshShoots() {
        shoots = []
        
        for y in .zero..<Int(battlefieldSize.height) {
            for x in .zero..<Int(battlefieldSize.width) {
                shoots.append(CGPoint(x: x, y: y))
            }
        }
    }
}
