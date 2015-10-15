//
//  ViewController.swift
//  tetriz
//
//  Created by Taras Kovtun on 10/3/15.
//  Copyright © 2015 Taras Kovtun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var LinesText: UILabel!
    @IBOutlet weak var MaxLines: UILabel!
    let swipeRec = UISwipeGestureRecognizer()
    @IBOutlet weak var NextFigureCanvas: UIView!
    var gameTimer: NSTimer!
    var tick = 0.5
    let unit : Int = 24
    var lines = 0;
    var max = 0;
    
    @IBOutlet var playGrid: PlayGrid!
    
    var activeFigure: ActiveFigure!
    
    var nextFigure: ActiveFigure?
    
    func  canMoveRight(arr:[[Int]]) ->Bool {
        
        let testFigure = Figure(fromFigure: activeFigure.figure)
        testFigure.x++
        return inBounds(testFigure)
        
    }

    
    func  canMoveLeft(arr:[[Int]]) ->Bool {
        let testFigure = Figure(fromFigure: activeFigure.figure)
        testFigure.x--
        return inBounds(testFigure)
    }
    
    
    func  canMoveDown(arr:[[Int]]) ->Bool {
        let testFigure = Figure(fromFigure: activeFigure.figure)
        testFigure.y++
        return inBounds(testFigure)
    }
    
    func canRotateCW(arr:[[Int]])->Bool {
        let testFigure = Figure(fromFigure: activeFigure.figure)
        testFigure.rotateCW()
        return inBounds(testFigure)
    }
    
    func inBounds(testFigure:Figure) -> Bool {
        let arr = testFigure.array
        for (x, column) in arr.enumerate() {
            
            for (y, _) in column.enumerate() {
                
                if (arr[x][y] > 0 && (y + testFigure.y > 19  || x + testFigure.x < 0 || x + testFigure.x > 9  ||
                    (y + testFigure.y > 0 && playGrid.matrix.array[x + testFigure.x][y + testFigure.y] > 0)))
                {
                    return false
                }
                
            }
        }
        return true
    }
    
    func canRotateCCW(arr:[[Int]])->Bool {
        let testFigure = Figure(fromFigure: activeFigure.figure)
        testFigure.rotateCCW()
        
        return inBounds(testFigure)
    }
    
    
    @IBAction func Right(sender: AnyObject) {
        
        
        if (canMoveRight(activeFigure.figure.array	) != true) {
            return}
        
        activeFigure.figure.x++
        activeFigure.frame.offsetInPlace(dx: CGFloat(unit), dy: 0)
    }
    
    
    @IBAction func Bottom(sender: AnyObject) {
        
        if (canMoveDown(activeFigure.figure.array) != true) {
            return}
        activeFigure.frame.offsetInPlace(dx: 0, dy: CGFloat(unit))
        activeFigure.figure.y++
        Bottom(self)
    }
    
    @IBAction func Left(sender: AnyObject) {
        
        if (canMoveLeft(activeFigure.figure.array) != true) {
            return}
        activeFigure.figure.x--
        activeFigure.frame.offsetInPlace(dx: -1 * CGFloat(unit), dy: 0)
    }
    
    @IBAction func RotateCW(sender: AnyObject) {
        if (canRotateCW(activeFigure.figure.array)){
        activeFigure.rotateCW()
        }
    }
    
    @IBAction func RotateCCW(sender: AnyObject) {
        if (canRotateCCW(activeFigure.figure.array)){
            activeFigure.rotateCCW()
        }
    }
    
    @IBOutlet weak var Right: Button!
    
    func runTimedCode() {
        
        if  canMoveDown(activeFigure.figure.array)
        {
            activeFigure.figure.y++
            activeFigure.frame.offsetInPlace(dx: 0, dy: CGFloat(unit))
        }
        else
        {
            //merge figure to matrix 
            
            for (x, column) in activeFigure.figure.array.enumerate() {
                for (y, _) in column.enumerate() {
                    
                    if (activeFigure.figure.array[x][y] > 0){
                        
                        playGrid.matrix.array[x + activeFigure.figure.x][y + activeFigure.figure.y] = activeFigure.figure.array[x][y]
                        
                    }
                    
                }
            }
            
            removeFullLines()
            
            playGrid.setNeedsDisplay()
            activeFigure.removeFromSuperview()
            activeFigure = nil
            
            CreateNewActiveFigure()
        }
        
        //self.view.setNeedsDisplay()
        
    }
    
    func removeFullLines(){
        for var y = 19; y>0; --y{
            if (getRow(y, arr: playGrid.matrix.array).filter({$0 > 0}).count == 10 ){
                
                playGrid.matrix.array = removeRow(y, arr: playGrid.matrix.array)
                
                y++
                lines++
                
                if (max < lines){
                    max = lines
                    
                    let defaults = NSUserDefaults.standardUserDefaults()
                    defaults.setInteger(lines, forKey: "max")
                    MaxLines.text = String(max)
                    
                }
                LinesText.text = "\(lines)"
            }
        }
    }
    
    func getRow(index: Int, arr: [[Int]]) -> [Int] {
        return arr.map({i in i[index]})
    }
    
    func removeRow(index: Int, arr: [[Int]]) -> [[Int]] {
        return arr.map({(var item)  in
            item.removeAtIndex(index)
            item.insert(0, atIndex:0)
            return item  })
    }

    func CreateNewActiveFigure(){

        let startX = 2
        let startY = -2

        if (nextFigure == nil){
            nextFigure = ActiveFigure(frame: CGRectMake(0, 0, 96, 96))
            nextFigure!.backgroundColor = UIColor.clearColor()
            nextFigure!.tag = 100
            nextFigure!.userInteractionEnabled = true
            //nextFigure!.fillColor = UIColor.orangeColor()
            nextFigure!.figure = Figure(fromOrientation: Orientation.Up, fromType: FigureType(rawValue: Int(arc4random_uniform(7)))!, x:startX, y:startY)
            
            NextFigureCanvas.addSubview(nextFigure!)
        }
        
        nextFigure?.removeFromSuperview()
        activeFigure = nextFigure
        activeFigure.frame.offsetInPlace(dx: CGFloat(startX * unit), dy: CGFloat(startY * unit))
        playGrid.addSubview(activeFigure)
        
        nextFigure = ActiveFigure(frame: CGRectMake(CGFloat(0), CGFloat(0), 96, 96))
        nextFigure!.backgroundColor = UIColor.clearColor()
        nextFigure!.tag = 100
        nextFigure!.userInteractionEnabled = true
        //nextFigure!.fillColor = UIColor.orangeColor()
        nextFigure!.figure = Figure(fromOrientation: Orientation.Up, fromType: FigureType(rawValue: Int(arc4random_uniform(7)))!, x:startX, y:startY)
        
        NextFigureCanvas.addSubview(nextFigure!)
        
    }
    
    func swipedView(){
//        let tapAlert = UIAlertController(title: "Swiped", message: "You just swiped the swipe view", preferredStyle: UIAlertControllerStyle.Alert)
//        tapAlert.addAction(UIAlertAction(title: "OK", style: .Destructive, handler: nil))
//        self.presentViewController(tapAlert, animated: true, completion: nil)
    }
    
    let panRec = UIPanGestureRecognizer()
    var step = 0
    
    func draggedView(sender:UIPanGestureRecognizer){
        
        self.view.bringSubviewToFront(sender.view!)
        let translation = sender.translationInView(self.view)

//        sender.view!.center = CGPointMake(sender.view!.center.x + translation.x, sender.view!.center.y + translation.y)
//        sender.setTranslation(CGPointZero, inView: self.view)
        
        step++
        print ("x:\(translation.x)")
        print ("y:\(translation.y)")
        print (step)
        if (step == 5) {
            
            step=0
            
            if (abs(translation.y) > abs(translation.x)) {
                if (translation.y < 0) {
                    RotateCW(self)
                }
                else{
                    Bottom(self)
                }
                return
            }
            
            if (translation.x>0){
                Right(self)
            }
            else{
                Left(self)
            }
        }
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.addGestureRecognizer(swipeRec)
        
           self.view.addGestureRecognizer(panRec)
        panRec.addTarget(self, action: "draggedView:")
        swipeRec.addTarget(self, action: "swipedView")
        let defaults = NSUserDefaults.standardUserDefaults()
        if let name = defaults.stringForKey("max")
        {
            max = Int(name)!
            MaxLines.text = name
        }
        
        CreateNewActiveFigure()
        gameTimer = NSTimer.scheduledTimerWithTimeInterval(tick, target: self, selector: "runTimedCode", userInfo: nil, repeats: true)
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

