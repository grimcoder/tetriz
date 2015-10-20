import UIKit

class ActiveFigure: UIView {
    
    
    @IBInspectable var fillColor: UIColor = UIColor.blackColor()
    
    var figure: Figure = Figure(fromOrientation: Orientation.Up, fromType: FigureType.El, x:0, y:0){
        didSet{
            setNeedsDisplay()
        }
    }
    
    func rotateCCW(){
        figure.rotateCCW()
        setNeedsDisplay()
    }

    
    func rotateCW(){
        figure.rotateCW()
        setNeedsDisplay()
    }

    
    override func drawRect(rect: CGRect) {
        
        let unit : Int = PlayGrid.unit
        if (figure.array.count == 0) {}
        for x in 0...3{
            
            for y in 0...3{
                if (figure.array[x][y] > 0) {
                let path = UIBezierPath()
                path.moveToPoint(CGPoint(x:x*unit+0,y:y*unit+0))
                path.addLineToPoint(CGPoint(x:x*unit+0, y:y*unit+unit))
                path.addLineToPoint(CGPoint(x:x*unit+unit, y:y*unit+unit))
                path.addLineToPoint(CGPoint(x:x*unit+unit, y:y*unit+0))
                path.closePath()
                
                GetColor(figure.array[x][y]).setFill()
                    path.fill()
                    
                }
                
            }
            
        }
        

    }
}
