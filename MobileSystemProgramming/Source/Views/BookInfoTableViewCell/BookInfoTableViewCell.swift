//
//  BookInfoTableViewCell.swift
//  MobileSystemProgramming
//
//  Created by Illia Starodubtcev on 17.04.2021.
//

import UIKit

class BookInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var fieldLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func configure(field: String, value: String) {
        fieldLabel.text = field
        valueLabel.text = value
    }
}
