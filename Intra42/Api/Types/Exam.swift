//
//  Exam.swift
//  Intra42
//
//  Created by Marc Mosca on 01/01/2024.
//

import Foundation

extension Api.Types
{
    
    /// A structure representing examinations.
    public struct Exam: Decodable, Identifiable
    {
        
        // MARK: - Exposed properties
        
        public let id: Int
        public let beginAt: Date
        public let endAt: Date
        public let location: String
        public let maxPeople: Int?
        public let nbrSubscribers: Int
        public let name: String
        public let projects: [Projects]
        
        public var numberOfSubscribers: String
        {
            guard let maxPeople = maxPeople else { return nbrSubscribers.formatted() }
            
            return "\(nbrSubscribers) / \(maxPeople)"
        }
        
        // MARK: - Exposed sub-structures
        
        /// A structure representing the projects of an examination.
        public struct Projects: Codable, Identifiable
        {
            public let id: Int
            public let name: String
            public let slug: String
        }
        
    }
    
}
