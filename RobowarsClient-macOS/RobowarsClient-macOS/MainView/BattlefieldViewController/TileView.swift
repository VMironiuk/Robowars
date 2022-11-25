//
//  TileView.swift
//  RobowarsClient-macOS
//
//  Created by Volodymyr Myroniuk on 03.11.2022.
//

import Cocoa

enum TileViewState {
    case empty
    case miss
    case damage
    case ship
}

final class TileView: NSView {
    
    var state: TileViewState = .empty {
        didSet {
            needsDisplay = true
        }
    }

    override func draw(_ dirtyRect: NSRect) {
        switch state {
        case .miss:
            layer?.backgroundColor = NSColor(named: "MissedShotColor")?.cgColor
            
            NSGraphicsContext.saveGraphicsState()
            
            NSColor.white.set()
            
            let innerOvalPath = NSBezierPath()

            innerOvalPath.lineWidth = 10
            innerOvalPath.appendOval(in: NSRect(
                x: bounds.minX + 20,
                y: bounds.minY + 20,
                width: bounds.width - 20 * 2,
                height: bounds.height - 20 * 2)
            )
            innerOvalPath.stroke()
            
            let outerOvalPath = NSBezierPath()
            
            outerOvalPath.lineWidth = 3
            outerOvalPath.appendOval(in: NSRect(
                x: bounds.minX + 10,
                y: bounds.minY + 10,
                width: bounds.width - 10 * 2,
                height: bounds.height - 10 * 2)
            )
            outerOvalPath.stroke()
                    
            NSGraphicsContext.restoreGraphicsState()
            
        case .damage:
            layer?.backgroundColor = NSColor(named: "DamagedShipColor")?.cgColor
            
            NSGraphicsContext.saveGraphicsState()
            
            NSColor.white.set()
            
            let crossedLinesPath = NSBezierPath()
                    
            crossedLinesPath.lineWidth = 7
            crossedLinesPath.lineCapStyle = .round

            crossedLinesPath.move(to: NSPoint(x: 15, y: 15))
            crossedLinesPath.line(to: NSPoint(x: bounds.width - 15, y: bounds.height - 15))
            crossedLinesPath.stroke()
            
            crossedLinesPath.move(to: NSPoint(x: 15, y: bounds.height - 15))
            crossedLinesPath.line(to: NSPoint(x: bounds.width - 15, y: 15))
            crossedLinesPath.stroke()
            NSGraphicsContext.restoreGraphicsState()
            
        case .empty:
            layer?.backgroundColor = NSColor(named: "BattlefieldColor")?.cgColor
            
        case .ship:
            layer?.backgroundColor = NSColor(named: "ShipColor")?.cgColor
        }
    }
}
