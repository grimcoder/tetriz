//
//  ViewController.swift
//  tetriz
//
//  Created by Taras Kovtun on 10/3/15.
//  Copyright © 2015 Taras Kovtun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func Right(sender: AnyObject) {
        print ("right")
        
    }
    @IBAction func Up(sender: AnyObject) {
        print ("up")
    }
    @IBAction func Bottom(sender: AnyObject) {
        print ("bottom")
    }
    @IBAction func Left(sender: AnyObject) {
        print ("Left")
        
    }
    
    @IBAction func RotateCW(sender: AnyObject) {
        print ("rotate CW")
        
    }
    @IBAction func RotateCCW(sender: AnyObject) {
        print ("Rotate ccw")
    }
    
    @IBOutlet weak var Right: Button!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

