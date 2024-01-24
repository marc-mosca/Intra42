//
//  OAuth.swift
//  Intra42
//
//  Created by Marc Mosca on 15/01/2024.
//

import Foundation

extension Api.Types {
    
    enum OAuth
    {
        
        /// An object representing the application's access keys for communicating with the API.
        struct AppToken: Decodable {
            let accessToken: String
        }
        
        /// An object representing a user's access keys for communicating with the API.
        struct UserToken: Decodable {
            let accessToken: String
            let refreshToken: String
        }
        
    }
    
}
