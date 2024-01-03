//
//  Activities+Picker.swift
//  Intra42
//
//  Created by Marc Mosca on 03/01/2024.
//

import SwiftUI

extension ActivitiesView
{
    
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
