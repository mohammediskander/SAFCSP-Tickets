//
//  User.swift
//  Tickets
//
//  Created by Mohammed Iskandar on 24/10/2020.
//

import Foundation
import Alamofire


class UserAPI {
    
    private let baseURL: String = "http://localhost:5000/api/v1/user"

    enum Routes {
        case create
        case get(id: String)
        case gets
        case update
        case delete
    }
    
    func endPoint(route: Routes, parameters: Parameters? = nil) {
        let method: HTTPMethod
        var url = self.baseURL
        
        switch route {
        case .create:
            method = .post
            url += "/new"
        case .get(let id):
            method = .get
            url += "/\(id)"
        case .gets:
            method = .get
            url += "/all"
        case .update:
            method = .patch
            url += "/update"
        case .delete:
            method = .delete
            url += "/delete"
        }
        
        AF.request(url, method: method, parameters: Register(name: "Mohammed Eskander", pin: 1234, password: "123456", email: "test@local.host")).response {
            response in
            print(response.response!.statusCode)
            debugPrint(response.data)
            print(String(data: response.data!, encoding: .utf8)!)
        }
    }
}
