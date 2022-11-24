//
//  CGRect+MapToPoints.swift
//  RobowarsClient-macOS
//
//  Created by Volodymyr Myroniuk on 19.11.2022.
//

import Foundation

extension Array<CGRect> {
    var points: [CGPoint] {
        flatMap { $0.points }
    }
}

extension CGRect {
    var points: [CGPoint] {
        var points: [CGPoint] = []
        for x in Int(minX)..<Int(maxX) {
            for y in Int(minY)..<Int(maxY) {
                points.append(CGPoint(x: x, y: y))
            }
        }
        
        return points
    }
}
