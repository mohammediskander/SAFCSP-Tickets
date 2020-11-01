//
//  HTTPHeaderField.swift
//  Tickets
//
//  Created by Mohammed Iskandar on 27/10/2020.
//

import Foundation
import Alamofire

protocol RouterConfiguration: URLRequestConvertible {
    static var baseURL: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
    var accessType: AccessType? { get }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}

enum AccessType {
    case publicRoute
    case privateRoute
}

struct SuccessResponse: Codable {
    let user: UserModel
    let token: String
    
    enum CodingKeys: String, CodingKey {
        case token = "__token"
        case user = "user"
    }
}
