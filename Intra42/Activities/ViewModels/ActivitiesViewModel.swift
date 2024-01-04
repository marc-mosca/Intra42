//
//  ActivitiesViewModel.swift
//  Intra42
//
//  Created by Marc Mosca on 03/01/2024.
//

import Observation
import Foundation

extension ActivitiesView
{
    
    enum PickerCategories: Identifiable, CaseIterable
    {
        case corrections
        case events
        case exams
        
        var id: Self { self }
        
        var title: String.LocalizationValue
        {
            switch self
            {
            case .corrections:
                return "Corrections"
            case .events:
                return "Events"
            case .exams:
                return "Exams"
            }
        }
    }
    
    @Observable
    final class ViewModel
    {
        
        // MARK: - Exposed properties
        
        var loadingState = AppRequestState.succeded
        var selection = PickerCategories.corrections
        
        // MARK: - Exposed methods
        
        func updateUserActivitiesInformations(store: Store) async throws
        {
            guard let user = store.user else { return }
            
            loadingState = .loading
            
            store.userEvents = try await Api.Client.shared.request(for: .fetchUserEvents(userId: user.id))
            store.userExams = try await Api.Client.shared.request(for: .fetchUserExams(userId: user.id))
            store.userScales = try await Api.Client.shared.request(for: .fetchUserScales)
            
            loadingState = .succeded
        }
        
    }
    
}
