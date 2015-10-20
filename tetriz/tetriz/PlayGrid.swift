import UIKit
@IBDesignable
class PlayGrid: UIView {

    @IBInspectable var fillColor: UIColor = UIColor.blackColor()
    
    var matrix = Matrix()
    
    static var  unit : Int = 18
    static let width : Int = 10
    static let height: Int = 20
    
    override func drawRect(rect: CGRect) {
        
        for x in 0...PlayGrid.width - 1{
            
            for y in 0...PlayGrid.height-1{
                if (matrix.array[x][y] > 0) {
                    
                    let path = UIBezierPath()
                    path.moveToPoint(CGPoint(x:x*PlayGrid.unit+0,y:y*PlayGrid.unit+0))
                    path.addLineToPoint(CGPoint(x:x*PlayGrid.unit+0, y:y*PlayGrid.unit+PlayGrid.unit))
                    path.addLineToPoint(CGPoint(x:x*PlayGrid.unit+PlayGrid.unit, y:y*PlayGrid.unit+PlayGrid.unit))
                    path.addLineToPoint(CGPoint(x:x*PlayGrid.unit+PlayGrid.unit, y:y*PlayGrid.unit+0))
                    path.closePath()
                    
                    GetColor(matrix.array[x][y]).setFill()
                    
                    path.fill()
                    
                }
                
            }
            
        }
        
    }
}
