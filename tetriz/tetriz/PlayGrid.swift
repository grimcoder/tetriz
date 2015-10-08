//
//  PlayGrid.swift
//  tetriz
//

//  Created by Taras Kovtun on 10/4/15.
//  Copyright © 2015 Taras Kovtun. All rights reserved.
//

import UIKit
@IBDesignable
class PlayGrid: UIView {
    var matrix : Matrix = Matrix()
    let unit = 24
    override func drawRect(rect: CGRect) {
        
        for x in 0...10{
            
            for y in 0...20{
                if (matrix.array[x][y] == 1) {
                    let path = UIBezierPath()
                    path.moveToPoint(CGPoint(x:x*unit+0,y:y*unit+0))
                    path.addLineToPoint(CGPoint(x:x*unit+0, y:y*unit+24))
                    path.addLineToPoint(CGPoint(x:x*unit+24, y:y*unit+24))
                    path.addLineToPoint(CGPoint(x:x*unit+24, y:y*unit+0))
                    path.closePath()
                    
                    fillColor.setFill()
                    path.fill()
                    
                }
                
            }
            
        }
        
    }
}
