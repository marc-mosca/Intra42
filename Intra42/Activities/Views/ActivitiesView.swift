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
    
    @State private var viewModel = ViewModel()
    
    // MARK: - Body
    
    var body: some View
    {
        NavigationStack
        {
            VStack
            {
                CategoryPicker(selection: $viewModel.selection)
                
                switch viewModel.selection
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
