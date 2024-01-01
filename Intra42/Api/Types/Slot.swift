//
//  Slot.swift
//  Intra42
//
//  Created by Marc Mosca on 01/01/2024.
//

import Foundation

extension Api.Types
{
    
    /// A structure representing a correction slot.
    public struct Slot: Decodable, Identifiable
    {
        
        // MARK: - Exposed properties
        
        public let id: Int
        public let beginAt: Date
        public let endAt: Date
        public let scaleTeam: UncertainValue<String, ScaleTeam>?
        public let user: User
        
        // MARK: - Exposed sub-structures
        
        /// A structure representing a user of a correction slot.
        public struct User: Codable, Identifiable
        {
            public let id: Int
            public let login: String
        }
        
        /// A structure representing a team in a correction slot.
        public struct ScaleTeam: Codable, Identifiable
        {
            public let id: Int
            public let scaleId: Int
            public let beginAt: Date
            public let correcteds: [Slot.User]
            public let corrector: Slot.User
        }
        
    }
    
}
