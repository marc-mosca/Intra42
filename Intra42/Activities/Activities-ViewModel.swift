//
//  Activities-ViewModel.swift
//  Intra42
//
//  Created by Marc Mosca on 23/01/2024.
//

import Foundation

extension ActivitiesView {
    
    enum ActivitiesPickerCategory: Identifiable, CaseIterable {
        
        // MARK: - Properties
        
        case corrections, events, exams
        
        var id: Self { self }
        
        var title: String {
            switch self {
            case .corrections:      return String(localized: "Corrections")
            case .events:           return String(localized: "Events")
            case .exams:            return String(localized: "Exams")
            }
        }
        
    }
    
    @Observable
    final class ViewModel {
        
        // MARK: - Properties
        
        private(set) var loadingState = AppLoadingState.succeded
        var selection = ActivitiesPickerCategory.corrections
        
        // MARK: - Methods
        
        func updateUserActivitiesInformations(store: Store) {
            guard let user = store.user else { return }
            
            Task {
                loadingState = .loading
                
                do {
                    store.userEvents.removeAll()
                    store.userExams.removeAll()
                    store.userScales.removeAll()
                    
                    store.userEvents = try await Api.Client.shared.request(for: .fetchUserEvents(userId: user.id))
                    store.userExams = try await Api.Client.shared.request(for: .fetchUserExams(userId: user.id))
                    store.userScales = try await Api.Client.shared.request(for: .fetchUserScales)
                }
                catch AppError.apiAuthorization {
                    store.error = .apiAuthorization
                }
                catch {
                    store.error = .network
                }
                
                loadingState = .succeded
            }
        }
        
    }
    
}
