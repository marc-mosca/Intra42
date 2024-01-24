//
//  VRow.swift
//  Intra42
//
//  Created by Marc Mosca on 23/01/2024.
//

import SwiftUI

struct VRow: View {
    
    // MARK: - Properties
    
    let title: String
    let value: String
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .foregroundStyle(.primary)
            
            Text(value)
                .foregroundStyle(.secondary)
                .font(.subheadline)
        }
        .padding(.vertical, 8)
    }
}

// MARK: - Previews

#Preview {
    VRow(title: "Description", value: "This is a description.")
}
