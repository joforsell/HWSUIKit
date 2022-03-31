//
//  Project.swift
//  HWSUIKit
//
//  Created by Johan Forsell on 2022-02-15.
//

import Foundation
import UIKit

struct Project {
    let identifier: String
    let image: String
    
    static let projects = [
        [Project(identifier: "Storm Viewer", image: "cloud.bolt.rain.fill"),
        Project(identifier: "Guess the Flag", image: "flag.fill")],
        
        [Project(identifier: "Flag List", image: "flag.square.fill")],
        
        [Project(identifier: "Easy Browser", image: "safari.fill"),
        Project(identifier: "Word Scramble", image: "note.text"),
        Project(identifier: "Auto Layout Code", image: "chevron.left.forwardslash.chevron.right")],
        
        [Project(identifier: "Shopping List", image: "bag.fill")],
        
        [Project(identifier: "White House Petitions", image: "house.fill")]
    ]
    
    static let sections = [
        "Projects 1-3",
        "Milestone Challenge 1",
        "Projects 4-6",
        "Milestone Challenge 2",
        "Projects 7-9"
    ]
}
