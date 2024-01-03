//
//  Activities+Picker.swift
//  Intra42
//
//  Created by Marc Mosca on 03/01/2024.
//

import SwiftUI

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
    
    struct CategoryPicker: View
    {
        
        // MARK: - Exposed properties
        
        @Binding var selection: PickerCategories
        
        // MARK: - Body
        
        var body: some View
        {
            Picker("Select an activity category", selection: $selection)
            {
                ForEach(PickerCategories.allCases)
                {
                    Text(String(localized: $0.title))
                }
            }
            .pickerStyle(.segmented)
            .padding()
        }
        
    }
    
}
