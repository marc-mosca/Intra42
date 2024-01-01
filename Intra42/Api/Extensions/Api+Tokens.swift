//
//  Api+Tokens.swift
//  Intra42
//
//  Created by Marc Mosca on 01/01/2024.
//

import Foundation

extension Api
{
    
    /// API access tokens.
    enum Tokens
    {
        
        // MARK: - Exposed properties
        
        /// The access token corresponding to the application authorisation.
        case applicationAccessToken
        
        /// The access token corresponding to the user's authorisation.
        case userAccessToken
        
        /// The refresh token corresponding to the user's access token, enabling the access token to be renewed.
        case userRefreshToken
        
        /// The value associated with the API access token.
        var value: String?
        {
            get
            {
                Api.Keychain.shared.get(account: account)
            }
            set
            {
                if let newValue = newValue
                {
                    try? Api.Keychain.shared.save(account: account, data: newValue)
                }
                else
                {
                    try? Api.Keychain.shared.delete(account: account)
                }
            }
        }
        
        // MARK: - Private properties
        
        private var account: Api.Keychain.Accounts
        {
            switch self
            {
            case .applicationAccessToken:
                return .applicationAccessToken
            case .userAccessToken:
                return .userAccessToken
            case .userRefreshToken:
                return .userRefreshToken
            }
        }
        
    }
    
}
