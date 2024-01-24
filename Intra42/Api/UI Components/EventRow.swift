//
//  EventRow.swift
//  Intra42
//
//  Created by Marc Mosca on 23/01/2024.
//

import SwiftUI

struct EventRow: View {
    
    // MARK: - Properties
    
    @Environment(\.store) private var store
    @State private var showAlert = false
    
    let event: Api.Types.Event
    
    private var userIsSubscribe: Bool {
        store.userEvents.contains(where: { $0.id == event.id })
    }
    
    private var userIsSubscribeFormatted: String {
        userIsSubscribe ? String(localized: "Yes") : String(localized: "No")
    }
    
    // MARK: - Body
    
    var body: some View {
        NavigationLink {
            List {
                Section("Informations") {
                    HRow(title: "Date", value: event.beginAt)
                    HRow(title: "Duration", value: Date.duration(beginAt: event.beginAt, endAt: event.endAt))
                    HRow(title: "Registered", value: userIsSubscribeFormatted)
                    HRow(title: "Subscribers", value: event.numberOfSubscribers)
                    HRow(title: "Location", value: event.location)
                }
                
                Section("Description") {
                    Text(event.description)
                }
            }
            .navigationTitle(event.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if event.beginAt > .now {
                    ToolbarItem {
                        Button(userIsSubscribe ? "Unsubscribe" : "Subscribe") { showAlert.toggle() }
                    }
                }
            }
            .alert(userIsSubscribe ? "Unsubscribe from the event" : "Subscribe to the event", isPresented: $showAlert) {
                Button("Cancel", role: .cancel) { }
                Button(userIsSubscribe ? "Unsubscribe" : "Subscribe", action: handleUpdateEvents)
            }
            message: {
                Text(
                    userIsSubscribe ? "Do you really want to unsubscribe from this event?"
                    : "Do you really like to subscribe for this event?"
                )
            }
        }
        label: {
            HStack(spacing: 16) {
                Image(systemName: "calendar.badge.clock")
                    .foregroundStyle(.night)
                    .font(.headline)
                    .imageScale(.large)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(event.name)
                        .foregroundStyle(.primary)
                        .font(.system(.subheadline, weight: .semibold))
                    
                    Text(event.beginAt, format: .dateTime.day().month().year().hour().minute())
                        .foregroundStyle(.secondary)
                        .font(.footnote)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.vertical, 8)
        }
    }
    
    // MARK: - Methods
    
    private func handleUpdateEvents() {
        guard let user = store.user else { return }
        
        Task {
            do {
                if userIsSubscribe {
                    let eventUser = try await Api.Client.shared.request(for: .fetchEventUser(userId: user.id, eventId: event.id)) as [Api.Types.EventUser]
                    guard let eventUserId = eventUser.first?.id else { throw AppError.network }
                    try await Api.Client.shared.request(for: .deleteEvent(eventUserId: eventUserId))
                    store.userEvents.removeAll(where: { $0.id == event.id })
                }
                else {
                    try await Api.Client.shared.request(for: .updateUserEvents(userId: user.id, eventId: event.id))
                    store.userEvents.append(event)
                }
            }
            catch AppError.apiAuthorization {
                store.error = .apiAuthorization
            }
            catch {
                store.error = .network
            }
        }
    }
    
}

// MARK: - Previews

#Preview {
    EventRow(event: .sample)
}
