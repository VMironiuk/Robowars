//
//  CGRect+MapToPoints.swift
//  RobowarsClient-macOS
//
//  Created by Volodymyr Myroniuk on 19.11.2022.
//

import Foundation

extension Array<CGRect> {
    func mapToPoints() -> [CGPoint] {
        map { CGPoint(x: $0.minX, y: $0.minY) }
    }
}
