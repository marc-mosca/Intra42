//
//  RefreshButton.swift
//  Intra42
//
//  Created by Marc Mosca on 03/01/2024.
//

import SwiftUI

struct RefreshButton: View
{
    
    // MARK: - Exposed properties
    
    let state: AppRequestState
    let action: () -> Void
    
    // MARK: - Body
    
    var body: some View
    {
        Button(action: action)
        {
            Label("Refresh informations", systemImage: "arrow.clockwise")
                .labelStyle(.iconOnly)
                .imageScale(.large)
        }
        .tint(.night)
        .disabled(state == .loading)
    }
}

// MARK: - Previews

#Preview
{
    RefreshButton(state: .succeded)
    {
        print("Taped")
    }
}
