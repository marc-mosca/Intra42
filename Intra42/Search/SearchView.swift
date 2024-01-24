//
//  SearchView.swift
//  Intra42
//
//  Created by Marc Mosca on 24/01/2024.
//

import SwiftData
import SwiftUI

struct SearchView: View {
    
    // MARK: - Properties
    
    @Environment(\.store) private var store
    @Environment(\.modelContext) private var modelContext
    
    @Query private var historySearch: [HistorySearch]
    @State private var viewModel = ViewModel()
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                if viewModel.searchedSucceded == false {
                    ContentUnavailableView.search(text: viewModel.searched)
                }
                else {
                    if historySearch.isEmpty {
                        ContentUnavailableView(
                            "No history search",
                            systemImage: "magnifyingglass",
                            description: Text("Search for a student to see them appear on this list.")
                        )
                    }
                    else {
                        VStack(alignment: .leading, spacing: 20) {
                            Text("Search history")
                                .foregroundStyle(.primary)
                                .font(.headline)
                                .padding([.top, .horizontal])
                            
                            List {
                                ForEach(historySearch.reversed()) {
                                    userCard(user: $0)
                                }
                                .onDelete {
                                    viewModel.onDelete(indexSet: $0, modelContext: modelContext, historySearch: historySearch)
                                }
                            }
                            .listStyle(.plain)
                        }
                    }
                }
            }
            .navigationTitle("Search")
            .searchable(text: $viewModel.searched)
            .autocorrectionDisabled()
            .onAppear(perform: viewModel.resetSearch)
            .onChange(of: viewModel.searched, viewModel.resetSearch)
            .onSubmit(of: .search) {
                Task {
                    await viewModel.fetchUser(login: viewModel.searched.lowercased(), store: store, modelContext: modelContext, historySearch: historySearch)
                }
            }
            .navigationDestination(isPresented: .constant(viewModel.searchedSucceded == true)) {
                if let user = viewModel.user {
                    ProfileView(user: user, isSearchedProfile: true)
                }
            }
        }
    }
    
    // MARK: - Extensions
    
    @MainActor private func userCard(user: HistorySearch) -> some View {
        HStack {
            AsyncImage(url: URL(string: user.image)) {
                $0
                    .resizable()
                    .scaledToFill()
            }
            placeholder: { Color.gray }
            .frame(width: 48, height: 48)
            .clipShape(.circle)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(user.login)
                    .foregroundStyle(.primary)
                    .font(.headline)
                
                Text(user.email)
                    .foregroundStyle(.secondary)
                    .font(.footnote)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.vertical, 8)
        .onTapGesture {
            Task {
                await viewModel.fetchUser(login: user.login, store: store, modelContext: modelContext, historySearch: historySearch)
            }
        }
    }

    
}

// MARK: - Previews

#Preview {
    SearchView()
}
