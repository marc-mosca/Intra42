//
//  Settings-ViewModel.swift
//  Intra42
//
//  Created by Marc Mosca on 24/01/2024.
//

import Foundation

extension SettingsView {
    
    @Observable
    final class ViewModel {
        
        // MARK: - Properties
        
        var showLogoutAlert = false
        
        var userIsConnected = false {
            didSet {
                UserDefaults.standard.set(userIsConnected, forKey: AppStorageKeys.userIsConnected.rawValue)
            }
        }
        
        var userColorScheme = 0 {
            didSet {
                UserDefaults.standard.set(userColorScheme, forKey: AppStorageKeys.userColorScheme.rawValue)
            }
        }
        
        var userLanguage = "en" {
            didSet {
                UserDefaults.standard.set(userLanguage, forKey: AppStorageKeys.userLanguage.rawValue)
            }
        }
        
        var userLogtime = 0 {
            didSet {
                UserDefaults.standard.set(userLogtime, forKey: AppStorageKeys.userLogtime.rawValue)
            }
        }
        
        init() {
            self.userIsConnected = UserDefaults.standard.bool(forKey: AppStorageKeys.userIsConnected.rawValue)
            self.userColorScheme = UserDefaults.standard.integer(forKey: AppStorageKeys.userColorScheme.rawValue)
            self.userLanguage = UserDefaults.standard.string(forKey: AppStorageKeys.userLanguage.rawValue) ?? Locale.current.identifier.split(separator: "_").first?.lowercased() ?? "en"
            self.userLogtime = UserDefaults.standard.integer(forKey: AppStorageKeys.userLogtime.rawValue)
        }
        
        // MARK: - Methods
        
        func toggleLogoutAlert() {
            showLogoutAlert = true
        }
        
        func logout() {
            Api.Keychain.shared.clear()
            userIsConnected = false
        }
        
    }
    
}
