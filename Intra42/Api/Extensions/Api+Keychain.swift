//
//  Api+Keychain.swift
//  Intra42
//
//  Created by Marc Mosca on 01/01/2024.
//

import Foundation

extension Api
{
    
    /// An object used to interact with the Keychain.
    final class Keychain
    {
        
        // MARK: - Exposed properties
        
        enum Accounts: String
        {
            case applicationAccessToken
            case userAccessToken
            case userRefreshToken
        }
        
        enum Errors: Error
        {
            case unknown(OSStatus)
        }
        
        static let shared = Keychain()
        
        // MARK: - Private properties
        
        private let service = "Intra42-Api"
        
        private init()
        {
        }
        
        // MARK: - Exposed methods
        
        func save(account: Accounts, data: String) throws
        {
            let encodedData = data.data(using: .utf8) ?? Data()
            let query: [String: AnyObject] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrService as String: service as AnyObject,
                kSecAttrAccount as String: account.rawValue as AnyObject,
                kSecValueData as String: encodedData as AnyObject,
            ]
            let status = SecItemAdd(query as CFDictionary, nil)
            
            guard status != errSecDuplicateItem
            else
            {
                try delete(account: account)
                return try save(account: account, data: data)
            }
            
            guard status == errSecSuccess else { throw Errors.unknown(status) }
        }
        
        func get(account: Accounts) -> String?
        {
            let query: [String: AnyObject] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrService as String: service as AnyObject,
                kSecAttrAccount as String: account.rawValue as AnyObject,
                kSecReturnData as String: kCFBooleanTrue,
                kSecMatchLimit as String: kSecMatchLimitOne
            ]
            var result: AnyObject?
            let _ = SecItemCopyMatching(query as CFDictionary, &result)
            
            guard let data = result as? Data else { return nil }
            
            return String(decoding: data, as: UTF8.self)
        }
        
        func delete(account: Accounts) throws
        {
            let query: [String: AnyObject] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrService as String: service as AnyObject,
                kSecAttrAccount as String: account.rawValue as AnyObject,
            ]
            let status = SecItemDelete(query as CFDictionary)
            
            guard status == errSecSuccess || status == errSecItemNotFound else { throw Errors.unknown(status) }
        }
        
    }
    
}
