//
//  Alamofire.swift
//  Tickets
//
//  Created by Mohammed Iskandar on 27/10/2020.
//

import Foundation
import Alamofire


/**
    TODO: Error from the server dont have a type!, implement a global type fot errors based on the back-end error response.
 */
extension Session {
    func responseWithData<Success: Decodable>(_ url: URLRequestConvertible, type: Success.Type, completion: @escaping (_ data: Success?, _ error: Error?) -> Void){
        var result: Success? = nil
        let decoder = JSONDecoder()
        
        AF.request(url)
            .response {
                response in
                switch response.result {
                case .success(let data):
                    do {
                        result = try decoder.decode(type, from: data!)
                        completion(result, nil)
                    } catch {
                        do {
                            let errorDecoded = try decoder.decode(ErrorResponse.self, from: data!)
                            completion(nil, errorDecoded)
                        } catch {
                            print("Error: Unexpected Error")
                        }
                        completion(result, nil)
                    }
                case .failure(let error):
                    completion(result, error)
                }
            }
    }
}
