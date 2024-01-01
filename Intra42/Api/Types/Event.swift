//
//  Event.swift
//  Intra42
//
//  Created by Marc Mosca on 01/01/2024.
//

import Foundation

extension Api.Types
{
    
    /// A structure representing an event.
    public struct Event: Decodable, Identifiable
    {
        
        // MARK: - Exposed properties
        
        public let id: Int
        public let name: String
        public let description: String
        public let location: String
        public let kind: String
        public let maxPeople: Int?
        public let nbrSubscribers: Int
        public let beginAt: Date
        public let endAt: Date
        
        public var isInFuture: Bool
        {
            beginAt > .now
        }
        
        public var beginAtFormatted: String
        {
            let formatStyle = Date.FormatStyle.dateTime.year().month(.wide)
            
            return beginAt.formatted(formatStyle)
        }
        
        public var numberOfSubscribers: String
        {
            guard let maxPeople = maxPeople else { return nbrSubscribers.formatted() }
            
            return "\(nbrSubscribers) / \(maxPeople)"
        }
        
        public var hasWaitlist: Bool
        {
            guard let maxPeople = maxPeople else { return false }
            
            return nbrSubscribers > maxPeople
        }
        
    }
    
}
