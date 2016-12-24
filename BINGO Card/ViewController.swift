//
//  ViewController.swift
//  BINGO Card
//
//  Created by Leask Wong on 5/28/15.
//  Copyright (c) 2015 Leask Wong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        bingoWebView.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    @IBOutlet weak var controllersUIView: UIView!
    @IBOutlet weak var wordsTextView: UITextView!

    @IBOutlet weak var bingoWebView: UIWebView!
    
    @IBAction func makeBingo() {
        let inputWordsArray = wordsTextView.text!.componentsSeparatedByCharactersInSet(
            NSCharacterSet (charactersInString: "\n")
        )
        var resultWordsArray = [String]()
        for word in inputWordsArray {
            let trimWord = word.stringByTrimmingCharactersInSet(
                NSCharacterSet.whitespaceCharacterSet()
            )
            if trimWord != "" {
                resultWordsArray.append(trimWord)
            }
            print(trimWord)
        }
        
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        
        var html = "<!doctype html>"
        html += "<head>"
        html += "<meta charset=\"utf-8\">"
        html += "<title>BINGO Card</title>"
        html += "<meta name=\"description\" content=\"BINGO Card\">"
        html += "<meta name=\"author\" content=\"Leask Wong\">"
        html += "</head>"
        html += "<body style=\"text-align:center\">"
        html += "<table border=\"0\" cellspacing=\"0\" cellpadding=\"0\" height=\"\(screenSize.height - 100)\" width=\"100%\">"
        html += "<tr>"
        print(screenSize.height)
        var len = 1
        while len * len < resultWordsArray.count {
            len++
        }
    
        html += "<th colspan=\"\(len)\" style=\"border: 1px solid\" height=\"\(100 / (len + 1))%\">"
        html += "B I N G O"
        html += "</th>"
        html += "</tr>"


        let appendNum = len * len - resultWordsArray.count
        if appendNum > 0 {
            for _ in 1...appendNum {
                resultWordsArray.append("😀")
            }
        }
            
        for idx in 0..<resultWordsArray.count {
            swap(&resultWordsArray[idx], &resultWordsArray[Int(arc4random_uniform(UInt32(idx)))])
        }
        
        var wordIdx = 0
        
        for _ in 0..<len {
            html += "<tr height=\"\(100 / (len + 1))%\">"
            for _ in 0..<len {
                html += "<td style=\"border: 1px solid;\" width=\"\(100 / len)%\">"
                html += resultWordsArray[wordIdx++]
                html += "</td>"
            }
            html += "</tr>"
        }
        
        html += "</table>"
        html += "</body>"
        html += "</html>"
        print(resultWordsArray)
        print(html)
    
        bingoWebView.loadHTMLString(html, baseURL: nil)
        bingoWebView.hidden = false
        controllersUIView.hidden = true
        wordsTextView.resignFirstResponder()
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == .MotionShake {
            makeBingo()
        }
    }
    
    
}

