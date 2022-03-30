//
//  WordScrambleViewController.swift
//  HWSUIKit
//
//  Created by Johan Forsell on 2022-02-23.
//

import UIKit

class WordScrambleViewController: UITableViewController {
    var allWords = [String]()
    var usedWords = [String]()
    var wordCount: UIView!
    var wordCountLabel: UILabel!
    var recordScore = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupWordCount()
        
        navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(startGame)), UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))]

        if let startWordURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordURL) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        
        if allWords.isEmpty {
            allWords = ["silkworm"]
        }
        
        startGame()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = usedWords[indexPath.row]
        cell.contentConfiguration = content
        return cell
    }
    
    @objc
    func startGame() {
        title = allWords.randomElement()
        if usedWords.count > recordScore {
            recordScore = usedWords.count
            let ac = UIAlertController(title: "New record!", message: "You found \(usedWords.count) words, which is a new record. Good job!", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK", style: .default)
            
            ac.addAction(action)
            present(ac, animated: true)
        }
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
        wordCountLabel.text = "\(usedWords.count)"
    }
    
    @objc
    func promptForAnswer() {
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        ac.addAction(submitAction)
        ac.addAction(cancelAction)
        present(ac, animated: true)
    }
    
    func submit(_ answer: String) {
        let lowerAnswer = answer.lowercased()
        
        isReal(word: lowerAnswer) { [weak self] result in
            switch result {
            case .success(_):
                self?.usedWords.insert(answer.lowercased(), at: 0)
                self?.wordCountLabel.text = "\(self?.usedWords.count ?? 0)"
                
                let indexPath = IndexPath(row: 0, section: 0)
                self?.tableView.insertRows(at: [indexPath], with: .automatic)
                
                return
            case .failure(let errorDescription):
                self?.showErrorMessage(errorDescription)
            }
        }
        
    }
    
    func isReal(word: String, completion: @escaping (Result<Bool, ErrorDescription>) -> ()) {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        if !isPossible(word: word) {
            return completion(.failure(ErrorDescription(errorTitle: "Word not possible", errorMessage: "You can't spell that word from \(title?.lowercased() ?? "")")))
        } else if !isOriginal(word: word) {
            return completion(.failure(ErrorDescription(errorTitle: "Word already used", errorMessage: "Be more original!")))
        } else if word.count < 3 {
            return completion(.failure(ErrorDescription(errorTitle: "Word too short", errorMessage: "Your answer needs to be at least 3 characters long")))
        } else if word == title {
            return completion(.failure(ErrorDescription(errorTitle: "Same word as the starting word", errorMessage: "That's not a proper answer, that's just the starting word again!")))
        } else if misspelledRange.location != NSNotFound {
            return completion(.failure(ErrorDescription(errorTitle: "Word not recognized", errorMessage: "You can't just make them up, you know!")))
        } else {
            return completion(.success(true))
        }
    }
    
    func showErrorMessage(_ description: ErrorDescription) {
        let ac = UIAlertController(title: description.errorTitle, message: description.errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }

    func isPossible(word: String) -> Bool {
        guard var tempWord = title?.lowercased() else { return false }
        
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func setupWordCount() {
        wordCount = UIView()
        wordCount.translatesAutoresizingMaskIntoConstraints = false
        wordCount.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        wordCount.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        wordCount.layer.shadowOpacity = 1.0
        wordCount.layer.shadowRadius = 2.0
        wordCount.frame = CGRect(origin: CGPoint(x: view.frame.maxX - 40, y: view.frame.minY + 20), size: CGSize(width: 40, height: 40))

        wordCountLabel = UILabel()
        wordCountLabel.translatesAutoresizingMaskIntoConstraints = false
        wordCountLabel.textAlignment = .center
        wordCountLabel.text = "\(usedWords.count)"
        wordCountLabel.textColor = .white
        wordCountLabel.font = UIFont.boldSystemFont(ofSize: 24)
        wordCountLabel.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        wordCountLabel.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        wordCountLabel.layer.shadowOpacity = 1.0
        wordCountLabel.layer.shadowRadius = 2.0
        wordCountLabel.backgroundColor = .backgroundRed
        wordCountLabel.layer.cornerRadius = wordCount.frame.width/2
        wordCountLabel.frame = CGRect(origin: wordCount.frame.origin, size: CGSize(width: 40, height: 40))
        wordCountLabel.layer.masksToBounds = true
        wordCount.addSubview(wordCountLabel)
        view.addSubview(wordCount)
        
        NSLayoutConstraint.activate([
            wordCount.widthAnchor.constraint(equalToConstant: 40),
            wordCount.widthAnchor.constraint(equalTo: wordCount.heightAnchor, multiplier: 1),
            wordCountLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 24),
            wordCountLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -24),
            wordCountLabel.widthAnchor.constraint(equalToConstant: 40),
            wordCountLabel.widthAnchor.constraint(equalTo: wordCountLabel.heightAnchor, multiplier: 1),
        ])
    }
}
