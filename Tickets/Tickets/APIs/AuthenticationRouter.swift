//
//  Router.swift
//  Tickets
//
//  Created by Mohammed Iskandar on 27/10/2020.
//

import Foundation
import Alamofire

enum AuthenticationRouter: RouterConfiguration {
    
    static var baseURL: String = Environment.standard.baseURL
    
    case create(email: String, password: String)
    case validate
    
    var method: HTTPMethod {
        switch self {
        case .create:
            return .post
        case .validate:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .create:
            return "/authentication/user/create/access-token"
        case .validate:
            return "/authentication/user/validate/access-token"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .create(let email, let password):
            return ["email": email, "password": password]
        case .validate:
            return nil
        }
        
    }
    
    var accessType: AccessType? {
        switch self {
        case .create:
            return .publicRoute
        case .validate:
            return .privateRoute
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try AuthenticationRouter.baseURL.asURL()
        
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
