//
//  ViewController.swift
//  mathGame
//
//  Created by 羅承志 on 2021/5/18.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var number1Label: UILabel!
    @IBOutlet weak var symbolsLabel: UILabel!
    @IBOutlet weak var number2Label: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet var answerButtons: [UIButton]!
    @IBOutlet weak var answerButView: UIView!
    
    @IBOutlet var resultView: UIView!
    @IBOutlet weak var resultScoreLabel: UILabel!
    @IBOutlet weak var resultDescriptionLabel: UILabel!
    
    var number1 = 0
    var number2 = 0
    var doubleNumber = 0
    var symbolsArray = ["+", "-", "X", "÷"]
    var options: [Int] = []
    var option1 = 0
    var option2 = 0
    var answer = 0
    var index = 1
    var score = 0
    var highestScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        randomQuestion()
        questionLabel.text = "Question \(index)"
        resultView.isHidden = true
    }
    
    func randomQuestion() {
        symbolsArray.shuffle()
        option1 = Int.random(in: 1...99)
        option2 = Int.random(in: 1...99)
        options = [option1, option2]
        
        if symbolsArray[0] == "+" {
            symbolsLabel.text = symbolsArray[0]
            number1 = Int.random(in: 1...99)
            number2 = Int.random(in: 1...99)
            answer = number1 + number2
        } else if symbolsArray[1] == "-" {
            symbolsLabel.text = symbolsArray[1]
            number1 = Int.random(in: 10...99)
            number2 = Int.random(in: 1...9)
            answer = number1 - number2
        } else if symbolsArray[2] == "X" {
            symbolsLabel.text = symbolsArray[2]
            number1 = Int.random(in: 1...20)
            number2 = Int.random(in: 1...20)
            answer = number1 * number2
        } else if symbolsArray[3] == "÷" {
            symbolsLabel.text = symbolsArray[3]
            number2 = Int.random(in: 1...9)
            //避免有餘數
            doubleNumber = Int.random(in: 1...9)
            number1 = number2 * doubleNumber
            answer = number1 / number2
        }
        options.append(answer)
        
        options.shuffle()
        //顯示選擇題選項
        for i in 0...2 {
            answerButtons[i].setTitle(String(options[i]), for: .normal)
        }
        number1Label.text = "\(number1)"
        number2Label.text = "\(number2)"
    }
    
    @IBAction func selectAnswer(_ sender: UIButton) {
        index += 1
        questionLabel.text = "Question: \(index)"
        
        if sender.currentTitle == String(answer) {
            score = score + 10
        }
        if index == 11 {
            index = 10
            answerButView.isHidden = true
            resultView.isHidden = false
            resultScoreLabel.text = "\(score)"
            questionLabel.text = ""
            if score <= 50 {
                resultDescriptionLabel.text = "再加油!"
            } else if score <= 70 {
                resultDescriptionLabel.text = "不錯!"
            } else if score <= 90 {
                resultDescriptionLabel.text = "很棒!"
            } else {
                resultDescriptionLabel.text = "完美!"
            }
        }
        randomQuestion()
        print(answer)
        scoreLabel.text = "\(score)"
    }
    
    @IBAction func playAgain(_ sender: Any) {
        index = 1
        score = 0
        randomQuestion()
        resultView.isHidden = true
        questionLabel.isHidden = false
        questionLabel.text = "Question \(index)"
        scoreLabel.text = "0"
    }
}

