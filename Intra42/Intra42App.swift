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
    
    @State private var store = Store()
    
    // MARK: - Body
    
    var body: some Scene
    {
        WindowGroup
        {
            ContentView()
                .environment(\.store, store)
                .handleErrors(error: store.error, action: store.errorAction)
        }
    }
}
