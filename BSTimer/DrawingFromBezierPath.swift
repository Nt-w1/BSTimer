//
//  DrawingFromBezierPath.swift
//  BSTimer
//
//  Created by 永瀬 on 2022/04/01.
//

import UIKit
import CoreGraphics

final class DrawingFromBezierPath {
    
    private func drawStrokeCircle(rect: CGRect, color: UIColor, value: CGFloat, lineWidth: CGFloat, onLayer: CAShapeLayer) {

        let angle = 360 * value

        let pi = CGFloat(Double.pi)
        let centerPoint = CGPoint (x: rect.width / 2.0, y: rect.width / 2.0);
        let circleRadius = CGFloat(rect.width / 2.0)
        let start:CGFloat = -1 * pi / 2.0
        let end :CGFloat = (angle/360) * pi * 2.0 - (pi / 2.0) // 終了の角度

        let circlePath = UIBezierPath(arcCenter: centerPoint,
                                      radius: circleRadius,
                                      startAngle: start,
                                      endAngle: end,
                                      clockwise: true)

        onLayer.path = circlePath.cgPath;
        onLayer.strokeColor = color.cgColor;
        onLayer.fillColor = UIColor.clear.cgColor;
        onLayer.lineCap = CAShapeLayerLineCap.round
        onLayer.lineWidth = lineWidth;
        onLayer.strokeStart = 0;
        onLayer.strokeEnd = 1;
        onLayer.backgroundColor = UIColor.clear.cgColor

    }
}
