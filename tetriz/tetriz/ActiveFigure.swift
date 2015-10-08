import UIKit

class ActiveFigure: UIView {
    
    let unit : Int = 24
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
        
        
        if (figure.array.count == 0) {}
        for x in 0...3{
            
            for y in 0...3{
                if (figure.array[x][y] == 1) {
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
