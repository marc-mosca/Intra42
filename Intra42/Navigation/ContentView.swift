//
//  ContentView.swift
//  Intra42
//
//  Created by Marc Mosca on 12/01/2024.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Properties
    
    @Environment(\.store) private var store
    
    @AppStorage(AppStorageKeys.userIsConnected.rawValue) private var userIsConnected: Bool?
    
    @State private var viewModel = ViewModel()
    
    // MARK: - Body
    
    var body: some View {
        @Bindable var store = store
        
        if userIsConnected != true {
            OnBoardingView()
        }
        else {
            VStack {
                if viewModel.loadingState != .succeded {
                    ProgressView("Retrieving your current information...")
                }
                else {
                    AppTabView(selection: $store.selection)
                }
            }
            .task { await viewModel.fetchGlobalInformations(store: store) }
        }
    }
}

// MARK: - Previews

#Preview {
    ContentView()
}
