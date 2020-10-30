//
//  Role.swift
//  Tickets
//
//  Created by Mohammed Iskandar on 25/10/2020.
//

import Foundation

struct Role: Codable {
    let name: String
    let date: Date
    let priviliges: [Privilige]
}

struct Privilige: Codable {
    let model: String
    let accessRight: [String: Bool]
}
