//
//  Api+Errors.swift
//  Intra42
//
//  Created by Marc Mosca on 01/01/2024.
//

import Foundation

extension Api
{
    
    /// An object representing API-related errors.
    enum Errors: LocalizedError
    {
        
        /// The server returned an error. (code: 400)
        case invalidServerResponse
        
        /// The server access token is expired or revoked. (code: 401)
        case invalidAccessToken
        
        /// The server is receiving too many requests. (code: 429)
        case tooManyRequests
        
        /// The application received is poorly formed.
        case invalidRequest
        
        var errorDescription: String?
        {
            switch self
            {
            case .invalidServerResponse:
                return String(localized: "The server has returned an invalid error (code 400).")
            case .invalidAccessToken:
                return String(localized: "The authorisation key is no longer valid (code 401).")
            case .tooManyRequests:
                return String(localized: "The server receives too many requests (code 429).")
            case .invalidRequest:
                return String(localized: "The request is not valid.")
            }
        }
        
    }
    
}
