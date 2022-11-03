//
//  BattlefieldViewController.swift
//  RobowarsClient-macOS
//
//  Created by Volodymyr Myroniuk on 03.11.2022.
//

import Cocoa

final class BattlefieldViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension BattlefieldViewController: BattlefieldViewControllerProtocol {
    func updateBattlefield(_ newBattlefield: CGRect) {
    }
    
    func updateShips(_ newShips: [CGRect]) {
    }
    
    func updateTile(with state: TileState) {
    }
}
