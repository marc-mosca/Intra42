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
    public struct Scale: Decodable, Identifiable
    {
        
        // MARK: - Exposed properties
        
        public let id: Int
        public let scaleId: Int
        public let beginAt: Date
        public let correcteds: UncertainValue<String, [User]>?
        public let corrector: UncertainValue<String, User>?
        public let scale: Details
        public let teams: Team?
        
        public var members: [Team.User]
        {
            teams?.users ?? []
        }
        
        public var teamName: String
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
        public struct User: Decodable, Identifiable
        {
            public let id: Int
            public let login: String
        }
        
        /// A structure representing the details of a correction.
        public struct Details: Decodable, Identifiable
        {
            public let id: Int
            public let correctionNumber: Int
            public let duration: Int
        }
        
        /// A structure representing a correction team.
        public struct Team: Decodable, Identifiable
        {
            public let id: Int
            public let name: String
            public let projectId: Int
            public let status: String
            public let users: [User]
            public let locked: Bool
            public let validated: Bool?
            public let closed: Bool
            public let lockedAt: Date?
            public let closedAt: Date?
            
            /// A structure representing a user in a team.
            public struct User: Decodable, Identifiable
            {
                public let id: Int
                public let login: String
                public let leader: Bool
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
