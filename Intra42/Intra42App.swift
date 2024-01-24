//
//  Intra42App.swift
//  Intra42
//
//  Created by Marc Mosca on 12/01/2024.
//

import SwiftUI

@main
struct Intra42App: App {
    
    // MARK: - Properties
    
    @AppStorage(AppStorageKeys.userIsConnected.rawValue) private var userIsConnected: Bool?
    @AppStorage(AppStorageKeys.userColorScheme.rawValue) private var userColorScheme: Int?
    @AppStorage(AppStorageKeys.userLanguage.rawValue) private var userLanguage: String?
    
    @State private var store = Store()
    
    private var identifier: String {
        userLanguage ?? Locale.current.identifier
    }
    
    private var colorScheme: ColorScheme? {
        AppColorScheme.transformToColorScheme(colorScheme: userColorScheme ?? 0)
    }
    
    // MARK: - Body
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.store, store)
                .environment(\.locale, .init(identifier: identifier))
                .preferredColorScheme(colorScheme)
                .handleErrors(error: store.error, action: store.errorAction)
                .onChange(of: store.error) { logout() }
        }
        .modelContainer(for: HistorySearch.self)
    }
    
    // MARK: - Methods
    
    private func logout() {
        guard store.error == .apiAuthorization else { return }
        
        Api.Keychain.shared.clear()
        userIsConnected = false
    }
    
}
