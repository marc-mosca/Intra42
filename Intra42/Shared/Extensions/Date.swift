//
//  Date.swift
//  Intra42
//
//  Created by Marc Mosca on 03/01/2024.
//

import Foundation

extension Date
{
    
    static func duration(beginAt: Date, endAt: Date) -> String
    {
        let dateComponents = Calendar.current.dateComponents([.minute, .hour, .day], from: beginAt, to: endAt)
        
        if let days = dateComponents.day, days > 0
        {
            return String(localized: "\(days) days")
        }
        
        if let hours = dateComponents.hour, hours > 0
        {
            if let minutes = dateComponents.minute, minutes > 0
            {
                return String(localized: "\(hours) hours \(minutes) minutes")
            }
            
            return String(localized: "\(hours) hours")
        }
        
        if let minutes = dateComponents.minute, minutes > 0
        {
            return String(localized: "\(minutes) minutes")
        }
        
        return String(localized: "N/A")
    }
    
    static var currentMonthDate: String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        dateFormatter.locale = Locale.current
        
        return dateFormatter.string(from: .now).capitalized
    }
    
    static func currentMonthLogtime(_ logtime: [Api.Types.Logtime]) -> Double
    {
        logtime.first(where: { $0.fullmonth == currentMonthDate })?.total ?? 0
    }
    
    /// Retrieve the number of working days in the month passed in parameter.
    /// - Parameter dateStr: The month determine the number of working days.
    /// - Returns: Return the number of working days.
    static func getNumberOfDaysToWorkPerMonth(_ dateStr: String) -> Double
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM"
        
        guard let date = dateFormatter.date(from: dateStr) else { return 0.0 }
        
        let calendar = Calendar.current
        let interval = calendar.dateInterval(of: .month, for: date)!
        var count = 0.0
        var currentDate = interval.start
        
        while currentDate < interval.end
        {
            if !calendar.isDateInWeekend(currentDate)
            {
                count += 1
            }
            
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
        }
        
        return count
    }
    
}
