//
//  ViewController.swift
//  Calculator
//
//  Created by Shelley on 2/12/15.
//  Copyright (c) 2015 Shelley Dogra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTypingANumber = false  // every variable needs a
    
    
    //Fucn to append digit
    @IBAction func appendDigit(sender: UIButton) {
        
        let digit = sender.currentTitle! // let is a constant
        
        if userIsInTheMiddleOfTypingANumber {
            display.text! += digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
        
        println("digit = \(digit)")
        
        
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber{
            enter()
        }
        switch operation {
            case "×": performOperation {$0 * $1}
            case "÷": performOperation {$1 / $0}
            case "+":performOperation {$0 + $1}
            case "−":performOperation {$1 - $0}
            case "√":performOperation { sqrt($0) }
            
        default: break
        }
    }
    
    func performOperation(operation: (Double, Double) ->Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    func performOperation(operation: (Double) ->Double) {
        if operandStack.count >= 1 {
        displayValue = operation(operandStack.removeLast())
        enter()
        }
    }
    
    
    //create an internal stack
    var operandStack = Array<Double>()  // empty array
    
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        operandStack.append(displayValue)
        println("operandStack = \(operandStack)")
    }
    
    // an example of computed property
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }
    
}

