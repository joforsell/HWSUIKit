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
    
    static let projects = [Project(identifier: "Storm Viewer", image: "cloud.bolt.rain.fill"), Project(identifier: "Guess the Flag", image: "flag.fill")]
}
