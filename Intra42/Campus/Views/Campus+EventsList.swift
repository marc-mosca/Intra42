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
        
        // MARK: - Exposed properties
        
        let events: [Api.Types.Event]
        
        // MARK: - Body
        
        var body: some View
        {
            if !events.isEmpty
            {
                List(events, rowContent: EventRow.init)
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
