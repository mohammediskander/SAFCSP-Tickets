//
//  UserRouter.swift
//  Tickets
//
//  Created by Mohammed Iskandar on 27/10/2020.
//

import Foundation
import Alamofire

enum UserRouter: RouterConfiguration {
    static var baseURL: String = Environment.standard.baseURL
    
    case create(name: String, email: String, password: String)
    
    var method: HTTPMethod {
        switch self {
        case .create:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .create:
            return "/user/new"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case let .create(name, email, password):
            return ["name": name, "email": email, "password": password]
        }
    }
    
    var accessType: AccessType? {
        switch self {
        case .create:
            return .publicRoute
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try UserRouter.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        urlRequest.httpMethod = method.rawValue
        
        switch accessType {
        case .privateRoute:
            guard let token = UserDefaults.standard.string(forKey: "__token") else {
                break
            }
            
            urlRequest.setValue(token, forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
        default:
            break
        }
        
        urlRequest.addValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.addValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: AFError.ParameterEncodingFailureReason.jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
    }
    
    
}
