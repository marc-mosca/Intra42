//
//  ActivitiesView.swift
//  Intra42
//
//  Created by Marc Mosca on 03/01/2024.
//

import SwiftUI

struct ActivitiesView: View
{
    
    // MARK: - Private properties
    
    @Environment(\.store) private var store
    @AppStorage("userIsConnected") private var userIsConnected: Bool?
    @State private var viewModel = ViewModel()
    
    // MARK: - Body
    
    var body: some View
    {
        NavigationStack
        {
            VStack
            {
                CategoryPicker(selection: $viewModel.selection)
                
                switch viewModel.selection
                {
                case .corrections:
                    Corrections()
                case .events:
                    Events()
                case .exams:
                    Exams()
                }
            }
            .navigationTitle("My Activities")
            .toolbar
            {
                ToolbarItem
                {
                    RefreshButton(action: refreshButtonAction)
                        .disabled(viewModel.loadingState == .loading)
                }
            }
        }
    }
    
    // MARK: - Private methods
    
    private func refreshButtonAction()
    {
        Task
        {
            do
            {
                try await viewModel.updateUserActivitiesInformations(store: store)
            }
            catch AppError.apiAuthorization
            {
                store.error = .apiAuthorization
                store.errorAction = {
                    Api.Keychain.shared.clear()
                    userIsConnected = false
                }
            }
            catch
            {
                store.error = .network
                store.errorAction = refreshButtonAction
            }
        }
    }
    
}

// MARK: - Previews

#Preview
{
    ActivitiesView()
}
