//
//  Errors.swift
//  Intra42
//
//  Created by Marc Mosca on 13/01/2024.
//

import Foundation

extension Api {
    
    /// An enumeration of all the errors returned by the API.
    enum Errors: LocalizedError {
        
        // MARK: - Cases
        
        case invalidServerResponse
        case invalidAccessToken
        case invalidRequest
        case tooManyRequests
        
        // MARK: - Exposed properties
        
        var errorDescription: String? {
            switch self {
            case .invalidServerResponse:    return String(localized: "The server has returned an invalid error (code 400).")
            case .invalidAccessToken:       return String(localized: "The authorisation key is no longer valid (code 401).")
            case .invalidRequest:           return String(localized: "The server receives too many requests (code 429).")
            case .tooManyRequests:          return String(localized: "The request is not valid.")
            }
        }
        
    }
    
}
