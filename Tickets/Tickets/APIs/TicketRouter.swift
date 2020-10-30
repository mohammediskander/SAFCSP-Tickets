//
//  UserRouter.swift
//  Tickets
//
//  Created by Mohammed Iskandar on 27/10/2020.
//

import Foundation
import Alamofire

enum TicketRouter: RouterConfiguration {
    static var baseURL: String = Environment.standard.baseURL
    
    case create(ticket: Ticket)
    
    var method: HTTPMethod {
        switch self {
        case .create:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .create:
            return "/ticket/create"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case let .create(ticket):
            return [
                "name":"\(ticket.ticketName)",
//                "description":"\(ticket.)",
                "details":[
                    "type":"\(ticket.ticketType)",
                    "expectedDeliveryDate": ticket.expectedDeliveryDate,
                    "driver":[
                        "name":"\(ticket.driversName)",
                        "car": [
                            "model": "\(ticket.carsModel)",
                            "licencePlate": "\(ticket.licencePlate)",
                            "color": "\(ticket.carsColor)"
                        ]
                    ]
                ]
            ]
        }
    }
    
    var accessType: AccessType? {
        switch self {
        case .create:
            return .privateRoute
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
