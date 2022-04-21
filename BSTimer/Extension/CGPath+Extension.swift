//
//  CGPath+Extension.swift
//  BSTimer
//
//  Created by 永瀬 on 2022/04/13.
//

import Foundation
import CoreGraphics

/// CGPathの情報をカスタムEnumで扱う
public enum PathElement {
    
    case moveToPoint(CGPoint)
    case addLineToPoint(CGPoint)
    case addQuadCurveToPoint(CGPoint, CGPoint)
    case addCurveToPoint(CGPoint, CGPoint, CGPoint)
    case closeSubpath
}

/// PathElement(CGPath情報)を持つクラス
class Info {
    
    var pathElements = [PathElement]()
}

// MARK: - CGPath拡張
extension CGPath {

    /// Cのコールバックであるapply(info: UnsafeMutablePointer?, function: CGPathApplierFunction)をカスタムEnumのPathElementとして取得する
    var pathElements: [PathElement] {
        
        var info = Info()
        
        // CGPathの情報を取得する
        // コールバックで取得した情報をわかりやすく整形する
        self.apply(info: &info) { (info, element) -> Void in

            if let infoPointer = UnsafeMutablePointer<Info>(OpaquePointer(info)) {
                
                switch element.pointee.type {
                    
                case .moveToPoint:
                    let pt = element.pointee.points[0]
                    infoPointer.pointee.pathElements.append(PathElement.moveToPoint(pt))
                    
                case .addLineToPoint:
                    let pt = element.pointee.points[0]
                    infoPointer.pointee.pathElements.append(PathElement.addLineToPoint(pt))
                    
                case .addQuadCurveToPoint:
                    let pt1 = element.pointee.points[0]
                    let pt2 = element.pointee.points[1]
                    infoPointer.pointee.pathElements.append(PathElement.addQuadCurveToPoint(pt1, pt2))
                    
                case .addCurveToPoint:
                    let pt1 = element.pointee.points[0]
                    let pt2 = element.pointee.points[1]
                    let pt3 = element.pointee.points[2]
                    infoPointer.pointee.pathElements.append(PathElement.addCurveToPoint(pt1, pt2, pt3))
                    
                case .closeSubpath:
                    infoPointer.pointee.pathElements.append(PathElement.closeSubpath)
                    
                @unknown default:
                    return
                }
            }
        }
        return info.pathElements
    }
}
