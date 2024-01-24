//
//  Keys.swift
//  Intra42
//
//  Created by Marc Mosca on 15/01/2024.
//

import Foundation

extension Api {
    
    /// An enumeration of all the keys linked to the API.
    enum Keys {
        
        // MARK: - Cases
        
        /// The unique key corresponding to the server's "uid" key.
        case clientID
        
        /// The unique key corresponding to the server's "secret" key.
        case secretID
        
        /// The unique key corresponding to the server's "redirect uri" key.
        case redirectURI
        
        // MARK: - Exposed properties
        
        /// The value associated with the API key.
        var value: String {
            let plist = NSDictionary(contentsOfFile: apiFilePath)
            
            guard let value = plist?.object(forKey: key) as? String else {
                fatalError("Error: couldn't find `\(key)` key in `Api.plist`.")
            }
            
            return value
        }
        
        // MARK: - Private properties
        
        private var apiFilePath: String {
            guard let apiFilePath = Bundle.main.path(forResource: "Api", ofType: "plist") else {
                fatalError("Error: Couldn't find `Api.plist` file.")
            }
            
            return apiFilePath
        }
        
        private var key: String {
            switch self {
            case .clientID:
                return "API_CLIENT_ID"
            case .secretID:
                return "API_SECRET_ID"
            case .redirectURI:
                return "API_REDIRECT_URI"
            }
        }
        
    }
    
}
