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
    
    // MARK: - Body
    
    var body: some View
    {
        NavigationLink
        {
            RowDestination(event: event)
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
    
    struct RowDestination: View
    {
        
        // MARK: - Exposed properties
        
        let event: Api.Types.Event
        
        // MARK: - Private properties
        
        @Environment(\.store) private var store
        @AppStorage("userIsConnected") private var userIsConnected: Bool?
        @State private var showAlert = false
        
        private var userIsSubscribe: Bool
        {
            store.userEvents.contains(where: { $0.id == event.id })
        }
        
        private var userIsSubscribeFormatted: String
        {
            userIsSubscribe ? String(localized: "Yes") : String(localized: "No")
        }
        
        // MARK: - Body
        
        var body: some View
        {
            List
            {
                Section("Informations")
                {
                    HRow(title: "Date", value: event.beginAt)
                    HRow(title: "Duration", value: Date.duration(beginAt: event.beginAt, endAt: event.endAt))
                    HRow(title: "Registered", value: userIsSubscribeFormatted)
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
            .toolbar
            {
                if event.beginAt > .now
                {
                    ToolbarItem
                    {
                        Button(userIsSubscribe ? "Unsubscribe" : "Subscribe")
                        {
                            showAlert.toggle()
                        }
                    }
                }
            }
            .alert(userIsSubscribe ? "Unsubscribe from the event" : "Subscribe to the event", isPresented: $showAlert)
            {
                Button("Cancel", role: .cancel) { }
                Button(userIsSubscribe ? "Unsubscribe" : "Subscribe", action: handleUpdateEvents)
            }
        message:
            {
                Text(
                    userIsSubscribe ? "Do you really want to unsubscribe from this event?"
                    : "Do you really like to subscribe for this event?"
                )
            }
        }
        
        // MARK: - Private methods
        
        private func handleUpdateEvents()
        {
            guard let user = store.user else { return }
            
            Task
            {
                do
                {
                    switch userIsSubscribe
                    {
                    case true:
                        try await unsubscribe(user: user, event: event)
                    case false:
                        try await subscribe(user: user, event: event)
                    }
                }
                catch AppError.apiAuthorization
                {
                    store.error = .apiAuthorization
                    store.errorAction = {
                        Api.Keychain.shared.clear()
                        userIsConnected = false
                    }
                }
                catch
                {
                    store.error = .network
                }
            }
        }
        
        private func unsubscribe(user: Api.Types.User, event: Api.Types.Event) async throws
        {
            let eventUser = try await Api.Client.shared.request(for: .fetchEventUser(userId: user.id, eventId: event.id)) as [Api.Types.EventUser]
            guard let eventUserId = eventUser.first?.id else { throw AppError.network }
            try await Api.Client.shared.request(for: .deleteEvent(eventUserId: eventUserId))
            store.userEvents.removeAll(where: { $0.id == event.id })
        }
        
        private func subscribe(user: Api.Types.User, event: Api.Types.Event) async throws
        {
            try await Api.Client.shared.request(for: .updateUserEvents(userId: user.id, eventId: event.id))
            store.userEvents.append(event)
        }
        
    }
    
}

// MARK: - Previews

#Preview
{
    EventRow(event: .sample)
}
