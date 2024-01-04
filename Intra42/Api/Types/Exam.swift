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
    struct Exam: Decodable, Identifiable
    {
        
        // MARK: - Exposed properties
        
        let id: Int
        let beginAt: Date
        let endAt: Date
        let location: String
        let maxPeople: Int?
        let nbrSubscribers: Int
        let name: String
        let projects: [Projects]
        
        var numberOfSubscribers: String
        {
            guard let maxPeople = maxPeople else { return nbrSubscribers.formatted() }
            
            return "\(nbrSubscribers) / \(maxPeople)"
        }
        
        // MARK: - Exposed sub-structures
        
        /// A structure representing the projects of an examination.
        struct Projects: Codable, Identifiable
        {
            public let id: Int
            public let name: String
            public let slug: String
        }
        
    }
    
}
