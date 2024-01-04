//
//  Logtime.swift
//  Intra42
//
//  Created by Marc Mosca on 01/01/2024.
//

import Foundation

extension Api.Types
{
    
    typealias LogtimeResult = [String: String]
    
    /// A structure representing the user's logtime.
    struct Logtime: Decodable, Identifiable
    {
        
        // MARK: - Exposed properties
        
        var id = UUID()
        
        let month: String
        let total: Double
        let details: LogtimeResult
        let numberOfDaysToWork: Double
        
        var fullmonth: String
        {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM"
            dateFormatter.locale = Locale.current
            
            guard let date = dateFormatter.date(from: month) else { return "N/A" }
            
            dateFormatter.dateFormat = "MMMM yyyy"
            return dateFormatter.string(from: date).capitalized
        }
        
    }
    
}
