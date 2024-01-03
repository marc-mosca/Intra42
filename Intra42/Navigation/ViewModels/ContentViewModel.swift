//
//  ContentViewModel.swift
//  Intra42
//
//  Created by Marc Mosca on 03/01/2024.
//

import Observation
import Foundation

extension ContentView
{
    
    @Observable
    final class ViewModel
    {
        
        // MARK: - Exposed properties
        
        enum LoadingState
        {
            case loading
            case succeded
            case failed
        }
        
        var loadingState = LoadingState.loading
        
        // MARK: - Exposed methods
        
        func fetchGlobalInformations(store: Store) async throws
        {
            loadingState = .loading
            
            let user = try await Api.Client.shared.request(for: .fetchConnectedUser) as Api.Types.User
            
            guard let campusId = user.mainCampus?.campusId, let cursusId = user.mainCursus?.cursusId else { return }
            
            store.user = user
            store.userEvents = try await Api.Client.shared.request(for: .fetchUserEvents(userId: user.id))
            store.userExams = try await Api.Client.shared.request(for: .fetchUserExams(userId: user.id))
            store.userScales = try await Api.Client.shared.request(for: .fetchUserScales)
            
            store.campusEvents = try await Api.Client.shared.request(for: .fetchCampusEvents(campusId: campusId, cursusId: cursusId))
            store.campusExams = try await Api.Client.shared.request(for: .fetchCampusExams(campusId: campusId))
            
            loadingState = .succeded
        }
        
    }
    
}
