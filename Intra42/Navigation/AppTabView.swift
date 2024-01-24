//
//  AppTabView.swift
//  Intra42
//
//  Created by Marc Mosca on 23/01/2024.
//

import SwiftUI

struct AppTabView: View {
    
    // MARK: - Properties
    
    @Binding var selection: AppScreen
    @Environment(\.store) private var store
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            if let user = store.user {
                TabView(selection: $selection) {
                    ForEach(AppScreen.allCases) { screen in
                        screen.destination(user: user)
                            .tag(screen as AppScreen?)
                            .tabItem { screen.label }
                    }
                }
                .tint(.night)
            }
            else {
                ProgressView()
            }
        }
        .slideIn(rowHeight: 50, duration: 1, delay: 0.2)
    }
}

// MARK: - Previews

#Preview {
    AppTabView(selection: .constant(.activities))
}
