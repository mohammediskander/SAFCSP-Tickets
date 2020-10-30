//
//  Environment.swift
//  Tickets
//
//  Created by Mohammed Iskandar on 27/10/2020.
//

import Foundation

struct Environment {
    static let isProduction = true

    struct ProductionEnvironment: EnvironmentConfiguration {
        static let port: Int? = nil
        let baseURL: String = "http://10.20.35.53:5000/api/v1"
    }

    struct DevelopmentEnvironment: EnvironmentConfiguration {
        let baseURL: String = "http://localhost:\(DevelopmentEnvironment.port!)/api/v1"
        static let port: Int? = 5000
    }

    static var standard: EnvironmentConfiguration {
        if Environment.isProduction {
            return Environment.ProductionEnvironment() as EnvironmentConfiguration
        } else {
            return Environment.DevelopmentEnvironment() as EnvironmentConfiguration
        }
    }
}
