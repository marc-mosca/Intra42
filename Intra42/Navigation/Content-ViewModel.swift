//
//  Content-ViewModel.swift
//  Intra42
//
//  Created by Marc Mosca on 23/01/2024.
//

import Foundation

extension ContentView {
    
    @Observable
    final class ViewModel {
        
        // MARK: - Properties
        
        private(set) var loadingState = AppLoadingState.loading
        
        // MARK: - Methods
        
        func fetchGlobalInformations(store: Store) async {
            loadingState = .loading
            
            do {
                let user = try await Api.Client.shared.request(for: .fetchConnectedUser) as Api.Types.User
                
                guard let campusId = user.mainCampus?.campusId, let cursusId = user.mainCursus?.cursusId else { return }
                
                store.user = user
                store.userEvents = try await Api.Client.shared.request(for: .fetchUserEvents(userId: user.id))
                store.userExams = try await Api.Client.shared.request(for: .fetchUserExams(userId: user.id))
                store.userScales = try await Api.Client.shared.request(for: .fetchUserScales)
                
                store.campusEvents = try await Api.Client.shared.request(for: .fetchCampusEvents(campusId: campusId, cursusId: cursusId))
                store.campusExams = try await Api.Client.shared.request(for: .fetchCampusExams(campusId: campusId))
            }
            catch AppError.apiAuthorization {
                store.error = .apiAuthorization
            }
            catch {
                store.error = .network
                store.errorAction = {
                    Task { await self.fetchGlobalInformations(store: store) }
                }
            }
            
            loadingState = .succeded
        }
        
    }
    
}
