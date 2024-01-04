//
//  Scale.swift
//  Intra42
//
//  Created by Marc Mosca on 01/01/2024.
//

import Foundation

extension Api.Types
{
    
    /// A structure representing a correction.
    struct Scale: Decodable, Identifiable
    {
        
        // MARK: - Exposed properties
        
        let id: Int
        let scaleId: Int
        let beginAt: Date
        let correcteds: UncertainValue<String, [User]>?
        let corrector: UncertainValue<String, User>?
        let scale: Details
        let teams: Team?
        
        var members: [Team.User]
        {
            teams?.users ?? []
        }
        
        var teamName: String
        {
            guard !members.isEmpty else { return "someone" }
            
            if let teamName = members.count == 1 ? members.first(where: \.leader)?.login : teams?.name
            {
                return teamName
            }
            
            return "someone"
        }
        
        // MARK: - Exposed sub-structures
        
        /// A structure representing a user of a correction.
        struct User: Decodable, Identifiable
        {
            let id: Int
            let login: String
        }
        
        /// A structure representing the details of a correction.
        struct Details: Decodable, Identifiable
        {
            let id: Int
            let correctionNumber: Int
            let duration: Int
        }
        
        /// A structure representing a correction team.
        struct Team: Decodable, Identifiable
        {
            let id: Int
            let name: String
            let projectId: Int
            let status: String
            let users: [User]
            let locked: Bool
            let validated: Bool?
            let closed: Bool
            let lockedAt: Date?
            let closedAt: Date?
            
            /// A structure representing a user in a team.
            struct User: Decodable, Identifiable
            {
                let id: Int
                let login: String
                let leader: Bool
            }
            
            private enum CodingKeys: String, CodingKey
            {
                case id
                case name
                case projectId
                case status
                case users
                case locked = "locked?"
                case validated = "validated?"
                case closed = "closed?"
                case lockedAt
                case closedAt
            }
            
        }
        
    }
    
}
