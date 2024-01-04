//
//  Setting+Account.swift
//  Intra42
//
//  Created by Marc Mosca on 04/01/2024.
//

import SwiftUI

extension SettingView
{
    
    struct AccountSetting: View
    {
        
        // MARK: - Private properties
        
        @AppStorage("userIsConnected") private var userIsConnected: Bool?
        @State private var showAlert = false
        
        // MARK: - Body
        
        var body: some View
        {
            Section("Account")
            {
                Button("Log out", role: .destructive)
                {
                    showAlert.toggle()
                }
            }
            .alert("Log out", isPresented: $showAlert)
            {
                Button("Cancel", role: .cancel) { }
                Button("Log out", role: .destructive, action: logout)
            }
            message:
            {
                Text("Do you really want to log out of the application?")
            }
        }
        
        // MARK: - Private methods
        
        private func logout()
        {
            Api.Keychain.shared.clear()
            userIsConnected = false
        }
        
    }
    
}
