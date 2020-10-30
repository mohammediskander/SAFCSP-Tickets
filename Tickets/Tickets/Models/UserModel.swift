//
//  User.swift
//  Tickets
//
//  Created by Mohammed Iskandar on 25/10/2020.
//

import Foundation

enum Gender: String, Codable {
    case male = "male"
    case female = "female"
}

struct UserModel: Codable {
    let phoneNumber: String?
    let email: String
    let avatar: String?
    let name: String
    let hobies: [String]?
    let gender: Gender?
    let roles: [Role]
    let bootcampVersion: Double
    let status: String?
}
