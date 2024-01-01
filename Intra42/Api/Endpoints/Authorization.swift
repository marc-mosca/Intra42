//
//  Authorization.swift
//  Intra42
//
//  Created by Marc Mosca on 01/01/2024.
//

import Foundation

extension Api.Endpoint
{
    
    /// The type of authorisation required to execute the request.
    enum Authorization
    {
        case application
        case user
    }
    
    var authorization: Authorization
    {
        switch self
        {
        case .fetchCampusExams, .fetchUserExams, .fetchLogtime:
            return .application
        default:
            return .user
        }
    }
    
}
