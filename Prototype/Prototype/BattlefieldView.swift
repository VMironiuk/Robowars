//
//  BattlefieldView.swift
//  Prototype
//
//  Created by Volodymyr Myroniuk on 27.08.2022.
//

import Cocoa

class BattlefieldView: NSView {
    
    private let tiles: [NSView]
    private static let rowsCount: CGFloat = 10
    private static let columnsCount: CGFloat = 10
    
    override init(frame frameRect: NSRect) {
        tiles = Self.makeTiles()

        super.init(frame: frameRect)
        setup()
    }
    
    required init?(coder: NSCoder) {
        tiles = Self.makeTiles()

        super.init(coder: coder)
        setup()
    }
    
    override func layout() {
        super.layout()
        
        let tileWidth: CGFloat = (frame.width - Self.columnsCount - 1) / Self.columnsCount
        let tileHeight: CGFloat = (frame.height - Self.rowsCount - 1) / Self.rowsCount
        var y: CGFloat = 1
        var x: CGFloat = 1

        for row in .zero..<Int(Self.rowsCount) {
            for column in .zero..<Int(Self.columnsCount) {
                let tile = tiles[row * 10 + column]
                tile.frame = NSRect(x: x, y: y, width: tileWidth, height: tileHeight)
                x += tileWidth + 1
                
                if row == 1 && column == 1 {
                    tile.layer?.backgroundColor = NSColor(named: "ShipColor")?.cgColor

                    if tile.layer?.sublayers == .none {
                        let subLayer = CALayer()
                        subLayer.frame = tile.layer!.bounds
                        subLayer.backgroundColor = NSColor(named: "DamagedShipColor")?.cgColor
                        subLayer.opacity = 0.5
                        tile.layer?.addSublayer(subLayer)
                    } else {
                        tile.layer?.sublayers?.forEach { $0.frame = tile.layer!.bounds }
                    }
                }
            }
            y += tileHeight + 1
            x = 1
        }
    }
    
    private func setup() {
        wantsLayer = true
        layer?.backgroundColor = .black
        tiles.forEach { addSubview($0) }
    }
    
    private static func makeTiles() -> [NSView] {
        var tempTiles: [NSView] = []
        for _ in .zero..<Int(Self.rowsCount * Self.columnsCount) {
            let tile = NSView()
            tile.wantsLayer = true
            tile.layer?.backgroundColor = NSColor(named: "BattlefieldColor")?.cgColor
            tempTiles.append(tile)
        }
        return tempTiles
    }
}
