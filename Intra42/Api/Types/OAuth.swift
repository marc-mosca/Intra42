//
//  OAuth.swift
//  Intra42
//
//  Created by Marc Mosca on 01/01/2024.
//

import Foundation

extension Api.Types
{
    
    public enum OAuth
    {
        
        /// An object representing the application's access keys for communicating with the API.
        public struct AppToken: Decodable
        {
            
            // MARK: - Exposed properties
            
            public let accessToken: String
        }
        
        /// An object representing a user's access keys for communicating with the API.
        public struct UserToken: Decodable
        {
            
            // MARK: - Exposed properties
            
            public let accessToken: String
            public let refreshToken: String
        }
        
    }
    
}
