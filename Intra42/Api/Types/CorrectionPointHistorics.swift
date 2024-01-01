//
//  CorrectionPointHistorics.swift
//  Intra42
//
//  Created by Marc Mosca on 01/01/2024.
//

import Foundation

extension Api.Types
{
    
    /// A structure representing the user's correction point history.
    public struct CorrectionPointHistorics: Decodable, Identifiable
    {
        
        // MARK: - Exposed properties
        
        public let id: Int
        public let scaleTeamId: Int?
        public let total: Int
        public let createdAt: Date
        public let updatedAt: Date
        
        public var date: Date
        {
            let calendar = Calendar.current
            let dateComponents = calendar.dateComponents([.year, .month, .day], from: createdAt)
            
            return calendar.date(from: dateComponents) ?? .now
        }
        
    }
    
}
