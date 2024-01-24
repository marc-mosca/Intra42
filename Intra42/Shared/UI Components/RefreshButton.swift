//
//  RefreshButton.swift
//  Intra42
//
//  Created by Marc Mosca on 23/01/2024.
//

import SwiftUI

struct RefreshButton: View {
    
    // MARK: - Properties
    
    let state: AppLoadingState
    let action: () -> Void
    
    // MARK: - Body
    
    var body: some View {
        Button(action: action) {
            Label("Refresh informations", systemImage: "arrow.clockwise")
                .labelStyle(.iconOnly)
                .imageScale(.large)
        }
        .tint(.night)
        .disabled(state == .loading)
    }
}

// MARK: - Previews

#Preview {
    RefreshButton(state: .loading, action: { })
}
