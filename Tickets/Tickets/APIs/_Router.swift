//
//  Router.swift
//  Tickets
//
//  Created by Mohammed Iskandar on 26/10/2020.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    case login(email: String, password: String)
    case posts
    case post(id: Int)

    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        case .posts, .post:
            return .get
        }
    }

    // MARK: - Path
    private var path: String {
        switch self {
        case .login:
            return "/login"
        case .posts:
            return "/posts"
        case .post(let id):
            return "/post/\(id)"
        }
    }

    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .login(let email, let password):
            return [K.APIParameterKey.email: email, K.APIParameterKey.password: password]
        case .posts, .post:
            return nil
        }
    }


    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try K.ProductionServer.baseURL.asURL()

        // HTTP Method
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))

        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)

        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
//                throw AFError.parameterEncoderFailed(reason: )
                throw AFError.parameterEncodingFailed(reason: AFError.ParameterEncodingFailureReason.jsonEncodingFailed(error: error))
            }
        }

        return urlRequest
    }
}

struct K {
    struct ProductionServer {
        static let baseURL = "http://localhost:5000/api/v1"
    }

    struct APIParameterKey {
        static let password = "password"
        static let email = "email"
    }
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

protocol APIConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
}

enum UserEndpoint: APIConfiguration {
    var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        case .profile:
            return .get
        }
    }

    var path: String {
        switch self {
        case .login:
            return "/login"
        case .profile(let id):
            return "/profile/\(id)"
        }
    }

    var parameters: Parameters? {
        switch self {
        case .login(let email, let password):
            return [K.APIParameterKey.email: email, K.APIParameterKey.password: password]
        case .profile:
            return nil
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = try K.ProductionServer.baseURL.asURL()

        var urlRequest = URLRequest(url: url.appendingPathComponent(path))


        // HTTP Method
        urlRequest.httpMethod = method.rawValue

        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)


        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: AFError.ParameterEncodingFailureReason.jsonEncodingFailed(error: error))
            }
        }

        return urlRequest
    }

    case login(email: String, password: String)
    case profile(id: Int)
}




//enum TodoRouter: URLRequestConvertible {
//    static let baseURLString = "https://jsonplaceholder.typicode.com/"
//
//    case get(Int)
//    case create([String: Any])
//    case delete(Int)
//
//    func asURLRequest() throws -> URLRequest {
//
//    }
//}
