//
//  Search-ViewModel.swift
//  Intra42
//
//  Created by Marc Mosca on 24/01/2024.
//

import Foundation
import SwiftData

extension SearchView {
    
    @Observable
    final class ViewModel {
        
        // MARK: - Properties
        
        var searched = ""
        var searchedSucceded: Bool?
        var user: Api.Types.User?
        
        // MARK: - Methods
        
        @MainActor func fetchUser(login: String, store: Store, modelContext: ModelContext, historySearch: [HistorySearch]) async {
            do {
                let result = try await Api.Client.shared.request(for: .fetchUserByLogin(login: login)) as Api.Types.User
                
                user = result
                searchedSucceded = true
                
                guard !historySearch.contains(where: { $0.login == result.login }) else { return }
                
                let newHistoryUser = HistorySearch(login: result.login, email: result.email, image: result.image.link)
                
                modelContext.insert(newHistoryUser)
            }
            catch AppError.apiAuthorization {
                store.error = .apiAuthorization
            }
            catch {
                searchedSucceded = false
            }
        }
        
        func onDelete(indexSet: IndexSet, modelContext: ModelContext, historySearch: [HistorySearch]) {
            let count = historySearch.count - 1
            
            for index in indexSet {
                modelContext.delete(historySearch[count - index])
            }
        }
        
        func resetSearch() {
            searchedSucceded = nil
        }
        
    }
    
}
