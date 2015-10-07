//
//  ViewController.swift
//  tetriz
//
//  Created by Taras Kovtun on 10/3/15.
//  Copyright © 2015 Taras Kovtun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var matrix : Matrix = Matrix()
    var gameTimer: NSTimer!
    let tick = 0.3
    var position = 0;
    let unit : Int = 24
    
    @IBOutlet weak var playGrid: PlayGrid!
    
    var activeFigure: ActiveFigure!
    
    @IBAction func Right(sender: AnyObject) {
        activeFigure.frame.offsetInPlace(dx: 24, dy: 0)
    }
    
    @IBAction func Up(sender: AnyObject) {
        //activeFigure.frame.offsetInPlace(dx: 0, dy: -24)
    }
    
    @IBAction func Bottom(sender: AnyObject) {
        activeFigure.frame.offsetInPlace(dx: 0, dy: 24)
        position++
    }
    
    @IBAction func Left(sender: AnyObject) {
        activeFigure.frame.offsetInPlace(dx: -24, dy: 0)
    }
    
    @IBAction func RotateCW(sender: AnyObject) {
        activeFigure.rotateCW()
    }
    
    @IBAction func RotateCCW(sender: AnyObject) {
        activeFigure.rotateCCW()
    }
    
    @IBOutlet weak var Right: Button!
    
    func runTimedCode() {
        if  position < 22
        {
            position++
            activeFigure.frame.offsetInPlace(dx: 0, dy: 24)
        }
        else
        {
            
            CreateNewActiveFigure()
            
            position = 0
        }
        
        //self.view.setNeedsDisplay()
        
    }
    
    func CreateNewActiveFigure(){
        let rand = arc4random_uniform(6)
        activeFigure = ActiveFigure(frame: CGRectMake(48, -48, 96, 96))
        activeFigure.backgroundColor = UIColor.clearColor()
        activeFigure.tag = 100
        activeFigure.userInteractionEnabled = true
        activeFigure.fillColor = UIColor.orangeColor()
        activeFigure.figure = Figure(fromOrientation: Orientation.Up, fromType: FigureType(rawValue: Int(rand))!)
        playGrid.addSubview(activeFigure)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        CreateNewActiveFigure()
        gameTimer = NSTimer.scheduledTimerWithTimeInterval(tick, target: self, selector: "runTimedCode", userInfo: nil, repeats: true)
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

