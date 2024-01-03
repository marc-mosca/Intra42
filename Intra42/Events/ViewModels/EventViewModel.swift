//
//  EventViewModel.swift
//  Intra42
//
//  Created by Marc Mosca on 03/01/2024.
//

import Observation
import Foundation

extension EventView
{
    
    enum EventPickerCategories: Identifiable, CaseIterable
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
        
        var selection = EventPickerCategories.events
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
        
        func resetFilterOnCategoryChange()
        {
            selectedFilter = String(localized: "All")
        }
        
    }
    
}
