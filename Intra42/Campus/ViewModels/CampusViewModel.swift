//
//  CampusViewModel.swift
//  Intra42
//
//  Created by Marc Mosca on 03/01/2024.
//

import Observation
import Foundation

extension CampusView
{
    
    enum CampusPickerCategories: Identifiable, CaseIterable
    {
        case events
        case exams
        
        var id: Self { self }
        
        var title: String.LocalizationValue
        {
            switch self
            {
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
        var selection = CampusPickerCategories.events
        var searched = ""
        var selectedFilter = String(localized: "All")
        
        // MARK: - Exposed methods
        
        func fetchFilters(events: [Api.Types.Event]) -> [String]
        {
            var filters = [String]()
            
            if selection == .events
            {
                let filtersSet = Set(events.map(\.kind.capitalized))
                filters = Array(filtersSet)
            }
            
            filters.append(String(localized: "All"))
            
            return filters.sorted()
        }
        
        func filter(for events: [Api.Types.Event]) -> [Api.Types.Event]
        {
            let filteredEvents = selectedFilter != String(localized: "All") ? events.filter { $0.kind.capitalized == selectedFilter } : events
            
            guard !searched.isEmpty else { return filteredEvents }
            
            return filteredEvents.filter { $0.name.lowercased().contains(searched.lowercased()) }
        }
        
        func filter(for exams: [Api.Types.Exam]) -> [Api.Types.Exam]
        {
            guard !searched.isEmpty else { return exams }
            
            return exams.filter { $0.name.lowercased().contains(searched.lowercased()) }
        }
        
        func resetFilterOnCategoryChange()
        {
            selectedFilter = String(localized: "All")
        }
        
        func updateCampusActivities(store: Store) async throws
        {
            guard let user = store.user, let campusId = user.mainCampus?.campusId, let cursusId = user.mainCursus?.cursusId else { return }
            
            loadingState = .loading
            
            store.campusEvents = try await Api.Client.shared.request(for: .fetchCampusEvents(campusId: campusId, cursusId: cursusId))
            store.campusExams = try await Api.Client.shared.request(for: .fetchCampusExams(campusId: campusId))
            
            loadingState = .succeded
        }
        
    }
    
}
