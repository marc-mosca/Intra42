//
//  AppError.swift
//  Intra42
//
//  Created by Marc Mosca on 15/01/2024.
//

import Foundation

/// An object representing errors related to the application.
enum AppError: LocalizedError {
    
    // MARK: - Cases
    
    case apiAuthorization
    case network
    
    // MARK: - Exposed properties
    
    var errorDescription: String? {
        switch self {
        case .apiAuthorization:
            return String(localized: "An error has occurred with the authorization to share your data.")
        case .network:
            return String(localized: "An error has occurred with the network. Please try again later.")
        }
    }
    
}
