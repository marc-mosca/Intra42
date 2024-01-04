//
//  Setting+Help.swift
//  Intra42
//
//  Created by Marc Mosca on 04/01/2024.
//

import SwiftUI

extension SettingView
{
    
    struct HelpSetting: View
    {
        
        // MARK: - Private properties
        
        private let url = URL(string: "https://github.com/marc-mosca/Intra42/issues")!
        
        // MARK: - Body
        
        var body: some View
        {
            Section("Help")
            {
                Link("Report a problem", destination: url)
                    .foregroundStyle(.primary)
            }
        }
        
    }
    
}
