//
//  Person.swift
//  HWSUIKit
//
//  Created by Johan Forsell on 2022-04-07.
//

import UIKit

class Person: NSObject {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
