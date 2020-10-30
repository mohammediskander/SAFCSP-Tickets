//
//  EnvironmentConfiguration.swift
//  Tickets
//
//  Created by Mohammed Iskandar on 27/10/2020.
//

import Foundation

protocol EnvironmentConfiguration {
    var baseURL: String { get }
    static var port: Int? { get }
}
