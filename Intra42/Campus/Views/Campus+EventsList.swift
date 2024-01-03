//
//  Campus+EventsList.swift
//  Intra42
//
//  Created by Marc Mosca on 03/01/2024.
//

import SwiftUI

extension CampusView
{
    
    struct EventsList: View
    {
        
        // MARK: - Private properties
        
        @Environment(\.store) private var store
        
        // MARK: - Body
        
        var body: some View
        {
            if !store.campusEvents.isEmpty
            {
                List(store.campusEvents, rowContent: EventRow.init)
                    .listStyle(.plain)
            }
            else
            {
                ContentUnavailableView(
                    "No events planned",
                    systemImage: "calendar",
                    description: Text("No events are planned on your campus.")
                )
            }
        }
        
    }
    
}
