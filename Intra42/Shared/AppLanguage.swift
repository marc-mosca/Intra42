//
//  AppLanguage.swift
//  Intra42
//
//  Created by Marc Mosca on 24/01/2024.
//

import Foundation

enum AppLanguages: String, Identifiable, CaseIterable {
    
    // MARK: - Properties
    
    case en, fr
    
    var id: String { self.rawValue }
    
    var title: String {
        switch self {
        case .en:       return "English"
        case .fr:       return "Français"
        }
    }
}
