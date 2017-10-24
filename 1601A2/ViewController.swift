//
//  ViewController.swift
//  1601A2
//
//  Created by CH on 2017-03-02.
//  Student Number: 100954276
//
//  Copyright (c) 2017 CH. All rights reserved.
//

//NOTE:I AM RUNNING AN OLD VERSION OF SWIFT 1 AND XCODE 6.2

import UIKit
import Foundation

class ViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var decButton : UIButton!

    @IBOutlet weak var binButton : UIButton!

    @IBOutlet weak var hexButton : UIButton!
    
    @IBOutlet var userTextField : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //set background color to light gray
        self.view.backgroundColor = UIColor.lightGrayColor()
        
        
        var initText: String = ""
        
        //button1 aka hex button
        var layer1 = hexButton.layer
        layer1.cornerRadius = 8.0
        layer1.masksToBounds = true
        layer1.borderWidth = 1.0
        hexButton.backgroundColor = UIColor.redColor()
        
        //button2 aka bin button
        var layer2 = binButton.layer
        layer2.cornerRadius = 8.0
        layer2.masksToBounds = true
        layer2.borderWidth = 1.0
        binButton.backgroundColor = UIColor.redColor()
        
        //button3 aka dec button
        var layer3 = decButton.layer
        layer3.cornerRadius = 8.0
        layer3.masksToBounds = true
        layer3.borderWidth = 1.0
        decButton.backgroundColor = UIColor.redColor()
        
        userTextField.text = initText
        
    }
    
        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    @IBAction func decButtonClicked(sender : AnyObject) {
        //set colors of buttons
        self.decButton!.backgroundColor = UIColor.greenColor()
        self.binButton!.backgroundColor = UIColor.redColor()
        self.hexButton!.backgroundColor = UIColor.redColor()
        userTextField.backgroundColor = UIColor.whiteColor()
        
        var errorFlag = false
        var userInput = String(userTextField.text)

        
        switch userTextField.text!{
        case _ where userInput.hasPrefix("h:"):
            
            //block of code is for getting a substring
            //of characters after the first occurence of a ":"
            let usIn = String(userInput)
            let characterToFind: Character = ":"
            let index = find(usIn, characterToFind)
            let rest = usIn.substringFromIndex(advance(index!, 1))
            
            let str = "0123456789abcdef"
            let alphabet = Array(str)
            
            //check for invalid characters (h-z)
            for i in rest{
                if (!contains(alphabet, i)){
                    userTextField.backgroundColor = UIColor.redColor()
                    userTextField.text = "ERROR"
                    errorFlag = true
                }
            }
            if(!errorFlag){
                //hex to dec converting
                let num = String(strtoul(rest, nil, 16))
            
                var newText = "d:" + num
                userTextField.text = newText
            }
            
        case _ where userInput.hasPrefix("b:"):
            
            let usIn = String(userInput)
            let characterToFind: Character = ":"
            let index = find(usIn, characterToFind)
            let rest = usIn.substringFromIndex(advance(index!, 1))
  
            // binary (1s & 0s) error checking
            
            for i in rest{
                if (i != "1" && i != "0"){
                    //error if anything other than a 1 or 0 found
                    userTextField.backgroundColor = UIColor.redColor()
                    userTextField.text = "ERROR"
                    errorFlag = true
                }
            }
            
            if(!errorFlag){
                //bin to dec converting
                let num = String(strtoul(rest, nil, 2))
            
                var newText = "d:" + num
                userTextField.text = newText
            }

        case _ where userInput.hasPrefix("d:"):
            
            let usIn = String(userInput)
            let characterToFind: Character = ":"
            let index = find(usIn, characterToFind)
            let rest = usIn.substringFromIndex(advance(index!, 1))
  
            for i in rest.utf16{
                if(NSCharacterSet.letterCharacterSet().characterIsMember(i)){
                    userTextField.backgroundColor = UIColor.redColor()
                    userTextField.text = "ERROR"
                    errorFlag = true
                }
            }
            
            if(!errorFlag){
             userTextField.text = userInput
            }
        default:
            userTextField.backgroundColor = UIColor.redColor()
            userTextField.text = "ERROR"
        }
    }
    
    @IBAction func binButtonClicked(sender : AnyObject) {
        self.decButton!.backgroundColor = UIColor.redColor()
        self.binButton!.backgroundColor = UIColor.greenColor()
        self.hexButton!.backgroundColor = UIColor.redColor()
        userTextField.backgroundColor = UIColor.whiteColor()

        var errorFlag = false
        let userInput = String(userTextField.text)
        /*
        var charArr = [Character]()
        for i in userInput{
            charArr.append(i)
        }*/
        
        switch userTextField.text!{
            case _ where userInput.hasPrefix("d:"):
            
                let usIn = String(userInput)
                let characterToFind: Character = ":"
                let index = find(usIn, characterToFind)
                let rest = usIn.substringFromIndex(advance(index!, 1))
                
                for i in rest.utf16{
                    if(NSCharacterSet.letterCharacterSet().characterIsMember(i)){
                        userTextField.backgroundColor = UIColor.redColor()
                        userTextField.text = "ERROR"
                        errorFlag = true
                    }
                }
                if(!errorFlag){
                    //dec to bin conversion
                    let convert: Int? = rest.toInt()
                    let num = String(convert!, radix: 2)
            
                    var newText = "b:" + num
                    userTextField.text = newText
                }
            
            case _ where userInput.hasPrefix("b:"):
                
                let usIn = String(userInput)
                let characterToFind: Character = ":"
                let index = find(usIn, characterToFind)
                let rest = usIn.substringFromIndex(advance(index!, 1))
                
                //bin to bin (no conversion)
                for i in rest{
                    if (i != "1" && i != "0"){
                        userTextField.backgroundColor = UIColor.redColor()
                        userTextField.text = "ERROR"
                        errorFlag = true
                    }
                }
                if(!errorFlag){
                    userTextField.text = userInput
                }
            
            case _ where userInput.hasPrefix("h:"):
                let usIn = String(userInput)
                let characterToFind: Character = ":"
                let index = find(usIn, characterToFind)
                let rest = usIn.substringFromIndex(advance(index!, 1))
                
                let str = "0123456789abcdef"
                let alphabet = Array(str)
                
                //check for invalid characters (h-z)
                for i in rest{
                    if (!contains(alphabet, i)){
                        userTextField.backgroundColor = UIColor.redColor()
                        userTextField.text = "ERROR"
                        errorFlag = true
                    }
                }
                if(!errorFlag){
                    //hex to bin conversion
                    let num = String(strtoul(rest, nil, 16), radix: 2)
            
                    var newText = "b:" + num
                    userTextField.text = newText
                }
            
            default:
                userTextField.backgroundColor = UIColor.redColor()
                userTextField.text = "ERROR"
        }
    }
    
    @IBAction func hexButtonClicked(sender : AnyObject) {
        self.decButton!.backgroundColor = UIColor.redColor()
        self.binButton!.backgroundColor = UIColor.redColor()
        self.hexButton!.backgroundColor = UIColor.greenColor()
        userTextField.backgroundColor = UIColor.whiteColor()
        
        var errorFlag = false
        let userInput = userTextField.text
        
        switch userTextField.text!{
            case _ where userInput.hasPrefix("d:"):
                let usIn = String(userInput)
                let characterToFind: Character = ":"
                let index = find(usIn, characterToFind)
                let rest = usIn.substringFromIndex(advance(index!, 1))
            
                //check for letters in decimal
                for i in rest.utf16{
                    if(NSCharacterSet.letterCharacterSet().characterIsMember(i)){
                        userTextField.backgroundColor = UIColor.redColor()
                        userTextField.text = "ERROR"
                        errorFlag = true
                    }
                }
                
                if(!errorFlag){
                    //dec to hex conversion
                    let convert: Int? = rest.toInt()
                    let num = String(convert!, radix: 16)
            
                    var newText = "h:" + num
                    userTextField.text = newText
                }
            
            case _ where userInput.hasPrefix("b:"):
                let usIn = String(userInput)
                let characterToFind: Character = ":"
                let index = find(usIn, characterToFind)
                let rest = usIn.substringFromIndex(advance(index!, 1))
                
                for i in rest{
                    if (i != "1" && i != "0"){
                        userTextField.backgroundColor = UIColor.redColor()
                        userTextField.text = "ERROR"
                        errorFlag = true
                    }
                }
                if(!errorFlag){
                    //bin to hex conversion
                    let num = String(strtoul(rest, nil , 2), radix: 16)
            
                    var newText = "h:" + num
                    userTextField.text = newText
                }
            case _ where userInput.hasPrefix("h:"):
                let usIn = String(userInput)
                let characterToFind: Character = ":"
                let index = find(usIn, characterToFind)
                let rest = usIn.substringFromIndex(advance(index!, 1))
                
                let str = "0123456789abcdef"
                let alphabet = Array(str)
                
                //check for invalid characters (h-z)
                for i in rest{
                    if (!contains(alphabet, i)){
                        userTextField.backgroundColor = UIColor.redColor()
                        userTextField.text = "ERROR"
                            errorFlag = true
                    }
                }
                if(!errorFlag){
                    //hex to hex (no conversion)
                    userTextField.text = userInput
                }
            
            default:
                userTextField.backgroundColor = UIColor.redColor()
                userTextField.text = "ERROR"
        }
    }

    /*
    //Conversion Calculations, NOT TEST CASES
    // Decimal to binary
    let d1 = 21
    let b1 = String(d1, radix: 2)
    println(b1) // "10101"
    
    // Binary to decimal
    var tric: String = "10110"
    let num = strtoul(tric, nil, 2)
    println(num)
    // 22
    
    // Decimal to hexadecimal
    let d3 = 61
    let h1 = String(d3, radix: 16)
    println(h1) // "3d"
    
    // Hexadecimal to decimal
    let h2 = "a3"
    let d4 = strtoul(h2, nil, 16)
    println(d4) // 163
    
    // Binary to hexadecimal
    let b3 = "10101011"
    let h3 = String(strtoul(b3, nil , 2), radix: 16)
    println(h3) // "ab"
    
    // Hexadecimal to binary
    let h4 = "face"
    let b4 = String(strtoul(h4, nil, 16), radix: 2)
    println(b4) // "1111101011001110"
    */

    
    
    
}

