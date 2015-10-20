import UIKit

class Matrix {
    
    var array = [[1,2],[2,2]]
    
    var blocks = [[Int]]()
    
    func reset(){
        array = []
        for _ in 0...PlayGrid.width - 1 {
            var columnArray = Array<Int>()
            for _ in 0...PlayGrid.height - 1 {
                columnArray.append(0)
            }
            array.append(columnArray)
        }
    }
    
    init(){
        reset()
    }
}

enum Orientation{
    
    case Up
    case Down
    case Left
    case Right
    
}

enum FigureType : Int {

    case El
    case ElRev
    case Pyramide
    case S
    case SRev

    case Stick
    case Cube
    
    
    static var count: UInt32 {  // I called this "maximumRawValue" in the post
        var max: UInt32 = 0
        while let _ = self.init(rawValue: (Int)(++max)) {}
        return max
    }
    
}

func GetColor(num: Int) -> UIColor{
    
    switch(num){
    case 1: return UIColor.brownColor()
    case 2: return UIColor.redColor()
    case 3: return UIColor.cyanColor()
    case 4: return UIColor.magentaColor()
    case 5: return UIColor.greenColor()
    case 6: return UIColor.orangeColor()
    case 7: return UIColor.purpleColor()
    default:return UIColor.blackColor()
    }

}


class Figure {

    var array: [[Int]] = []
    
    var orientaion: Orientation = Orientation.Up
    var x : Int = 2
    var y: Int = -2
    var type: FigureType = FigureType.Stick
    
    init(fromFigure:Figure){
        self.orientaion = fromFigure.orientaion
        self.type = fromFigure.type
        self.x = fromFigure.x
        self.y=fromFigure.y
        self.array = fromFigure.array
        array = initArray()
    }
    
    init(fromOrientation orient: Orientation, fromType type: FigureType, x:Int, y:Int ){

        self.orientaion = orient
        self.type = type
        self.x = x
        self.y=y
        array = initArray()
    }
    
    func rotateCCW(){
        
        switch orientaion{
        case .Down:     orientaion = .Right
        case .Left:     orientaion = .Down
        case .Right:    orientaion = .Up
        case .Up:       orientaion = .Left
            
        }
        
        array = initArray()
    }
    
    func rotateCW(){
        switch orientaion{
        case .Down:     orientaion = .Left
        case .Left:     orientaion = .Up
        case .Right:    orientaion = .Down
        case .Up:       orientaion = .Right
            
        }
        
        array = initArray()
    }
    
    
    func initArray() -> [[Int]] {
    
        var tmparray : [[Int]] = []
        tmparray = reset(tmparray)
        
        switch type{
            
        case .Cube:
            switch orientaion{
            case .Down, .Up, .Left, .Right:
                tmparray[1][1] = 1
                tmparray[1][2] = 1
                tmparray[2][1] = 1
                tmparray[2][2] = 1
            }
            
        case .El:
            switch orientaion{
                
            case .Down:
                tmparray[0][1] = 2
                tmparray[1][1] = 2
                tmparray[2][1] = 2
                tmparray[2][0] = 2
                
            case .Left:
                
                tmparray[1][0] = 2
                tmparray[1][1] = 2
                tmparray[1][2] = 2
                tmparray[0][0] = 2

                
            case .Right:
                tmparray[1][2] = 2
                tmparray[1][1] = 2
                tmparray[1][0] = 2
                tmparray[2][2] = 2

                
            case .Up:
                tmparray[0][1] = 2
                tmparray[0][2] = 2
                tmparray[1][1] = 2
                tmparray[2][1] = 2
            }
            
        case .ElRev:
            switch orientaion{
            case .Down:
                tmparray[0][1] = 3
                tmparray[0][2] = 3
                tmparray[1][2] = 3
                tmparray[2][2] = 3
                
            case .Left:
                tmparray[1][2] = 3
                tmparray[2][0] = 3
                tmparray[2][1] = 3
                tmparray[2][2] = 3
                
            case .Right:
                tmparray[1][0] = 3
                tmparray[1][1] = 3
                tmparray[1][2] = 3
                tmparray[2][0] = 3
                

                
            case .Up:
                tmparray[0][1] = 3
                tmparray[1][1] = 3
                tmparray[2][1] = 3
                tmparray[2][2] = 3
            }
            
        case .Pyramide:
            switch orientaion{
            case .Down:
                tmparray[0][1] = 4
                tmparray[1][1] = 4
                tmparray[2][1] = 4
                tmparray[1][2] = 4
                
            case .Left:
                tmparray[1][0] = 4
                tmparray[1][1] = 4
                tmparray[1][2] = 4
                tmparray[2][1] = 4
                
            case .Right:
                
                tmparray[1][0] = 4
                tmparray[1][1] = 4
                tmparray[1][2] = 4
                tmparray[0][1] = 4
                
            case .Up:
                tmparray[0][1] = 4
                tmparray[1][1] = 4
                tmparray[2][1] = 4
                tmparray[1][0] = 4
            }
            
            
        case .Stick:
            switch orientaion{
                
            case .Right, .Left:
                tmparray[1][0] = 5
                tmparray[1][1] = 5
                tmparray[1][2] = 5
                tmparray[1][3] = 5
                
            case .Up, .Down:
                tmparray[0][2] = 5
                tmparray[1][2] = 5
                tmparray[2][2] = 5
                tmparray[3][2] = 5
            }
            
        case .S:
            switch orientaion{
                
            case .Right, .Left:
                tmparray[0][1] = 6
                tmparray[1][1] = 6
                tmparray[1][2] = 6
                tmparray[2][2] = 6
                
            case .Up, .Down:
                tmparray[1][2] = 6
                tmparray[1][3] = 6
                tmparray[2][1] = 6
                tmparray[2][2] = 6
            }
            
        case .SRev:
            switch orientaion{
                
            case .Right, .Left:
                tmparray[1][2] = 7
                tmparray[2][2] = 7
                tmparray[2][1] = 7
                tmparray[3][1] = 7
                
            case .Up, .Down:
                tmparray[1][1] = 7
                tmparray[1][2] = 7
                tmparray[2][2] = 7
                tmparray[2][3] = 7
            }
        }
        return tmparray
    
    }
    
    func reset(var array: [[Int]]) -> [[Int]] {
        
        array  = []
        for _ in 0...3 {
            
            var columnArray = Array<Int>()
            for _ in 0...3 {
                columnArray.append(0)
            }
            array.append(columnArray)
        }
        
        return array
    }
}


