//
//  Profile+UserEvents.swift
//  Intra42
//
//  Created by Marc Mosca on 06/01/2024.
//

import SwiftUI

extension ProfileView
{
    
    struct UserEvents: View
    {
        
        // MARK: - Private properties
        
        @Environment(\.store) private var store
        
        @State private var selectedFilter = String(localized: "All")
        @State private var searched = ""
        
        private var filters: [String]
        {
            var filtersSet = Set(store.userEvents.map(\.kind.capitalized))
            filtersSet.insert(String(localized: "All"))
            return Array(filtersSet).sorted()
        }
        
        private var eventsFiltered: [Api.Types.Event]
        {
            let filteredEvents = selectedFilter != String(localized: "All") ? store.userEvents.filter { $0.kind.capitalized == selectedFilter } : store.userEvents
            
            guard !searched.isEmpty else { return filteredEvents }
            
            return filteredEvents.filter { $0.name.lowercased().contains(searched.lowercased()) }
        }
        
        private var eventsChucked: [[Api.Types.Event]]
        {
            let events = eventsFiltered.sorted(by: { $0.beginAt > $1.beginAt })
            let eventsChuncked = events.chunked(by: { Calendar.current.isDate($0.beginAt, equalTo: $1.beginAt, toGranularity: .month) })
            
            return eventsChuncked.map { Array($0) }
        }
        
        // MARK: - Body
        
        var body: some View
        {
            List(eventsChucked, id: \.self)
            {
                eventsSection(events: $0)
            }
            .navigationTitle("Events")
            .searchable(text: $searched)
            .toolbar
            {
                FilterButton(selection: $selectedFilter, filters: filters)
            }
            .overlay
            {
                if !searched.isEmpty && eventsChucked.isEmpty
                {
                    ContentUnavailableView.search(text: searched)
                }
                else if eventsChucked.isEmpty
                {
                    ContentUnavailableView(
                        "No events found",
                        systemImage: "calendar",
                        description: Text("You must have taken part in an event to perceive it in the list.")
                    )
                }
            }
        }
        
        // MARK: - Private components
        
        private func eventsSection(events: [Api.Types.Event]) -> some View
        {
            Section(events.first?.beginAtFormatted ?? "N/A")
            {
                ForEach(events, content: EventRow.init)
            }
        }
        
    }
    
}
