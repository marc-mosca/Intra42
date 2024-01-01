//
//  ScaleRow.swift
//  Intra42
//
//  Created by Marc Mosca on 01/01/2024.
//

import SwiftUI

struct ScaleRow: View
{
    
    // MARK: - Exposed properties
    
    let scale: Api.Types.Scale
    
    // MARK: - Private properties
    
    private var title: String
    {
        String(localized: "You will be evaluated by someone on ft_transcendence in 45 minutes.")
    }
    
    // MARK: - Body
    
    var body: some View
    {
        HStack(spacing: 16)
        {
            Image(systemName: "person.badge.clock")
                .foregroundStyle(.night)
                .font(.headline)
                .imageScale(.large)
            
            VStack(alignment: .leading, spacing: 2)
            {
                Text(title)
                    .foregroundStyle(.primary)
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.vertical, 8)
    }
}

// MARK: - Previews

#Preview
{
    ScaleRow(scale: .sample)
}
