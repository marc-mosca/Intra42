//
//  Campus-ViewModel.swift
//  Intra42
//
//  Created by Marc Mosca on 24/01/2024.
//

import Foundation

extension CampusView {
    
    enum CampusPickerCategory: Identifiable, CaseIterable {
        
        // MARK: - Properties
        
        case events, exams
        
        var id: Self { self }
        
        var title: String {
            switch self {
            case .events:       return String(localized: "Events")
            case .exams:        return String(localized: "Exams")
            }
        }
        
    }
    
    @Observable
    final class ViewModel {
        
        // MARK: - Properties
        
        private(set) var loadingState = AppLoadingState.succeded
        
        var selection = CampusPickerCategory.events
        var searched = ""
        var selectedFilter = String(localized: "All")
        
        // MARK: - Methods
        
        func filters(for events: [Api.Types.Event]) -> [String] {
            var filters = Set(events.map(\.kind.capitalized))
            filters.insert(String(localized: "All"))
            return Array(filters).sorted()
        }
        
        func futureEvents(_ events: [Api.Types.Event]) -> [Api.Types.Event] {
            let filteredEvents = selectedFilter != String(localized: "All") ? events.filter { $0.kind.capitalized == selectedFilter } : events
            
            guard !searched.isEmpty else { return filteredEvents }
            
            return filteredEvents.filter { $0.name.lowercased().contains(searched.lowercased()) }
        }
        
        func futureExams(_ exams: [Api.Types.Exam]) -> [Api.Types.Exam] {
            guard !searched.isEmpty else { return exams }
            
            return exams.filter { $0.name.lowercased().contains(searched.lowercased()) }
        }
        
        func resetSelectedFilter() {
            selectedFilter = String(localized: "All")
        }
        
        func updateCampusActivities(store: Store) {
            guard let user = store.user, let campusId = user.mainCampus?.campusId, let cursusId = user.mainCursus?.cursusId else { return }
            
            Task {
                loadingState = .loading
                
                do {
                    store.campusEvents.removeAll()
                    store.campusExams.removeAll()
                    
                    store.campusEvents = try await Api.Client.shared.request(for: .fetchCampusEvents(campusId: campusId, cursusId: cursusId))
                    store.campusExams = try await Api.Client.shared.request(for: .fetchCampusExams(campusId: campusId))
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
