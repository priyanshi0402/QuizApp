//
//  QuizOptionsTableViewCell.swift
//  QuizApp
//
//  Created by Dharmik Kalathiya on 2024-03-24.
//  Copyright © 2024 Priyanshi. All rights reserved.
//

import UIKit

class QuizOptionsTableViewCell: UITableViewCell {

    @IBOutlet weak var lblOptions: UILabel!
//    @IBOutlet weak var btnSelectOption: UIButton!
    
    override var accessibilityLabel: String? {
            get {
                return lblOptions.text
            }
            set {
                // Ignore setting accessibility label for this view
            }
        }
        
        override var accessibilityTraits: UIAccessibilityTraits {
            get {
                return .staticText
            }
            set {
                // Ignore setting accessibility traits for this view
            }
        }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
