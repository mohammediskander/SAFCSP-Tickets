//
//  Error.swift
//  Tickets
//
//  Created by Mohammed Iskandar on 27/10/2020.
//

import Foundation

struct ErrorResponse: Codable, Error {
    let name: String
    let statusCode: Int
    let stack: String?
}

enum ErrorType: Error {
    case backendError
    case alamofireError
}
