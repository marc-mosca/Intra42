//
//  Profile+UserPatronages.swift
//  Intra42
//
//  Created by Marc Mosca on 24/01/2024.
//

import SwiftUI

extension ProfileView {
    
    struct UserPatronages: View {
        
        // MARK: - Properties
        
        @Environment(\.store) private var store
        @Binding var viewModel: ViewModel
        
        let patroned: [Api.Types.User.Patronages]
        let patroning: [Api.Types.User.Patronages]
        
        // MARK: - Body
        
        var body: some View {
            VStack {
                if viewModel.loadingState != .succeded {
                    ProgressView()
                }
                else if viewModel.patronedList.isEmpty && viewModel.patroningList.isEmpty {
                    ContentUnavailableView("No patronage found", systemImage: "person.2.fill")
                }
                else {
                    List {
                        if !viewModel.patronedList.isEmpty {
                            Section("Patroned") {
                                ForEach(viewModel.patronedList, content: UserCard.init)
                            }
                        }
                        
                        if !viewModel.patroningList.isEmpty {
                            Section("Patroning") {
                                ForEach(viewModel.patroningList, content: UserCard.init)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Patronages")
            .task {
                if viewModel.firstLoad {
                    await viewModel.fetchUserPatronages(store: store, patroned: patroned, patroning: patroning)
                    viewModel.firstLoad = false
                }
            }
        }
        
        // MARK: - Extensions
        
        private struct UserCard: View {
            
            // MARK: - Exposed properties
            
            let user: Api.Types.User
            
            // MARK: - Body
            
            var body: some View {
                NavigationLink {
                    ProfileView(user: user, isSearchedProfile: true)
                }
                label: {
                    HStack(spacing: 16) {
                        AsyncImage(url: URL(string: user.image.link)) {
                            $0
                                .resizable()
                                .scaledToFill()
                        }
                        placeholder: { Color.gray }
                        .frame(width: 48, height: 48)
                        .clipShape(.circle)
                        
                        VStack(alignment: .leading, spacing: 2) {
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
    
}
