//
//  Api+Keys.swift
//  Intra42
//
//  Created by Marc Mosca on 01/01/2024.
//

import Foundation

extension Api
{
    
    /// API access keys.
    enum Keys
    {
        
        // MARK: - Exposed properties
        
        /// The unique key corresponding to the server's "uid" key.
        case clientID
        
        /// The unique key corresponding to the server's "secret" key.
        case secretID
        
        /// The unique key corresponding to the server's "redirect uri" key.
        case redirectURI
        
        /// The value associated with the API key.
        var value: String
        {
            let plist = NSDictionary(contentsOfFile: apiFilePath)
            
            if let value = plist?.object(forKey: key) as? String
            {
                return value
            }
            
            fatalError("Error: couldn't find `\(key)` key in `Api.plist`.")
        }
        
        // MARK: - Private properties
        
        private var apiFilePath: String
        {
            if let apiFilePath = Bundle.main.path(forResource: "Api", ofType: "plist")
            {
                return apiFilePath
            }
            
            fatalError("Error: Couldn't find `Api.plist` file.")
        }
        
        private var key: String
        {
            switch self
            {
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
