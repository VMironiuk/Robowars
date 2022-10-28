//
//  BattlefieldViewControllerProtocol.swift
//  RobowarsClient-macOS
//
//  Created by Volodymyr Myroniuk on 28.10.2022.
//

import Foundation

protocol BattlefieldViewControllerProtocol {
    func updateBattlefield(_ newBattlefield: CGRect)
    func updateShips(_ newShips: [CGRect])
    func updateTile(for coordinate: CGPoint)
}
