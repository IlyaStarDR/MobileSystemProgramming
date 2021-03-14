//
//  GraphicView.swift
//  MobileSystemProgramming
//
//  Created by Illia Starodubtcev on 21.02.2021.
//

import UIKit

class GraphicView: UIView {
    
    let startPoint: Double = -3.0
    let endPoint: Double = 3.0
    let offset: Double = 20
    let arrowWidth: Double = 4
    let arrowHeight: Double = 7
    
    var width: Double {
        return Double(frame.width)
    }
    
    var height: Double {
        return Double(frame.height)
    }
    
    var equivalentUnit: Double {
        return height / (exp(endPoint) + offset * 2)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        drawChart()
        drawLines()
    }
    
    private func drawChart() {
        
        let chartPath = UIBezierPath()
        
        chartPath.lineWidth = 1.5
        UIColor.blue.setStroke()
        
        chartPath.move(to: getYPoint(for: startPoint))
        
        for pointX in stride(from: startPoint, through: endPoint + 0.01, by: 0.1) {
            chartPath.addLine(to: getYPoint(for: pointX))
        }
        chartPath.stroke()
    }
    
    private func drawLines() {
        
        let line = UIBezierPath()
        line.lineWidth = 1.0
        UIColor.black.setStroke()
        
        let xEndPoint = CGPoint(x: width - offset, y: height / 2)
        let yEndPoint = CGPoint(x: width / 2, y: offset)
        
        line.move(to: CGPoint(x: offset, y: height / 2))
        line.addLine(to: xEndPoint)
        
        line.move(to: CGPoint(x: width / 2, y: height - offset))
        line.addLine(to: yEndPoint)
        
        line.move(to: CGPoint(x: width - offset - arrowHeight, y: height / 2 - arrowWidth))
        line.addLine(to: xEndPoint)
        line.move(to: CGPoint(x: width - offset - arrowHeight, y: height / 2 + arrowWidth))
        line.addLine(to: xEndPoint)
        
        line.move(to: CGPoint(x: width / 2 - arrowWidth, y: arrowHeight + offset))
        line.addLine(to: yEndPoint)
        line.move(to: CGPoint(x: width / 2 + arrowWidth, y: arrowHeight + offset))
        line.addLine(to: yEndPoint)
        
        line.move(to: CGPoint(x: width / 2 + startPoint * startPoint * equivalentUnit, y: height / 2 + offset / 2))
        line.addLine(to: CGPoint(x: width / 2 + startPoint * startPoint * equivalentUnit, y: height / 2 - offset / 2))
        
        line.move(to: CGPoint(x: width / 2 + offset / 2, y: height / 2  - startPoint * startPoint * equivalentUnit))
        line.addLine(to: CGPoint(x: width / 2 - offset / 2, y: height / 2  - startPoint * startPoint * equivalentUnit))
        
        line.stroke()
    }
    
    private func getYPoint(for x: Double) -> CGPoint {
        
        return CGPoint(x: (endPoint - startPoint) / 1.5 * x * equivalentUnit + (width / 2),
                       y: -pow(x, 3) * equivalentUnit + (height / 2))
    }
}
