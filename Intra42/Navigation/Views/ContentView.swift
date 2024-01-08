//
//  ContentView.swift
//  Intra42
//
//  Created by Marc Mosca on 01/01/2024.
//

import SwiftUI

struct ContentView: View
{
    
    // MARK: - Private properties
    
    @Environment(\.store) private var store
    @AppStorage("userIsConnected") private var userIsConnected: Bool?
    @State private var viewModel = ViewModel()
    
    // MARK: - Body
    
    var body: some View
    {
        @Bindable var store = store
        
        if userIsConnected != true
        {
            OnBoardingView()
        }
        else
        {
            VStack
            {
                if viewModel.loadingState != .succeded
                {
                    ProgressView("Retrieving your current information...")
                }
                else
                {
                    AppTabView(selection: $store.selection)
                }
            }
            .task
            {
                await fetchGlobalInformations()
            }
        }
    }
    
    // MARK: - Private methods
    
    private func fetchGlobalInformations() async
    {
        do
        {
            try await viewModel.fetchGlobalInformations(store: store)
        }
        catch AppError.apiAuthorization
        {
            store.error = .apiAuthorization
        }
        catch
        {
            store.error = .network
            store.errorAction = {
                Task
                {
                    await fetchGlobalInformations()
                }
            }
        }
    }
    
}

// MARK: - Previews

#Preview
{
    ContentView()
}
