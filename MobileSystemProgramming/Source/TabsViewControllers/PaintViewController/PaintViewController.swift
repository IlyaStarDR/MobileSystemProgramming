//
//  PaintViewController.swift
//  MobileSystemProgramming
//
//  Created by Illia Starodubtcev on 21.02.2021.
//

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

