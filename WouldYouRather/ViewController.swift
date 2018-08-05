//
//  ViewController.swift
//  WouldYouRather
//
//  Created by Joshua Moore on 8/5/18.
//  Copyright © 2018 Joshua Moore. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var optionOneButton: UIButton!
    @IBOutlet weak var optionTwoButton: UIButton!
    @IBOutlet weak var newQuestion: UIButton!
    
    var rand1 = 0
    var rand2 = 0
    var randDays = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Initialize
        populateElements();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //My functions
    @IBAction func optionOneAction(_ sender: Any) {
        if calculatedSecondAnswer() < rand1 {
            print("yes")
            print(calculatedSecondAnswer());
            questionLabel.text = "That's correct! If you had gone with \(rand2), you would only end up with \(calculatedSecondAnswer())."
        } else {
            print("no")
            print(calculatedSecondAnswer());
            questionLabel.text = "That's incorrect. With \(rand2), you would only end up with \(calculatedSecondAnswer())."
        }
        
        //Update UI to hide/show elements
        optionOneButton.isHidden = true
        optionTwoButton.isHidden = true
        newQuestion.isHidden = false
        
    }
    
    @IBAction func optionTwoAction(_ sender: Any) {
        if calculatedSecondAnswer() > rand1 {
            print("yes")
            print(calculatedSecondAnswer());
            questionLabel.text = "That's correct! With \(rand2), you would only end up with \(calculatedSecondAnswer())."
        } else {
            print("no")
            print(calculatedSecondAnswer());
            questionLabel.text = "That's incorrect. If you had gone with \(rand2), you would only end up with \(calculatedSecondAnswer())."
        }
        
        //Update UI to hide/show elements
        optionOneButton.isHidden = true
        optionTwoButton.isHidden = true
        newQuestion.isHidden = false
    }
    
    @IBAction func nextQuestion(_ sender: Any) {
        populateElements()
    }
    
    func calculatedSecondAnswer() -> Int {
        //Check if rand1 is greater than rand2*2 every day for randDays
        var correctInt: Int = rand2
        var index: Int = 1
        while (index <= randDays) {
            correctInt = correctInt * 2
            index += 1
        }
        
        return correctInt
    }
    
    func generateRandomNumber(low: Int, high: Int, roundTo: Int?) -> Int {
        //Generate a random number within the range of low and high
        let raw = low.advanced(by: Int(arc4random_uniform(UInt32(high - low .advanced(by: 1)))))
        
        //Rounding raw to multiples of roundTo if it exists
        var rounded = 0;
        if roundTo != nil {
            rounded = roundToInt(raw, multiple: roundTo!)
        } else {
            rounded = raw
        }
        
        return rounded;
    }
    
    func roundToInt(_ value: Int, multiple: Int) -> Int {
        return value/multiple * multiple + (value % multiple)/(multiple / 2) * multiple
    }
    
    func populateElements() { //Set up a new view with new numbers
        //Define the random numbers that will be generated
        rand1 = generateRandomNumber(low: 10000,
                                         high: 100000,
                                         roundTo: 10000)
        rand2 = generateRandomNumber(low: 1,
                                         high: 10,
                                         roundTo: nil)
        randDays = generateRandomNumber(low: 1,
                                            high: 20,
                                            roundTo: nil)
        
        //Populate interface elements
        questionLabel.text = "Would you rather have $\(rand1) now or $\(rand2) doubled every day for \(randDays) days?"
        optionOneButton.setTitle("$\(String(rand1))", for: .normal)
        optionTwoButton.setTitle("$\(String(rand2))", for: .normal)
        
        //Update UI to hide/show elements
        optionOneButton.isHidden = false
        optionTwoButton.isHidden = false
        newQuestion.isHidden = true
        
    }

}

