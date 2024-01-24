//
//  SettingsView.swift
//  Intra42
//
//  Created by Marc Mosca on 24/01/2024.
//

import SwiftUI

struct SettingsView: View {
    
    // MARK: - Properties
    
    @AppStorage(AppStorageKeys.userIsConnected.rawValue) private var userIsConnected: Bool?
    @AppStorage(AppStorageKeys.userColorScheme.rawValue) private var userColorScheme: Int?
    @AppStorage(AppStorageKeys.userLanguage.rawValue) private var userLanguage: String?
    @AppStorage(AppStorageKeys.userLogtime.rawValue) private var userLogtime: Int?
    
    @Environment(\.store) private var store
    
    @State private var viewModel = ViewModel()
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            List {
                ColorSchemeSection
                LanguageSection
                LogtimeSection
                HelpSection
                AccountSection
            }
            .navigationTitle("Settings")
        }
    }
    
}

// MARK: - Previews

#Preview {
    SettingsView()
}

// MARK: - Components extension

extension SettingsView {
    
    var ColorSchemeSection: some View {
        Section {
            Picker("Theme", selection: $viewModel.userColorScheme) {
                ForEach(AppColorScheme.allCases) {
                    Text($0.title)
                        .tag($0.rawValue)
                }
            }
        }
        footer: {
            Text("Set the default theme for the application.")
        }
        .onChange(of: viewModel.userColorScheme) { userColorScheme = viewModel.userColorScheme }
    }
    
    var LanguageSection: some View {
        Section {
            Picker("Language", selection: $viewModel.userLanguage) {
                ForEach(AppLanguages.allCases) {
                    Text($0.title)
                        .tag($0.rawValue)
                }
            }
        }
        footer: {
            Text("Set the default langauge for the application.")
        }
        .onChange(of: viewModel.userLanguage) { userLanguage = viewModel.userLanguage }
    }
    
    var LogtimeSection: some View {
        Section {
            Picker("Logtime", selection: $viewModel.userLogtime) {
                Text("Default")
                    .tag(0)
                ForEach(1...24, id: \.self) {
                    Text("\($0)h")
                        .tag($0)
                }
            }
        }
        footer: {
            Text("Set a default value for the number of hours you wish to work per day. Leave on \"Default\" if you want the application to automatically calculate the number of hours you should work per month.")
        }
        .onChange(of: viewModel.userLogtime) { userLogtime = viewModel.userLogtime }
    }
    
    var HelpSection: some View {
        Section("Help") {
            Link("Report a problem", destination: URL(string: "https://github.com/marc-mosca/Intra42/issues")!)
                .foregroundStyle(.primary)
        }
    }
    
    var AccountSection: some View {
        Section("Account") {
            if let user = store.user {
                Link("My intranet profile", destination: URL(string: "https://profile.intra.42.fr/users/\(user.login)")!)
                    .foregroundStyle(.primary)
            }
            
            Button("Log out", role: .destructive, action: viewModel.toggleLogoutAlert)
        }
        .alert("Log out", isPresented: $viewModel.showLogoutAlert) {
            Button("Cancel", role: .cancel, action: {})
            Button("Log out", role: .destructive, action: viewModel.logout)
        }
        message: {
            Text("Do you really want to log out of the application?")
        }
        .onChange(of: viewModel.userIsConnected) { userIsConnected = viewModel.userIsConnected }
    }
    
}
