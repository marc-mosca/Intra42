//
//  EventRow.swift
//  Intra42
//
//  Created by Marc Mosca on 01/01/2024.
//

import SwiftUI

struct EventRow: View
{
    
    // MARK: - Exposed properties
    
    let event: Api.Types.Event
    
    // MARK: - Private properties
    
    @Environment(\.store) private var store
    
    private var userIsSubscribe: String
    {
        store.userEvents.contains(where: { $0.id == event.id }) ? String(localized: "Yes") : String(localized: "No")
    }
    
    // MARK: - Body
    
    var body: some View
    {
        NavigationLink
        {
            List
            {
                Section("Informations")
                {
                    HRow(title: "Date", value: event.beginAt)
                    HRow(title: "Duration", value: Date.duration(beginAt: event.beginAt, endAt: event.endAt))
                    HRow(title: "Registered", value: userIsSubscribe)
                    HRow(title: "Subscribers", value: event.numberOfSubscribers)
                    HRow(title: "Location", value: event.location)
                }
                
                Section("Description")
                {
                    Text(event.description)
                }
            }
            .navigationTitle(event.name)
            .navigationBarTitleDisplayMode(.inline)
        }
        label:
        {
            RowLabel(event: event)
        }
    }
}

// MARK: - Extensions

extension EventRow
{
    
    struct RowLabel: View
    {
        
        // MARK: - Exposed properties
        
        let event: Api.Types.Event
        
        // MARK: - Private properties
        
        private var formatStyle: Date.FormatStyle
        {
            .dateTime.day().month().year().hour().minute()
        }
        
        // MARK: - Body
        
        var body: some View
        {
            HStack(spacing: 16)
            {
                Image(systemName: "calendar.badge.clock")
                    .foregroundStyle(.night)
                    .font(.headline)
                    .imageScale(.large)
                
                VStack(alignment: .leading, spacing: 2)
                {
                    Text(event.name)
                        .foregroundStyle(.primary)
                        .font(.system(.subheadline, weight: .semibold))
                    
                    Text(event.beginAt, format: formatStyle)
                        .foregroundStyle(.secondary)
                        .font(.footnote)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.vertical, 8)
        }
        
    }
    
}

// MARK: - Previews

#Preview
{
    EventRow(event: .sample)
}
