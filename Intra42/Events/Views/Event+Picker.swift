//
//  Event+Picker.swift
//  Intra42
//
//  Created by Marc Mosca on 03/01/2024.
//

import SwiftUI

extension EventView
{
    
    struct EventPicker: View
    {
        
        // MARK: - Exposed properties
        
        @Binding var selection: EventPickerCategories
        
        // MARK: - Body
        
        var body: some View
        {
            Picker("Select an activity category", selection: $selection)
            {
                ForEach(EventPickerCategories.allCases)
                {
                    Text(String(localized: $0.title))
                }
            }
            .pickerStyle(.segmented)
        }
        
    }
    
}
