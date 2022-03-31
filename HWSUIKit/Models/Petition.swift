//
//  Petition.swift
//  HWSUIKit
//
//  Created by Johan Forsell on 2022-03-31.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
