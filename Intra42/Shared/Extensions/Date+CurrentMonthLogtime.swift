//
//  Date+CurrentMonthLogtime.swift
//  Intra42
//
//  Created by Marc Mosca on 24/01/2024.
//

import Foundation

extension Date {
    
    static func currentMonthLogtime(_ logtime: [Api.Types.Logtime]) -> Double {
        logtime.first(where: { $0.fullmonth == currentMonthDate })?.total ?? 0
    }
    
}
