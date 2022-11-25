//
//  DummyRobot.swift
//  RobowarsTests
//
//  Created by Vladimir Mironiuk on 04.06.2022.
//

import Foundation
import Robowars

final class DummyRobot: RobotProtocol {
    private(set) var ships: [CGRect] = []
    var name: String {
        ""
    }
    var winnerMessage: String {
        ""
    }
    var loserMessage: String {
        ""
    }
    
    func set(battlefieldSize: CGSize, ships: [CGSize]) {
        self.ships = [
            CGRect(x: 0, y: 1, width: 4, height: 1),
            CGRect(x: 8, y: 2, width: 1, height: 1),
            CGRect(x: 8, y: 5, width: 1, height: 1),
            CGRect(x: 1, y: 3, width: 3, height: 1),
            CGRect(x: 0, y: 5, width: 1, height: 3),
            CGRect(x: 7, y: 7, width: 1, height: 1),
            CGRect(x: 0, y: 9, width: 2, height: 1),
            CGRect(x: 2, y: 6, width: 1, height: 2),
            CGRect(x: 9, y: 9, width: 1, height: 1),
            CGRect(x: 3, y: 9, width: 2, height: 1),
        ]
    }
    
    func shoot() -> CGPoint {
        CGPoint(x: 0, y: 0)
    }
    
    func shootResult(_ result: ShootResult) {
    }
}
