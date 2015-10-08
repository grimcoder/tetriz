class Matrix {
    
    var array: [[Int]] = []
    
    var blocks = [[Int]]()
    

    func reset(){
    
        for _ in 0...9 {
            var columnArray = Array<Int>()
            for _ in 0...20 {
                columnArray.append(0)
            }
            array.append(columnArray)
        }
        
    }
    
    init(){
    
        reset()
        array[19][0] = 1
        array[19][1] = 1
        array[19][3] = 1
    }
    
}

enum Orientation{
    
    case Up
    case Down
    case Left
    case Right
    
}

enum FigureType : Int {
    case Stick
    case Cube
    case El
    case ElRev
    case S
    case SRev
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
                tmparray[0][2] = 1
                tmparray[1][2] = 1
                tmparray[2][2] = 1
                tmparray[2][1] = 1
                
            case .Left:
                tmparray[1][1] = 1
                tmparray[1][2] = 1
                tmparray[1][3] = 1
                tmparray[2][1] = 1
                
            case .Right:
                
                tmparray[1][3] = 1
                tmparray[1][2] = 1
                tmparray[1][1] = 1
                tmparray[2][3] = 1
                
            case .Up:
                tmparray[0][2] = 1
                tmparray[0][3] = 1
                tmparray[1][2] = 1
                tmparray[2][2] = 1
            }
            
        case .ElRev:
            switch orientaion{
            case .Down:
                tmparray[0][2] = 1
                tmparray[0][3] = 1
                tmparray[1][3] = 1
                tmparray[2][3] = 1
                
            case .Left:
                tmparray[1][3] = 1
                tmparray[2][1] = 1
                tmparray[2][2] = 1
                tmparray[2][3] = 1
                
            case .Right:
                tmparray[1][1] = 1
                tmparray[1][2] = 1
                tmparray[1][3] = 1
                tmparray[2][1] = 1
                
            case .Up:
                tmparray[0][2] = 1
                tmparray[1][2] = 1
                tmparray[2][2] = 1
                tmparray[2][3] = 1
            }
            
        case .Stick:
            switch orientaion{
                
            case .Right, .Left:
                tmparray[1][0] = 1
                tmparray[1][1] = 1
                tmparray[1][2] = 1
                tmparray[1][3] = 1
                
            case .Up, .Down:
                tmparray[0][2] = 1
                tmparray[1][2] = 1
                tmparray[2][2] = 1
                tmparray[3][2] = 1
            }
            
        case .S:
            switch orientaion{
                
            case .Right, .Left:
                tmparray[0][1] = 1
                tmparray[1][1] = 1
                tmparray[1][2] = 1
                tmparray[2][2] = 1
                
            case .Up, .Down:
                tmparray[1][2] = 1
                tmparray[1][3] = 1
                tmparray[2][1] = 1
                tmparray[2][2] = 1
            }
            
        case .SRev:
            switch orientaion{
                
            case .Right, .Left:
                tmparray[1][2] = 1
                tmparray[2][2] = 1
                tmparray[2][1] = 1
                tmparray[3][1] = 1
                
            case .Up, .Down:
                tmparray[1][1] = 1
                tmparray[1][2] = 1
                tmparray[2][2] = 1
                tmparray[2][3] = 1
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


