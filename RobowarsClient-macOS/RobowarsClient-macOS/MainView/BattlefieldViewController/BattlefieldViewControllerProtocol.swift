//
//  BattlefieldViewControllerProtocol.swift
//  RobowarsClient-macOS
//
//  Created by Volodymyr Myroniuk on 28.10.2022.
//

import Cocoa

enum TileState {
    case miss(CGPoint)
    case hit(CGPoint)
    case kill(CGPoint)
}

protocol BattlefieldViewControllerProtocol where Self: NSViewController {
    func updateBattlefield(_ newBattlefield: CGRect)
    func updateShips(_ newShips: [CGRect])
    func updateTile(with state: TileState)
}
