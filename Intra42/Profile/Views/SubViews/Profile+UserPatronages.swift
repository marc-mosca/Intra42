//
//  Profile+UserPatronages.swift
//  Intra42
//
//  Created by Marc Mosca on 08/01/2024.
//

import SwiftUI

extension ProfileView
{
    
    struct UserPatronages: View
    {
        
        // MARK: - Exposed properties
        
        let patroned: [Api.Types.User.Patronages]
        let patroning: [Api.Types.User.Patronages]
        
        // MARK: - Private properties
        
        @Environment(\.store) private var store
        
        @State private var patronedList = [Api.Types.User]()
        @State private var patroningList = [Api.Types.User]()
        @State private var loadingState = AppRequestState.loading
        @State private var firstLoad = true
        
        // MARK: - Body
        
        var body: some View
        {
            VStack
            {
                if loadingState != .succeded
                {
                    ProgressView()
                }
                else if patronedList.isEmpty && patroningList.isEmpty
                {
                    ContentUnavailableView("No patronage found", systemImage: "person.2.fill")
                }
                else
                {
                    List
                    {
                        if !patronedList.isEmpty
                        {
                            Section("Patroned")
                            {
                                ForEach(patronedList, content: UserCard.init)
                            }
                        }
                        
                        if !patroningList.isEmpty
                        {
                            Section("Patroning")
                            {
                                ForEach(patroningList, content: UserCard.init)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Patronages")
            .task
            {
                if firstLoad
                {
                    await fetchUserPatronages()
                    firstLoad = false
                }
            }
        }
        
        // MARK: - Private methods
        
        private func fetchUserPatronages() async
        {
            loadingState = .loading
            
            do
            {
                for patronages in patroned
                {
                    let user = try await Api.Client.shared.request(for: .fetchUserById(id: patronages.godfatherId)) as Api.Types.User
                    patronedList.append(user)
                }
                
                for patronages in patroning
                {
                    let user = try await Api.Client.shared.request(for: .fetchUserById(id: patronages.userId)) as Api.Types.User
                    patroningList.append(user)
                }
            }
            catch AppError.apiAuthorization
            {
                store.error = .apiAuthorization
            }
            catch
            {
                store.error = .network
            }
            
            loadingState = .succeded
        }
        
    }
    
    // MARK: - Private components
    
    private struct UserCard: View
    {
        
        // MARK: - Exposed properties
        
        let user: Api.Types.User
        
        // MARK: - Body
        
        var body: some View
        {
            NavigationLink
            {
                ProfileView(user: user, isSearchedProfile: true)
            }
            label:
            {
                HStack(spacing: 16)
                {
                    AsyncImage(url: URL(string: user.image.link))
                    {
                        $0
                            .resizable()
                            .scaledToFill()
                    }
                    placeholder:
                    {
                        Color.gray
                    }
                    .frame(width: 48, height: 48)
                    .clipShape(.circle)
                    
                    VStack(alignment: .leading, spacing: 2)
                    {
                        Text(user.displayname)
                            .foregroundStyle(.primary)
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        Text(user.email)
                            .foregroundStyle(.secondary)
                            .font(.footnote)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding(.vertical, 8)
        }
        
    }
    
}
