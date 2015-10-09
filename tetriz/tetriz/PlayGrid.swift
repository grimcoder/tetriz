import UIKit
@IBDesignable
class PlayGrid: UIView {

    @IBInspectable var fillColor: UIColor = UIColor.blackColor()
    
    var matrix = Matrix()
    let unit : Int = 24
    
    override func drawRect(rect: CGRect) {
        
        for x in 0...9{
            
            for y in 0...19{
                if (matrix.array[x][y] > 0) {
                    
                    let path = UIBezierPath()
                    path.moveToPoint(CGPoint(x:x*unit+0,y:y*unit+0))
                    path.addLineToPoint(CGPoint(x:x*unit+0, y:y*unit+24))
                    path.addLineToPoint(CGPoint(x:x*unit+24, y:y*unit+24))
                    path.addLineToPoint(CGPoint(x:x*unit+24, y:y*unit+0))
                    path.closePath()
                    
                    GetColor(matrix.array[x][y]).setFill()
                    
                    path.fill()
                    
                }
                
            }
            
        }
        
    }
}
