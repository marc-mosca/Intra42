//
//  Keychain.swift
//  Intra42
//
//  Created by Marc Mosca on 15/01/2024.
//

import Foundation

extension Api {
    
    /// An object used to interact with the user's Keychain.
    final class Keychain {
        
        // MARK: - Exposed properties
        
        /// The shared singleton keychain object.
        static let shared = Keychain()
        
        // MARK: - Private properties
        
        /// Default service to used for keychain.
        private let service = "INTRA42_API_SERVICE"
        
        private init() { }
        
        // MARK: - Exposed methods
        
        /// Store a String value in the user's keychain.
        /// - Parameters:
        ///   - account: The account used to identify where to save the new value.
        ///   - data: The new value.
        func save(account: Accounts, data: String) throws {
            let encodedData = data.data(using: .utf8) ?? Data()
            let query: [String: AnyObject] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrService as String: service as AnyObject,
                kSecAttrAccount as String: account.rawValue as AnyObject,
                kSecValueData as String: encodedData as AnyObject,
            ]
            let status = SecItemAdd(query as CFDictionary, nil)
            
            guard status != errSecDuplicateItem else {
                try delete(account: account)
                return try save(account: account, data: data)
            }
            
            guard status == errSecSuccess else { throw Errors.unknown(status) }
        }
        
        /// Retrieve the value corresponding to an account in the user's keychain.
        /// - Parameter account: The account used to identify where to get the value.
        /// - Returns: The value corresponding to the account passed in parameter. Nil if no value is found.
        func get(account: Accounts) -> String? {
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
        
        /// Delete a value from the user's keychain.
        /// - Parameter account: The account used to identify where to delete the value.
        func delete(account: Accounts) throws {
            let query: [String: AnyObject] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrService as String: service as AnyObject,
                kSecAttrAccount as String: account.rawValue as AnyObject,
            ]
            let status = SecItemDelete(query as CFDictionary)
            
            guard status == errSecSuccess || status == errSecItemNotFound else { throw Errors.unknown(status) }
        }
        
        /// Delete all API-related values from the user's keychain.
        func clear() {
            try? delete(account: .applicationAccessToken)
            try? delete(account: .userAccessToken)
            try? delete(account: .userRefreshToken)
        }
        
        // MARK: - Enums
        
        enum Accounts: String {
            case applicationAccessToken, userAccessToken, userRefreshToken
        }
        
        enum Errors: Error {
            case unknown(OSStatus)
        }
        
    }
    
}
