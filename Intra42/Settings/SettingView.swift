//
//  SettingView.swift
//  Intra42
//
//  Created by Marc Mosca on 04/01/2024.
//

import SwiftUI

struct SettingView: View
{
    
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
                HelpSetting()
                AccountSetting()
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
                                                                                            
