//
//  AutoLayoutCodeController.swift
//  HWSUIKit
//
//  Created by Johan Forsell on 2022-03-30.
//

import UIKit

class AutoLayoutCodeController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fontSize: CGFloat = 20

        let label1 = UILabel()
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.backgroundColor = .backgroundRed
        label1.text = "REALLY"
        label1.font = .boldSystemFont(ofSize: fontSize)
        label1.textAlignment = .center
        label1.textColor = .white
        label1.sizeToFit()
        
        let label2 = UILabel()
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.backgroundColor = .redOrange1
        label2.text = "THOUGH"
        label2.font = .boldSystemFont(ofSize: fontSize)
        label2.textAlignment = .center
        label2.textColor = .white
        label2.sizeToFit()
        
        let label3 = UILabel()
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.backgroundColor = .redOrange2
        label3.text = "FUCK"
        label3.font = .boldSystemFont(ofSize: fontSize)
        label3.textAlignment = .center
        label3.textColor = .white
        label3.sizeToFit()
        
        let label4 = UILabel()
        label4.translatesAutoresizingMaskIntoConstraints = false
        label4.backgroundColor = .redOrange3
        label4.text = "STORY"
        label4.font = .boldSystemFont(ofSize: fontSize)
        label4.textAlignment = .center
        label4.textColor = .white
        label4.sizeToFit()
        
        let label5 = UILabel()
        label5.translatesAutoresizingMaskIntoConstraints = false
        label5.backgroundColor = .backgroundOrange
        label5.text = "BOARDS"
        label5.font = .boldSystemFont(ofSize: fontSize)
        label5.textAlignment = .center
        label5.textColor = .white
        label5.sizeToFit()
        
        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(label3)
        view.addSubview(label4)
        view.addSubview(label5)
                
        var previous: UILabel?
        
        for label in [label1, label2, label3, label4, label5] {
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
            label.safeAreaLayoutGuide.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.2, constant: -10).isActive = true
            
            if let previous = previous {
                label.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 10).isActive = true
            } else {
                label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
            }
            
            previous = label
        }
    }
}
