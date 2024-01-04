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
    
    @AppStorage("userDefaultColorScheme") private var userDefaultColorScheme: Int?
    @State private var store = Store()
    
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
                .preferredColorScheme(colorScheme)
                .handleErrors(error: store.error, action: store.errorAction)
        }
    }
}
