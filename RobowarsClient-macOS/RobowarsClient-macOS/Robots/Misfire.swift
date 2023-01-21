//
//  Misfire.swift
//  RobowarsClient-macOS
//
//  Created by Volodymyr Myroniuk on 12.11.2022.
//

import Foundation
import Robowars

final class Misfire: RobotProtocol {
    private var shoots: [CGPoint] = []
    
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
    
    init() {
        refreshShoots()
    }
    
    func set(battlefieldSize: CGSize, shipSizes: [CGSize]) {
        refreshShoots()
    }
    
    func shoot() -> CGPoint {
        guard let newShoot = shoots.popLast() else { return .zero }
        return newShoot
    }
    
    func shootResult(_ result: ShootResult) {
    }
    
    private func refreshShoots() {
        for y in .zero..<10 {
            for x in .zero..<10 {
                shoots.append(CGPoint(x: x, y: y))
            }
        }
    }
}
