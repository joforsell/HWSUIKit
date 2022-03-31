//
//  Website.swift
//  HWSUIKit
//
//  Created by Johan Forsell on 2022-02-22.
//

import Foundation
import UIKit

struct Website {
    let url: String
    let icon: String
    
    static let safeWebsites = [
        Website(url: "apple.com", icon: "applelogo"),
        Website(url: "hackingwithswift.com", icon: "swift"),
        Website(url: "youtube.com", icon: "play.rectangle.fill")
    ]
}
