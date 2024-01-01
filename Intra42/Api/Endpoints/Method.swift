//
//  Method.swift
//  Intra42
//
//  Created by Marc Mosca on 01/01/2024.
//

import Foundation

extension Api.Endpoint
{
    
    /// The types of methods that can be used to make a request to the API.
    enum Methods: String
    {
        case get
        case post
        case update
        case delete
    }
    
    var method: String
    {
        switch self
        {
        case .updateUserEvents, .createUserSlot, .fetchApplicationAccessToken, .fetchUserAccessToken, .updateUserAccessToken:
            return Methods.post.rawValue
        case .deleteEvent, .deleteUserSlot:
            return Methods.delete.rawValue
        default:
            return Methods.get.rawValue
        }
    }
    
}
