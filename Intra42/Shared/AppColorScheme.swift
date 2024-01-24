//
//  AppColorScheme.swift
//  Intra42
//
//  Created by Marc Mosca on 24/01/2024.
//

import SwiftUI

enum AppColorScheme: Int, Identifiable, CaseIterable {
    
    // MARK: - Properties
    
    case system, light, dark
    
    var id: Int { rawValue }
    
    var title: String {
        switch self {
        case .system:       return String(localized: "System")
        case .light:        return String(localized: "Light")
        case .dark:         return String(localized: "Dark")
        }
    }
    
    // MARK: - Methods
    
    static func transformToColorScheme(colorScheme: Int) -> ColorScheme? {
        guard let colorScheme = AppColorScheme(rawValue: colorScheme) else { return nil }
        
        switch colorScheme {
        case .system:       return nil
        case .light:        return .light
        case .dark:         return .dark
        }
    }
}
