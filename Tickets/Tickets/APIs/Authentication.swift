//
//  Authentication.swift
//  Tickets
//
//  Created by Mohammed Iskandar on 24/10/2020.
//

import Foundation
import Alamofire

struct Login: Encodable {
    let email: String
    let password: String
}

class AuthenticationAPI {
    private static let baseURL: String = "http://localhost:5000/api/v1/authentication"
    
    enum Routes {
        case create
        case validate
    }
    
    static func validateAccessToken(bearerToken token: String, callback: @escaping (Result<Data?, AFError>) -> ()) {
        let url = AuthenticationAPI.baseURL + "/user/validate/access-token"
        
        
        AF.request(url, method: .post, headers: []) .response {
            response in
            OperationQueue.main.addOperation {
                callback(response.result)
            }
        }
    }
    
    func endPoint(route: Routes) {
        let method: HTTPMethod
        var url = AuthenticationAPI.baseURL
        
        switch route {
        case .create:
            method = .post
            url += "/user/create-access-token"
        case .validate:
            method = .post
            url += "/user/validate/access-token"
        }
        
        AF.request(
            url,
            method: method,
            parameters: Login(email: "test@local.host", password: "123456")
            ).response {
                response in
                switch response.result {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        let decoded = try decoder.decode(SuccessResponse.self, from: data!)
                        
                        UserDefaults.standard.setValue(decoded.token, forKey: "__token")
//                        print(UserDefaults.standard.string(forKey: "__token"))
                        UserDefaults.standard.setValue(decoded.user.email, forKey: "user.email")
                        UserDefaults.standard.setValue(decoded.user.name, forKey: "user.name")
                        UserDefaults.standard.setValue(decoded.user.gender, forKey: "user.gender")
                    } catch {
                        print(error)
                    }
                case .failure(let error):
                    debugPrint(error)
                }
            }
    }
}


struct SuccessResponse: Codable {
    let user: UserModel
    let token: String
    
    enum CodingKeys: String, CodingKey {
        case token = "__token"
        case user = "user"
    }
}

struct AccountResponse: Codable {
    let resturant: String
    let language: String
    let info: AccountInfoResponse
    let notification: Bool?
}

struct AccountInfoResponse: Codable {
    let email: String
    let password: String
    let pin: String
    let name: AccountInfoNameResponse
    let avatar: String?
    let phone: String?
    
    enum CodingKeys: String, CodingKey {
        case email = "email"
        case password = "password"
        case pin = "pin"
        case name = "name"
        case avatar = "avatar"
        case phone = "phone"
    }
}

struct AccountInfoNameResponse: Codable {
    let first: String
    let last: String
    
    enum CodingKeys: String, CodingKey {
        case first = "first"
        case last = "last"
    }
}
