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
    struct Slot: Decodable, Identifiable
    {
        
        // MARK: - Exposed properties
        
        let id: Int
        let beginAt: Date
        let endAt: Date
        let scaleTeam: UncertainValue<String, ScaleTeam>?
        let user: User
        
        // MARK: - Exposed sub-structures
        
        /// A structure representing a user of a correction slot.
        struct User: Codable, Identifiable
        {
            let id: Int
            let login: String
        }
        
        /// A structure representing a team in a correction slot.
        struct ScaleTeam: Codable, Identifiable
        {
            let id: Int
            let scaleId: Int
            let beginAt: Date
            let correcteds: [Slot.User]
            let corrector: Slot.User
        }
        
    }
    
}
