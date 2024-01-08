//
//  ProfileView.swift
//  Intra42
//
//  Created by Marc Mosca on 04/01/2024.
//

import SwiftUI

struct ProfileView: View
{
    
    // MARK: - Exposed properties
    
    let user: Api.Types.User
    let isSearchedProfile: Bool
    
    init(user: Api.Types.User, isSearchedProfile: Bool = false)
    {
        self.user = user
        self.isSearchedProfile = isSearchedProfile
    }
    
    // MARK: - Private properties
    
    @Environment(\.store) private var store
    @State private var viewModel = ViewModel()
    
    private var userRefresh: Api.Types.User
    {
        viewModel.user ?? user
    }
    
    // MARK: - Body
    
    var body: some View
    {
        NavigationStack
        {
            ScrollView
            {
                VStack(spacing: 40)
                {
                    HStack(spacing: 20)
                    {
                        Avatar(url: userRefresh.image.link, isConnected: userRefresh.location != nil)
                        Informations(name: userRefresh.displayname, email: userRefresh.email, isPostCC: userRefresh.postCC, cursus: userRefresh.mainCursus)
                    }
                    
                    GridInformations(location: userRefresh.location, grade: userRefresh.mainCursus?.grade, poolYear: userRefresh.poolYear)
                    Dashboard(user: userRefresh, isSearchedProfile: isSearchedProfile)
                }
                .padding()
            }
            .navigationTitle(isSearchedProfile ? "\(userRefresh.login.capitalized)'s profile" : "My profile")
            .toolbar
            {
                RefreshButton(state: viewModel.loadingState, action: refreshButtonAction)
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
                try await viewModel.updateUserInformations(oldUser: userRefresh)
            }
            catch AppError.apiAuthorization
            {
                store.error = .apiAuthorization
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
    ProfileView(user: .sample)
}
