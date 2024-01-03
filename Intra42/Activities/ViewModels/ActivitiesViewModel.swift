//
//  ActivitiesViewModel.swift
//  Intra42
//
//  Created by Marc Mosca on 03/01/2024.
//

import Observation
import Foundation

extension ActivitiesView
{
    
    enum PickerCategories: Identifiable, CaseIterable
    {
        case corrections
        case events
        case exams
        
        var id: Self { self }
        
        var title: String.LocalizationValue
        {
            switch self
            {
            case .corrections:
                return "Corrections"
            case .events:
                return "Events"
            case .exams:
                return "Exams"
            }
        }
    }
    
    @Observable
    final class ViewModel
    {
        
        // MARK: - Exposed properties
        
        var selection = PickerCategories.corrections
        
        // MARK: - Exposed methods
        
        func updateUserActivitiesInformations() async
        {
        }
        
    }
    
}
