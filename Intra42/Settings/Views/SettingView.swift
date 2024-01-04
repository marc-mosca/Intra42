//
//  SettingView.swift
//  Intra42
//
//  Created by Marc Mosca on 04/01/2024.
//

import SwiftUI

struct SettingView: View
{
    
    // MARK: - Private properties
    
    @State private var viewModel = ViewModel()
    
    // MARK: - Body
    
    var body: some View
    {
        NavigationStack
        {
            List
            {
                ColorSchemeSetting()
                LanguageSetting()
                LogtimeSetting()
            }
            .navigationTitle("Settings")
        }
    }
    
}

// MARK: - Previews

#Preview
{
    SettingView()
}
                                                                                            
