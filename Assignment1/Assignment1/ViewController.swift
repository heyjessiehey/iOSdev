//
//  ViewController.swift
//  Assignment1
//
//  Created by Jessie Gayeon Ko on 2020-01-23.
//  Copyright © 2020 Jessie Gayeon Ko. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var resaultText: UITextView!
    @IBOutlet weak var programSelector: UISegmentedControl!
    @IBOutlet weak var levelSelector: UISegmentedControl!
    @IBOutlet weak var gpaSelector: UISlider!
    @IBOutlet weak var gpaInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gpaInput.delegate = self
        gpaInput.text = formetedGpa()
        updateResultText()
    }
    
    func updateResultText() {
        let programIndex = programSelector.selectedSegmentIndex
        
        programIndex == 0 ? (resaultText.text = "I am in CPA Program, ") : (resaultText.text = "I am in BSD Program, ")
      
        if programIndex == 0 {
            switch levelSelector.selectedSegmentIndex {
            case 0:
                resaultText.insertText("in level 4, ")
            case 1:
                resaultText.insertText("in level 5, ")
            case 2:
                resaultText.insertText("in level 6, ")
            default:
                resaultText.insertText("in level 6, ")
                print("The maximum value of CPA levels is 6")
            }
        }
        else {
            switch levelSelector.selectedSegmentIndex {
            case 0:
                resaultText.insertText("in level 4, ")
            case 1:
                resaultText.insertText("in level 5, ")
            case 2:
                resaultText.insertText("in level 6, ")
            case 3:
                resaultText.insertText("in level 7, ")
            case 4:
                resaultText.insertText("in level 8, ")
            default:
                break
            }
        }
     
        resaultText.insertText("and my GPA is " + formetedGpa() + ".")
        
    }
    
    func formetedGpa() -> String {
        return String(format: "%1.2f", gpaSelector.value)
    }
    
    @IBAction func programChanged(_ sender: UISegmentedControl) {
        updateResultText()
    }
    
    @IBAction func levelChanged(_ sender: Any) {
        updateResultText()
    }
    
    @IBAction func gpaSelectorChanged(_ sender: Any) {
        gpaInput.text = formetedGpa()
        updateResultText()
    }
    
    @IBAction func gpaInputChanged(_ sender: Any) {
        var gpaFloat: Float
        
        if let gpa = gpaInput.text{
            gpaFloat = (gpa as NSString).floatValue
            
            if gpaFloat < 2 && gpaFloat != 0{
                gpaSelector.value = 2.0
                gpaInput.text = "2.0"
            }
            else if gpaFloat > 4 {
                gpaSelector.value = 4.0
                gpaInput.text = "4.0"
            }
            else if gpaFloat <= 4 && gpaFloat >= 2{
                gpaSelector.value = gpaFloat
                gpaInput.text = String(format: "%1.2f", gpaFloat)
            }
            else {
                gpaSelector.value = 2.0
                gpaInput.text = "0.0"
            }
        }
        updateResultText()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        updateResultText()
        gpaInput.resignFirstResponder()
        return false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        updateResultText()
        gpaInput.resignFirstResponder()
     }
}

