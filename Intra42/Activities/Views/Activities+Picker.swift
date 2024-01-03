//
//  Activities+Picker.swift
//  Intra42
//
//  Created by Marc Mosca on 03/01/2024.
//

import SwiftUI

extension ActivitiesView
{
    
    enum PickerCategories: String, Identifiable, CaseIterable
    {
        case corrections
        case events
        case exams
        
        var id: Self { self }
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
                    Text($0.rawValue.capitalized)
                }
            }
            .pickerStyle(.segmented)
            .padding()
        }
        
    }
    
}
