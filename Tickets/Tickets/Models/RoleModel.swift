//
//  RoleModel.swift
//  Tickets
//
//  Created by Mohammed Iskandar on 26/10/2020.
//

import Foundation

struct AccessRight: Codable {
    let create: Bool
    let fetch: Bool
    let gets: Bool
    let patch: Bool
}

struct Privileges: Codable {
    let model: String
    let accessRight: AccessRight
}

struct Role: Codable {
    let name: String
    let privileges: [Privileges]
}
