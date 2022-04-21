//
//  CGPoint+Extension.swift
//  BSTimer
//
//  Created by 永瀬 on 2022/04/13.
//

import Foundation
import CoreGraphics

infix operator •
infix operator ×

// MARK: - CGPointの演算用のExtension
public extension CGPoint {

    static func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        
        return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }

    static func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        
        return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }

    static func * (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
        
        return CGPoint(x: lhs.x * rhs, y: lhs.y * rhs)
    }

    static func / (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
        
        return CGPoint(x: lhs.x / rhs, y: lhs.y / rhs)
    }

    static func • (lhs: CGPoint, rhs: CGPoint) -> CGFloat {
        
        return lhs.x * rhs.x + lhs.y * rhs.y
    }

    static func × (lhs: CGPoint, rhs: CGPoint) -> CGFloat {
        
        return lhs.x * rhs.y - lhs.y * rhs.x
    }

    var length²: CGFloat {
        
        return (x * x) + (y * y)
    }

    var length: CGFloat {
        
        return sqrt(self.length²)
    }

    var normalized: CGPoint {
        
        let length = self.length
        return CGPoint(x: x / length, y: y / length)
    }

}
