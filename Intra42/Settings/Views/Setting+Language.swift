//
//  Setting+Language.swift
//  Intra42
//
//  Created by Marc Mosca on 04/01/2024.
//

import SwiftUI

extension SettingView
{
    
    struct LanguageSetting: View
    {
        
        // MARK: - Private properties
        
        @AppStorage("userDefaultLanguage") private var userDefaultLanguage: String?
        
        private let defaultLanguage = Locale.current.identifier.split(separator: "_").first?.lowercased()
        
        private var selection: Binding<String>
        {
            Binding
            {
                userDefaultLanguage ?? defaultLanguage ?? "en"
            }
            set:
            {
                userDefaultLanguage = $0
            }
        }
        
        // MARK: - Body
        
        var body: some View
        {
            Section
            {
                Picker("Language", selection: selection)
                {
                    ForEach(AppLanguages.allCases)
                    {
                        Text($0.title)
                            .tag($0.rawValue)
                    }
                }
            }
            footer:
            {
                Text("Set the default langauge for the application.")
            }
        }
        
    }
    
}
