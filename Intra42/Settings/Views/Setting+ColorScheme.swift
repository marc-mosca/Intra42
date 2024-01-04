//
//  Setting+ColorScheme.swift
//  Intra42
//
//  Created by Marc Mosca on 04/01/2024.
//

import SwiftUI

extension SettingView
{
    
    struct ColorSchemeSetting: View
    {
        
        // MARK: - Private properties
        
        @AppStorage("userDefaultColorScheme") private var userDefaultColorScheme: Int?
        
        private var selection: Binding<Int>
        {
            Binding
            {
                userDefaultColorScheme ?? 0
            }
            set:
            {
                userDefaultColorScheme = $0 == 0 ? nil : $0
            }
        }
        
        // MARK: - Body
        
        var body: some View
        {
            Section
            {
                Picker("Theme", selection: selection)
                {
                    ForEach(AppColorScheme.allCases)
                    {
                        Text($0.title)
                            .tag($0.rawValue)
                    }
                }
            }
            footer:
            {
                Text("Set the default theme for the application.")
            }
        }
        
    }
    
}
