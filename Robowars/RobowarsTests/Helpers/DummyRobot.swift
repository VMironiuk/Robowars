//
//  DummyRobot.swift
//  RobowarsTests
//
//  Created by Vladimir Mironiuk on 04.06.2022.
//

import Foundation
import Robowars

final class DummyRobot: Robot {
    private(set) var ships: [CGRect] = []
    func set(battlefield: CGSize, ships: [CGSize]) {
        self.ships.append(CGRect(x: 0, y: 0, width: 1, height: 1))
    }
}
