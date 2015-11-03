//
//  ViewController.swift
//  GuessTheFlag
//
//  Created by Kenneth Wilcox on 10/15/15.
//  Copyright © 2015 Kenneth Wilcox. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UIViewController {
  
  @IBOutlet weak var button1: UIButton!
  @IBOutlet weak var button2: UIButton!
  @IBOutlet weak var button3: UIButton!
  
  var countries = [String]()
  var correctAnswer = 0
  var score = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    if let startWordsPath = NSBundle.mainBundle().pathForResource("flags", ofType: "txt") {
      if let startWords = try? String(contentsOfFile: startWordsPath, usedEncoding: nil) {
        countries = startWords.componentsSeparatedByString("\n")
        // The build run script can add a blank line - delete any
        countries = countries.filter({$0 != ""})
      } else {
        countries = ["us"]
      }
    } else {
      countries = ["us"]
    }
    
    // Flags with white "disapear" a border makes them show up properly
    button1.layer.borderWidth = 1
    button2.layer.borderWidth = 1
    button3.layer.borderWidth = 1
    
    button1.layer.borderColor = UIColor.lightGrayColor().CGColor
    button2.layer.borderColor = UIColor.lightGrayColor().CGColor
    button3.layer.borderColor = UIColor.lightGrayColor().CGColor
    
    askQuestion()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func askQuestion(action: UIAlertAction! = nil) {
    // GameplayKit random suffle
    countries = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(countries) as! [String]
    
    button1.setImage(UIImage(named: countries[0]), forState: .Normal)
    button2.setImage(UIImage(named: countries[1]), forState: .Normal)
    button3.setImage(UIImage(named: countries[2]), forState: .Normal)
    
    // Get a random number - either 0, 1, 2
    correctAnswer = GKRandomSource.sharedRandom().nextIntWithUpperBound(3)
    title = countries[correctAnswer].uppercaseString
  }
  
  @IBAction func buttonTapped(sender: UIButton) {
    var title: String
    
    if sender.tag == correctAnswer {
      title = "Correct"
      ++score
    } else {
      title = "Wrong"
      --score
    }
    
    let ac = UIAlertController(title: title, message: "Your score is \(score).", preferredStyle: .Alert)
    ac.addAction(UIAlertAction(title: "Continue", style: .Default, handler: askQuestion))
    presentViewController(ac, animated: true, completion: nil)
  }
}

