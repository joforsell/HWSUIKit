//
//  FlagGameViewController.swift
//  HWSUIKit
//
//  Created by Johan Forsell on 2022-02-15.
//

import UIKit

class FlagGameViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    @IBOutlet var button1TopConstraint: NSLayoutConstraint!
    @IBOutlet var button1EqualHeightConstraint: NSLayoutConstraint!
    @IBOutlet var button2EqualHeightConstraint: NSLayoutConstraint!
    @IBOutlet var button3EqualHeightConstraint: NSLayoutConstraint!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var questionsAsked = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        setupButtons()
        askQuestion()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Score", style: .plain, target: self, action: #selector(showScore))
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = capitalizedCountry(countries[correctAnswer])
        
//        UIView.animate(withDuration: 0.5) {
//            self.button1.layer.cornerRadius = 0
//            self.button1.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.33).isActive = false
//            self.button2.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.33).isActive = false
//            self.button3.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.33).isActive = false
//            self.button1.heightAnchor.constraint(equalTo: self.button2.heightAnchor, multiplier: 2).isActive = false
//            self.button2.heightAnchor.constraint(equalTo: self.button1.heightAnchor, multiplier: 2).isActive = false
//            self.button3.heightAnchor.constraint(equalTo: self.button1.heightAnchor, multiplier: 2).isActive = false
//            self.button1EqualHeightConstraint.isActive = true
//            self.button2EqualHeightConstraint.isActive = true
//            self.button3EqualHeightConstraint.isActive = true
//            self.button2.layer.cornerRadius = 0
//            self.button3.layer.cornerRadius = 0
//        }
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
//        switch sender.tag {
//        case 0:
//            UIView.animate(withDuration: 0.5) {
//                self.button1.layer.cornerRadius = 20
//                self.button1EqualHeightConstraint.isActive = false
//                self.button2EqualHeightConstraint.isActive = false
//                self.button3EqualHeightConstraint.isActive = false
//                self.button2.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.33).isActive = true
//                self.button3.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.33).isActive = true
//                self.button1.heightAnchor.constraint(equalTo: self.button2.heightAnchor, multiplier: 2).isActive = true
//                self.view.layoutIfNeeded()
//            }
//        case 1:
//            UIView.animate(withDuration: 0.5) {
//                self.button2.layer.cornerRadius = 20
//                self.button1EqualHeightConstraint.isActive = false
//                self.button2EqualHeightConstraint.isActive = false
//                self.button3EqualHeightConstraint.isActive = false
//                self.button1.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.33).isActive = true
//                self.button3.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.33).isActive = true
//                self.button2.heightAnchor.constraint(equalTo: self.button1.heightAnchor, multiplier: 2).isActive = true
//                self.view.layoutIfNeeded()
//            }
//        case 2:
//            UIView.animate(withDuration: 0.5) {
//                self.button3.layer.cornerRadius = 20
//                self.button1EqualHeightConstraint.isActive = false
//                self.button2EqualHeightConstraint.isActive = false
//                self.button3EqualHeightConstraint.isActive = false
//                self.button2.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.33).isActive = true
//                self.button1.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.33).isActive = true
//                self.button3.heightAnchor.constraint(equalTo: self.button1.heightAnchor, multiplier: 2).isActive = true
//                self.view.layoutIfNeeded()
//            }
//        default:
//            break
//        }
        
        questionsAsked += 1
        
        if sender.tag == correctAnswer {
            title = "Correct!"
            score += 1
        } else {
            title = "Wrong, that's the flag of \(capitalizedCountry(countries[sender.tag]))"
            score -= 1
        }
        
        let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        
        let finalAc = UIAlertController(title: title, message: "Your final score is \(score) out of 10", preferredStyle: .alert)
        finalAc.addAction(UIAlertAction(title: "New Game", style: .default, handler: { _ in
            self.score = 0
            self.questionsAsked = 0
            self.askQuestion()
        }))
        
        if questionsAsked < 10 {
            present(ac, animated: true)
        } else {
            present(finalAc, animated: true)
        }
    }
    
    func capitalizedCountry(_ country: String) -> String {
        if country.count == 2 {
            return country.uppercased()
        } else {
            return country.capitalized
        }
    }
    
    func setupButtons() {
        button1.contentMode = .scaleToFill
        button2.contentMode = .scaleToFill
        button3.contentMode = .scaleToFill
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1

        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
//        button1.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
//        button1.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
//        button1.layer.shadowOpacity = 1.0
//        button1.layer.shadowRadius = 2.0
        button1.layer.masksToBounds = true
        
//        button2.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
//        button2.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
//        button2.layer.shadowOpacity = 1.0
//        button2.layer.shadowRadius = 2.0
        button2.layer.masksToBounds = true
        
//        button3.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
//        button3.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
//        button3.layer.shadowOpacity = 1.0
//        button3.layer.shadowRadius = 2.0
        button3.layer.masksToBounds = true
    }
    
    @objc
    func showScore() {
        let ac = UIAlertController(title: "Your current score is:", message: "\(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}
