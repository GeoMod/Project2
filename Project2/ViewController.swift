//
//  ViewController.swift
//  Project2
//
//  Created by Daniel O'Leary on 2/20/19.
//  Copyright © 2019 Impulse Coupled Dev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var correctAnswer = 0
    var currentScore = 0
    var highScore = 0
    var questionsRemaining = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        setUpBackground()
        askQuestion(action: nil)
    }
    
    func setUpBackground() {
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        // You can customize .cgcolor if the defualt options aren't desirable
        // UIColor(red: 1.0, green: 0.6, blue: 0.2, alpha: 1.0).cgColor
    }

    func askQuestion(action: UIAlertAction!) {
        countries.shuffle()
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        correctAnswer = Int.random(in: 0...2)
        
        let countryFlagToGuess = countries[correctAnswer].uppercased()
        title = "\(countryFlagToGuess) Score: \(currentScore)"
        
        questionsRemaining -= 1
        if questionsRemaining < 0 {
            let alert = UIAlertController(title: "Quiz Complete", message: "You completed the round of the quiz! Your score was \(currentScore).", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Start Again!", style: .default, handler: nil))
            present(alert, animated: true)
            questionsRemaining = 10
            currentScore = 0
            title = "\(countryFlagToGuess) Score: \(currentScore)"
        }
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        let defaults = UserDefaults.standard
        var title: String
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping:  0.25, initialSpringVelocity: 70, options: [], animations: {
            sender.transform = CGAffineTransform(scaleX: 0.70, y: 0.70)
        }, completion: nil)
        
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping:  0.25, initialSpringVelocity: 70, options: [], animations: {
            sender.transform = CGAffineTransform(scaleX: 0.70, y: 0.70)
        }) { resetView in
            sender.transform = .identity
        }
        
        if sender.tag == correctAnswer {
            title = "Correct"
            currentScore += 1
            if highScore < currentScore {
                highScore = currentScore
                UserDefaults.standard.set(highScore, forKey: "highScore")
            }
        } else {
            title = "Wrong, that's the flag of \(countries[sender.tag].uppercased())."
            currentScore -= 1
        }
        let highScoreForAlert = defaults.integer(forKey: "highScore")
        
        let ac = UIAlertController(title: title, message: "Your score is \(currentScore) with a high score of \(highScoreForAlert).", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        present(ac, animated: true)
    }
    
    @IBAction func shareButtonTapped(_ sender: UIBarButtonItem) {
        let scoreAlert = UIAlertController(title: "Your score is:", message: String(currentScore), preferredStyle: .alert)
        scoreAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(scoreAlert, animated: true, completion: nil)
    }    
    
}

