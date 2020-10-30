//
//  Root.swift
//  Tickets
//
//  Created by Mohammed Iskandar on 24/10/2020.
//

import Foundation
import Alamofire

enum Methods {
    case get(id: String?)
    case gets
    case post
    case put(id: String?)
    case patch(id: String?)
    case delete(id: String?)
}

class Root {
    private static let port = 5000
    private static let baseURLString = "http://localhost"
    
    private static func url() {
        AF.request("http://localhost")
    }
}
