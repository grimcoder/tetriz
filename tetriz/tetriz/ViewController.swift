//
//  ViewController.swift
//  tetriz
//
//  Created by Taras Kovtun on 10/3/15.
//  Copyright © 2015 Taras Kovtun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    var gameTimer: NSTimer!
    let tick = 0.3
    let unit : Int = 24
    
    @IBOutlet weak var playGrid: PlayGrid!
    
    var activeFigure: ActiveFigure!
    
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
                if (arr[x][y] == 1 && (y + testFigure.y > 19  || x + testFigure.x < 0 || x + testFigure.x > 9 )) {
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
        activeFigure.frame.offsetInPlace(dx: 24, dy: 0)
    }
    
    
    @IBAction func Bottom(sender: AnyObject) {
        
        if (canMoveDown(activeFigure.figure.array) != true) {
            return}
        activeFigure.frame.offsetInPlace(dx: 0, dy: 24)
        activeFigure.figure.y++
    }
    
    @IBAction func Left(sender: AnyObject) {
        
        if (canMoveLeft(activeFigure.figure.array) != true) {
            return}
        activeFigure.figure.x--
        activeFigure.frame.offsetInPlace(dx: -24, dy: 0)
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
            activeFigure.frame.offsetInPlace(dx: 0, dy: 24)
        }
        else
        {
            activeFigure.figure.y = -2
            CreateNewActiveFigure()
            
            
        }
        
        //self.view.setNeedsDisplay()
        
    }
    
    func CreateNewActiveFigure(){
        
        let rand = arc4random_uniform(6)
        let startX = 2
        let startY = -2
        
        activeFigure = ActiveFigure(frame: CGRectMake(CGFloat(startX * 24), CGFloat(startY * 24), 96, 96))
        
        activeFigure.backgroundColor = UIColor.clearColor()
        activeFigure.tag = 100
        activeFigure.userInteractionEnabled = true
        activeFigure.fillColor = UIColor.orangeColor()
        activeFigure.figure = Figure(fromOrientation: Orientation.Up, fromType: FigureType(rawValue: Int(rand))!, x:startX, y:startY)
        
        playGrid.addSubview(activeFigure)
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        CreateNewActiveFigure()
        //gameTimer = NSTimer.scheduledTimerWithTimeInterval(tick, target: self, selector: "runTimedCode", userInfo: nil, repeats: true)
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

