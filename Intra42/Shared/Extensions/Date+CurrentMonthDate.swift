//
//  Date+CurrentMonthDate.swift
//  Intra42
//
//  Created by Marc Mosca on 24/01/2024.
//

import Foundation

extension Date {
    
    static var currentMonthDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        dateFormatter.locale = Locale.current
        
        return dateFormatter.string(from: .now).capitalized
    }
    
}
