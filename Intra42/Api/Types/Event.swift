//
//  Event.swift
//  Intra42
//
//  Created by Marc Mosca on 15/01/2024.
//

import Foundation

extension Api.Types {
    
    /// An object representing events for deletion to the API.
    struct EventUser: Decodable, Identifiable {
        
        // MARK: - Exposed properties
        
        let id: Int
        let eventId: Int
        let userId: Int
        
    }
    
    /// A structure representing an event.
    struct Event: Decodable, Identifiable, Hashable {
        
        // MARK: - Exposed properties
        
        let id: Int
        let name: String
        let description: String
        let location: String
        let kind: String
        let maxPeople: Int?
        let nbrSubscribers: Int
        let beginAt: Date
        let endAt: Date
        
        var isInFuture: Bool { beginAt > .now }
        var beginAtFormatted: String { beginAt.formatted(.dateTime.year().month(.wide)) }
        
        var numberOfSubscribers: String {
            guard let maxPeople = maxPeople else { return nbrSubscribers.formatted() }
            return "\(nbrSubscribers) / \(maxPeople)"
        }
        
        var hasWaitlist: Bool {
            guard let maxPeople = maxPeople else { return false }
            return nbrSubscribers > maxPeople
        }
        
    }
    
}
