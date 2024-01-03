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
                    Corrections()
                case .events:
                    Events()
                case .exams:
                    Exams()
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
