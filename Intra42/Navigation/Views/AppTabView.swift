//
//  AppTabView.swift
//  Intra42
//
//  Created by Marc Mosca on 03/01/2024.
//

import SwiftUI

struct AppTabView: View
{
    
    // MARK: - Exposed properties
    
    @Binding var selection: AppScreen
    
    // MARK: - Private properties
    
    @Environment(\.store) private var store
    
    // MARK: - Body
    
    var body: some View
    {
        VStack
        {
            TabView(selection: $selection)
            {
                ForEach(AppScreen.allCases) { screen in
                    screen.destination
                        .tag(screen as AppScreen?)
                        .tabItem { screen.label }
                }
            }
            .tint(.night)
        }
        .slideIn(rowHeight: 50, duration: 1, delay: 0.2)
    }
}

// MARK: - Previews

#Preview
{
    AppTabView(selection: .constant(.activities))
}
