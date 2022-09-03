//
//  BattlefieldView.swift
//  Prototype
//
//  Created by Volodymyr Myroniuk on 27.08.2022.
//

import Cocoa

struct BattlefieldViewState {
    let hitShots: [CGPoint]
    let missedShots: [CGPoint]
    let ships: [CGPoint]
}

class BattlefieldView: NSView {
    
    private let rowsCount: CGFloat = 10
    private let columnsCount: CGFloat = 10
    private var state: BattlefieldViewState
    
    override var isFlipped: Bool {
        true
    }
    
    override init(frame frameRect: NSRect) {
        state = BattlefieldViewState(hitShots: [], missedShots: [], ships: [])
        super.init(frame: frameRect)
        setup()
    }
    
    required init?(coder: NSCoder) {
        state = BattlefieldViewState(hitShots: [], missedShots: [], ships: [])
        super.init(coder: coder)
        setup()
    }
    
    override func layout() {
        super.layout()
        
        let tileWidth: CGFloat = (frame.width - columnsCount - 1) / columnsCount
        let tileHeight: CGFloat = (frame.height - rowsCount - 1) / rowsCount
        var y: CGFloat = 1
        var x: CGFloat = 1

        for row in .zero..<Int(rowsCount) {
            for column in .zero..<Int(columnsCount) {
                let tile = subviews[row * 10 + column]
                tile.frame = NSRect(x: x, y: y, width: tileWidth, height: tileHeight)
                x += tileWidth + 1
                
                if state.missedShots.contains(CGPoint(x: column, y: row)) {
                    tile.layer?.backgroundColor = NSColor(named: "MissedShotColor")?.cgColor
                }
                
                if state.hitShots.contains(CGPoint(x: column, y: row)) {
                    tile.layer?.backgroundColor = NSColor(named: "DamagedShipColor")?.cgColor
                }
                
                if state.ships.contains(CGPoint(x: column, y: row)) {
                    tile.layer?.backgroundColor = NSColor(named: "ShipColor")?.cgColor
                }
            }
            y += tileHeight + 1
            x = 1
        }
    }
    
    func update(state: BattlefieldViewState) {
        self.state = state
        layoutSubtreeIfNeeded()
    }
    
    private func setup() {
        wantsLayer = true
        layer?.backgroundColor = NSColor(named: "Window Background Color")?.cgColor
        
        for _ in .zero..<Int(rowsCount * columnsCount) {
            let tile = NSView()
            tile.wantsLayer = true
            tile.layer?.backgroundColor = NSColor(named: "BattlefieldColor")?.cgColor
            tile.layer?.cornerRadius = 5
            addSubview(tile)
        }
    }
}
