//
//  Setting+Logtime.swift
//  Intra42
//
//  Created by Marc Mosca on 04/01/2024.
//

import SwiftUI

extension SettingView
{
    
    struct LogtimeSetting: View
    {
        
        // MARK: - Private properties
        
        @AppStorage("userDefaultLogtime") private var userDefaultLogtime: Int?
        
        private var selection: Binding<Int>
        {
            Binding
            {
                userDefaultLogtime ?? 0
            }
            set:
            {
                userDefaultLogtime = $0 == 0 ? nil : $0
            }
        }
        
        // MARK: - Body
        
        var body: some View
        {
            Section
            {
                Picker("Logtime", selection: selection)
                {
                    Text("Default")
                        .tag(0)
                    ForEach(1...24, id: \.self)
                    {
                        Text("\($0)h")
                            .tag($0)
                    }
                }
            }
            footer:
            {
                Text("Set a default value for the number of hours you wish to work per day. Leave on \"Default\" if you want the application to automatically calculate the number of hours you should work per month.")
            }
        }
        
    }
    
}
