//
//  DummyRobot.swift
//  RobowarsClient-macOSTests
//
//  Created by Volodymyr Myroniuk on 14.10.2022.
//

import Foundation
import Robowars

final class DummyRobot: RobotProtocol, Equatable {
    var ships: [CGRect] {
        []
    }

    private(set) var name: String

    var winnerMessage: String {
        ""
    }

    var loserMessage: String {
        ""
    }
    
    init(name: String = "DummyRobot") {
        self.name = name
    }

    func set(battlefield: CGRect, ships: [CGSize]) {

    }

    func shoot() -> CGPoint {
        .zero
    }

    func shootResult(_ result: ShootResult, for coordinate: CGPoint) {

    }
    
    static func == (lhs: DummyRobot, rhs: DummyRobot) -> Bool {
        lhs.name == rhs.name
    }
}
