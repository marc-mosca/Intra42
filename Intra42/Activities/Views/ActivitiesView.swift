//
//  ActivitiesView.swift
//  Intra42
//
//  Created by Marc Mosca on 03/01/2024.
//

import SwiftUI

struct ActivitiesView: View
{
    
    // MARK: - Private properties
    
    @State private var selection = PickerCategories.corrections
    
    // MARK: - Body
    
    var body: some View
    {
        NavigationStack
        {
            VStack
            {
                CategoryPicker(selection: $selection)
                
                switch selection
                {
                case .corrections:
                    Correction()
                case .events:
                    Events()
                case .exams:
                    Text("Exams")
                }
            }
            .navigationTitle("My Activities")
        }
    }
}

// MARK: - Previews

#Preview
{
    ActivitiesView()
}
