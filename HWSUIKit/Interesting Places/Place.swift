//
//  Place.swift
//  HWSUIKit
//
//  Created by Johan Forsell on 2022-04-11.
//

import Foundation

class Place: NSObject, Codable {
    var name: String
    let picture: String
    
    init(name: String, picture: String) {
        self.name = name
        self.picture = picture
    }
}
