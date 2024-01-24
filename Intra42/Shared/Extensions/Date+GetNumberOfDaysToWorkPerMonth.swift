//
//  Date+GetNumberOfDaysToWorkPerMonth.swift
//  Intra42
//
//  Created by Marc Mosca on 24/01/2024.
//

import Foundation

extension Date {
    
    /// Retrieve the number of working days in the month passed in parameter.
    /// - Parameter dateStr: The month determine the number of working days.
    /// - Returns: Return the number of working days.
    static func getNumberOfDaysToWorkPerMonth(_ dateStr: String) -> Double {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM"
        
        guard let date = dateFormatter.date(from: dateStr) else { return 0.0 }
        
        let calendar = Calendar.current
        let interval = calendar.dateInterval(of: .month, for: date)!
        var count = 0.0
        var currentDate = interval.start
        
        while currentDate < interval.end {
            if !calendar.isDateInWeekend(currentDate) {
                count += 1
            }
            
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
        }
        
        return count
    }
    
}
