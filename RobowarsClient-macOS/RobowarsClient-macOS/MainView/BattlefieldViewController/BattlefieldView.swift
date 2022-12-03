//
//  BattlefieldView.swift
//  RobowarsClient-macOS
//
//  Created by Volodymyr Myroniuk on 03.11.2022.
//

import Cocoa

final class BattlefieldView: NSView {
    private var battlefieldSize: CGSize = .zero
    
    override var isFlipped: Bool {
        true
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func layout() {
        super.layout()
        
        guard battlefieldSize != .zero else { return }
        
        let tileWidth: CGFloat = (frame.width - battlefieldSize.width - 1) / battlefieldSize.width
        let tileHeight: CGFloat = (frame.height - battlefieldSize.height - 1) / battlefieldSize.height
        var y: CGFloat = 1
        var x: CGFloat = 1

        (.zero..<Int(battlefieldSize.height)).forEach { row in
            (.zero..<Int(battlefieldSize.width)).forEach { column in
                let tile = tile(atRow: row, column: column)
                tile?.frame = NSRect(x: x, y: y, width: tileWidth, height: tileHeight)
                
                x += tileWidth + 1
            }
            y += tileHeight + 1
            x = 1
        }
    }
    
    func updateBattlefieldSize(_ newBattlefieldSize: CGSize) {
        battlefieldSize = newBattlefieldSize
        updateTiles(for: battlefieldSize)
        
        needsLayout = true
        layoutSubtreeIfNeeded()
    }
    
    func updateShips(with coordinates: [CGPoint]) {
        coordinates.forEach { coordinate in
            let tile = tile(atRow: Int(coordinate.y), column: Int(coordinate.x))
            tile?.state = .ship
        }
    }
    
    func updateTile(with state: TileState) {}
    
    private func setup() {
        wantsLayer = true
        layer?.backgroundColor = NSColor(named: "Window Background Color")?.cgColor
    }
    
    private func updateTiles(for battlefieldSize: CGSize) {
        subviews.forEach { $0.removeFromSuperview() }
        subviews.removeAll()
        
        (.zero..<Int(battlefieldSize.width * battlefieldSize.height)).forEach { _ in
            let tile = TileView()
            tile.wantsLayer = true
            tile.layer?.cornerRadius = 5
            tile.state = .empty
            addSubview(tile)
        }
    }
    
    private func tile(atRow row: Int, column: Int) -> TileView? {
        guard !subviews.isEmpty else { return nil }
        return subviews[row * Int(battlefieldSize.width) + column] as? TileView
    }
}
