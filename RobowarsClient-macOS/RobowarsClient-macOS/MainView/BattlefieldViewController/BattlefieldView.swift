//
//  BattlefieldView.swift
//  RobowarsClient-macOS
//
//  Created by Volodymyr Myroniuk on 03.11.2022.
//

import Cocoa

final class BattlefieldView: NSView {
    override var isFlipped: Bool {
        true
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layout() {
        super.layout()
    }
    
    func updateBattlefield(_ newBattlefield: CGRect) {}
    
    func updateShips(with coordinates: [CGPoint]) {}
    
    func updateTile(with state: TileState) {}
}
