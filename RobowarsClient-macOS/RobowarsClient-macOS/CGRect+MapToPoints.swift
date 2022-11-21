//
//  CGRect+MapToPoints.swift
//  RobowarsClient-macOS
//
//  Created by Volodymyr Myroniuk on 19.11.2022.
//

import Foundation

extension Array<CGRect> {
    func mapToPoints() -> [CGPoint] {
        flatMap { $0.mapToPoints() }
    }
}

extension CGRect {
    func mapToPoints() -> [CGPoint] {
        var points: [CGPoint] = []
        for x in Int(minX)..<Int(maxX) {
            for y in Int(minY)..<Int(maxY) {
                points.append(CGPoint(x: x, y: y))
            }
        }
        
        return points
    }
}
