//
//  PieChartView.swift
//  MobileSystemProgramming
//
//  Created by Illia Starodubtcev on 21.02.2021.
//

import UIKit

class PieChartView: UIView {
    
    private var units = [Unit(value: 0.15, color: .yellow),
                         Unit(value: 0.25, color: .brown),
                         Unit(value: 0.45, color: .gray),
                         Unit(value: 0.1, color: .red),
                         Unit(value: 0.05, color: .purple)
    
    ]
        
    override func draw(_ rect: CGRect) {
        
        var lastAngle: CGFloat = 0
        
        units.forEach { unit in
            
            let path = UIBezierPath()
            let endAngle: CGFloat = lastAngle + CGFloat(unit.value * 2 * Double.pi)
            let radius = frame.width / 3
            
            path.addArc(withCenter: CGPoint(x: frame.width / 2, y: frame.height / 2),
                        radius: radius,
                        startAngle: lastAngle,
                        endAngle: endAngle,
                        clockwise: true)
            
            path.lineWidth = radius / 3
            unit.color.setStroke()
            path.stroke()
            
            lastAngle = endAngle
        }
    }
    struct Unit {
        let value: Double
        let color: UIColor
    }
}
