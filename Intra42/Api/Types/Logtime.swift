//
//  Logtime.swift
//  Intra42
//
//  Created by Marc Mosca on 01/01/2024.
//

import Foundation

extension Api.Types
{
    
    public typealias LogtimeResult = [String: String]
    
    /// A structure representing the user's logtime.
    public struct Logtime: Decodable, Identifiable
    {
        
        // MARK: - Exposed properties
        
        public var id = UUID()
        
        public let month: String
        public let total: Double
        public let details: LogtimeResult
        public let numberOfDaysToWork: Double
        
        public var fullmonth: String
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
