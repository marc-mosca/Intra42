//
//  Profile+UserEvents.swift
//  Intra42
//
//  Created by Marc Mosca on 24/01/2024.
//

import SwiftUI

extension ProfileView {
    
    struct UserEvents: View {
        
        // MARK: - Properties
        
        @Binding var viewModel: ViewModel
        
        let events: [Api.Types.Event]
        
        private var eventsChuncked: [[Api.Types.Event]] {
            viewModel.filteredEvents(events: events)
        }
        
        // MARK: - Body
        
        var body: some View {
            List(eventsChuncked, id: \.self) { eventChuncked in
                Section(eventChuncked.first?.beginAtFormatted ?? "N/A") {
                    ForEach(eventChuncked, content: EventRow.init)
                }
            }
            .navigationTitle("Events")
            .searchable(text: $viewModel.searchedEvent)
            .toolbar {
                FilterButton(selection: $viewModel.selectedEventFilter, filters: viewModel.eventsFilters(for: events))
            }
            .overlay {
                if !viewModel.searchedEvent.isEmpty && eventsChuncked.isEmpty {
                    ContentUnavailableView.search(text: viewModel.searchedEvent)
                }
                else if eventsChuncked.isEmpty {
                    ContentUnavailableView(
                        "No events found",
                        systemImage: "calendar",
                        description: Text("You must have taken part in an event to perceive it in the list.")
                    )
                }
            }
        }
        
    }
    
}
