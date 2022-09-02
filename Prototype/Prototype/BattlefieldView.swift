//
//  BattlefieldView.swift
//  Prototype
//
//  Created by Volodymyr Myroniuk on 27.08.2022.
//

import Cocoa

class BattlefieldView: NSView {
    
    private let rowsCount: CGFloat = 10
    private let columnsCount: CGFloat = 10
    
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
        
        let tileWidth: CGFloat = (frame.width - columnsCount - 1) / columnsCount
        let tileHeight: CGFloat = (frame.height - rowsCount - 1) / rowsCount
        var y: CGFloat = 1
        var x: CGFloat = 1

        for row in .zero..<Int(rowsCount) {
            for column in .zero..<Int(columnsCount) {
                let tile = subviews[row * 10 + column]
                tile.frame = NSRect(x: x, y: y, width: tileWidth, height: tileHeight)
                x += tileWidth + 1
            }
            y += tileHeight + 1
            x = 1
        }
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
