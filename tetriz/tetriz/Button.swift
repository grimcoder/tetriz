//
//  Button.swift
//  tetriz
//
//  Created by Taras Kovtun on 10/4/15.
//  Copyright © 2015 Taras Kovtun. All rights reserved.
//

import UIKit

@IBDesignable
class Button: UIButton {

    @IBInspectable var fillColor: UIColor = UIColor.greenColor()
    @IBInspectable var isAddButton: Bool = true
    @IBInspectable  var plusHeight: CGFloat = 3.0
    @IBInspectable  var cornerRadius: CGFloat = 25.0
    
    override func drawRect(rect: CGRect) {
        
        let path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
        fillColor.setFill()
        path.fill()
    
    }
    
}
