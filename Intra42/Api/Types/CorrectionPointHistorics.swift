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
    struct CorrectionPointHistorics: Decodable, Identifiable
    {
        
        // MARK: - Exposed properties
        
        let id: Int
        let scaleTeamId: Int?
        let total: Int
        let createdAt: Date
        let updatedAt: Date
        
        var date: Date
        {
            let calendar = Calendar.current
            let dateComponents = calendar.dateComponents([.year, .month, .day], from: createdAt)
            
            return calendar.date(from: dateComponents) ?? .now
        }
        
    }
    
}
