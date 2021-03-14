<p align="center">
    НАЦІОНАЛЬНИЙ ТЕХНІЧНИЙ УНІВЕРСИТЕТ УКРАЇНИ
</p>
<p align="center">
    “КИЇВСЬКИЙ ПОЛІТЕХНІЧНИЙ ІНСТИТУТ ІМЕНІ ІГОРЯ СІКОРСЬКОГО”
</p>
<p align="center">
    Факультет інформатики та обчислювальної техніки
</p>
<p align="center">
    Кафедра обчислювальної техніки
</p>
<br/>
<br/>
<br/>
<br/>
<p align="center">
    Лабораторна робота №2
</p>
<p align="center">
    з дисципліни “Програмування мобільних систем”
</p>
<br/>
<br/>
<br/>
<br/>
<br/>
<p align="right">
    Виконав:
</p>
<p align="right">
    студент групи ІВ-82
</p>
<p align="right">
    ЗК ІВ-8223
</p>
<p align="right">
    Стародубцев Ілля
</p>
<p align="center">
    Київ 2021
</p>

## Варіант № 4
(8223 mod 6) + 1 = 4

## Скріншоти роботи додатка

![lab2](lab2.png)

## Лістинг роботи додатка

### PieChartView.swift
```swift

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
```

### GraphicView.swift

```swift
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
```

### PaintViewController.swift

```swift 
import UIKit

class PaintViewController: UIViewController {

    @IBOutlet weak var graphicView: GraphicView!
    @IBOutlet weak var pieChartView: PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func segmentControlAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            graphicView.isHidden = false
            pieChartView.isHidden = true
        case 1:
            graphicView.isHidden = true
            pieChartView.isHidden = false
        default:
            break
        }
    }
}
```
