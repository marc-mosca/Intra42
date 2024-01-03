//
//  Activities+Events.swift
//  Intra42
//
//  Created by Marc Mosca on 03/01/2024.
//

import SwiftUI

extension ActivitiesView
{
    
    struct Events: View
    {
        
        // MARK: - Private properties
        
        @Environment(\.store) private var store
        
        private var userFutureEvents: [Api.Types.Event]
        {
            store.userEvents.filter(\.isInFuture)
        }
        
        // MARK: - Body
        
        var body: some View
        {
            if !userFutureEvents.isEmpty
            {
                List(userFutureEvents, rowContent: EventRow.init)
                    .listStyle(.plain)
            }
            else
            {
                ContentUnavailableView(
                    "No events planned",
                    systemImage: "calendar",
                    description: Text("Register for an event offered by your campus to see it appear here.")
                )
            }
        }
        
    }
    
}
