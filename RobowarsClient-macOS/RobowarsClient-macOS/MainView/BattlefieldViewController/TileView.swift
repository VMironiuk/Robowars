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

            innerOvalPath.lineWidth = min(dirtyRect.width, dirtyRect.height) / 6
            innerOvalPath.appendOval(in: NSRect(
                x: bounds.minX + dirtyRect.width / 3,
                y: bounds.minY + dirtyRect.height / 3,
                width: bounds.width - (dirtyRect.width / 3) * 2,
                height: bounds.height - (dirtyRect.height / 3) * 2)
            )
            innerOvalPath.stroke()
            
            let outerOvalPath = NSBezierPath()

            outerOvalPath.lineWidth = min(dirtyRect.width, dirtyRect.height) / 14
            outerOvalPath.appendOval(in: NSRect(
                x: bounds.minX + dirtyRect.width / 6,
                y: bounds.minY + dirtyRect.height / 6,
                width: bounds.width - (dirtyRect.width / 6) * 2,
                height: bounds.height - (dirtyRect.height / 6) * 2)
            )
            outerOvalPath.stroke()
                    
            NSGraphicsContext.restoreGraphicsState()
            
        case .damage:
            layer?.backgroundColor = NSColor(named: "DamagedShipColor")?.cgColor
            
            NSGraphicsContext.saveGraphicsState()
            
            NSColor.white.set()
            
            let crossedLinesPath = NSBezierPath()
                    
            crossedLinesPath.lineWidth = min(dirtyRect.width, dirtyRect.height) / 8
            crossedLinesPath.lineCapStyle = .round

            crossedLinesPath.move(to: NSPoint(x: dirtyRect.width / 4, y: dirtyRect.height / 4))
            crossedLinesPath.line(to: NSPoint(x: bounds.width - dirtyRect.width / 4, y: bounds.height - dirtyRect.height / 4))
            crossedLinesPath.stroke()
            
            crossedLinesPath.move(to: NSPoint(x: dirtyRect.width / 4, y: bounds.height - dirtyRect.height / 4))
            crossedLinesPath.line(to: NSPoint(x: bounds.width - dirtyRect.width / 4, y: dirtyRect.height / 4))
            crossedLinesPath.stroke()
            NSGraphicsContext.restoreGraphicsState()
            
        case .empty:
            layer?.backgroundColor = NSColor(named: "BattlefieldColor")?.cgColor
            
        case .ship:
            layer?.backgroundColor = NSColor(named: "ShipColor")?.cgColor
        }
    }
}
