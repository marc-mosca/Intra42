//
//  Campus+Picker.swift
//  Intra42
//
//  Created by Marc Mosca on 03/01/2024.
//

import SwiftUI

extension CampusView
{
    
    struct CampusPicker: View
    {
        
        // MARK: - Exposed properties
        
        @Binding var selection: CampusPickerCategories
        
        // MARK: - Body
        
        var body: some View
        {
            Picker("Select an activity category", selection: $selection)
            {
                ForEach(CampusPickerCategories.allCases)
                {
                    Text(String(localized: $0.title))
                }
            }
            .pickerStyle(.segmented)
        }
        
    }
    
}
