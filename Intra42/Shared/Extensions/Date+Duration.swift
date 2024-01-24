//
//  Date+Duration.swift
//  Intra42
//
//  Created by Marc Mosca on 23/01/2024.
//

import Foundation

extension Date {
    
    static func duration(beginAt: Date, endAt: Date) -> String
    {
        let dateComponents = Calendar.current.dateComponents([.minute, .hour, .day], from: beginAt, to: endAt)
        
        if let days = dateComponents.day, days > 0 {
            return String(localized: "\(days) days")
        }
        
        if let hours = dateComponents.hour, hours > 0 {
            if let minutes = dateComponents.minute, minutes > 0 {
                return String(localized: "\(hours) hours \(minutes) minutes")
            }
            
            return String(localized: "\(hours) hours")
        }
        
        if let minutes = dateComponents.minute, minutes > 0 {
            return String(localized: "\(minutes) minutes")
        }
        
        return String(localized: "N/A")
    }
    
}
