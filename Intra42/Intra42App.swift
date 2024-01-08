//
//  Intra42App.swift
//  Intra42
//
//  Created by Marc Mosca on 01/01/2024.
//

import SwiftUI

@main
struct Intra42App: App
{
    
    // MARK: - Private properties
    
    @AppStorage("userIsConnected") private var userIsConnected: Bool?
    @AppStorage("userDefaultLanguage") private var userDefaultLanguage: String?
    @AppStorage("userDefaultColorScheme") private var userDefaultColorScheme: Int?
    @State private var store = Store()
    
    private var identifier: String
    {
        userDefaultLanguage ?? Locale.current.identifier
    }
    
    private var colorScheme: ColorScheme?
    {
        AppColorScheme.transformToColorScheme(colorScheme: userDefaultColorScheme ?? 0)
    }
    
    // MARK: - Body
    
    var body: some Scene
    {
        WindowGroup
        {
            ContentView()
                .environment(\.store, store)
                .environment(\.locale, .init(identifier: identifier))
                .preferredColorScheme(colorScheme)
                .handleErrors(error: store.error, action: store.errorAction)
                .onChange(of: store.error)
                {
                    switch store.error
                    {
                    case .apiAuthorization:
                        Api.Keychain.shared.clear()
                        userIsConnected = false
                    default:
                        return
                    }
                }
        }
        .modelContainer(for: HistorySearch.self)
    }
}
