//
//  ViewController.swift
//  GuessTheFlagHWS
//
//  Created by Herve Desrosiers on 2020-02-10.
//  Copyright © 2020 Herve Desrosiers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var correctAnswer = 0
    var score = 0
    var questionNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        questionNumber += 1
        countries.shuffle()
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        correctAnswer = Int.random(in: 0...2)
        title = "\(countries[correctAnswer].uppercased())    Score: \(score)"
    }
    
    func endGame(action: UIAlertAction! = nil) {
        title = "Final score: \(score)"
        button1.isHidden = true
        button2.isHidden = true
        button3.isHidden = true
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        
        if questionNumber == 10 {
            let ac = UIAlertController(title: "Thank you for playing!", message: "Your final score is \(score).", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: endGame))
            present(ac, animated: true)
        } else {
            if sender.tag == correctAnswer {
                title = "Correct!"
                score += 1
                let ac = UIAlertController(title: title, message: "Your score is \(score).", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
                present(ac, animated: true)
            } else {
                title = "Wrong"
                score -= 1
                score < 0 ? score = 0 : nil
                let ac = UIAlertController(title: title, message: "That's the flag of \(countries[correctAnswer].uppercased()).", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
                present(ac, animated: true)
            }
        }
    }
}

