//
//  AppError.swift
//  Intra42
//
//  Created by Marc Mosca on 01/01/2024.
//

import Foundation

/// An object representing errors related to the application.
enum AppError: LocalizedError
{
    
    case apiAuthorization
    case network
    
    var errorDescription: String?
    {
        switch self
        {
        case .apiAuthorization:
            return String(localized: "An error has occurred with the authorization to share your data.")
        case .network:
            return String(localized: "An error has occurred with the network. Please try again later.")
        }
    }
    
}
