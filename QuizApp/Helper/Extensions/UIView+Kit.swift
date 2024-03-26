//
//  UIView+Kit.swift
//  QuizApp
//
//  Created by Priyanshi Bhikadiya on 2024-03-24.
//  Copyright © 2024 Priyanshi. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    public class func fromNib<T: UIView>() -> T? {
        let name = String(describing: Self.self)
        guard let nib = Bundle(for: Self.self).loadNibNamed(
            name, owner: nil, options: nil)
        else {
            fatalError("Missing nib-file named: \(name)")
        }
        return nib.first as? T
    }
}

@IBDesignable extension UIView {
    @IBInspectable var ViewRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
}
