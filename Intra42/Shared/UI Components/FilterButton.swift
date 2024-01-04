//
//  FilterButton.swift
//  Intra42
//
//  Created by Marc Mosca on 03/01/2024.
//

import SwiftUI

struct FilterButton: View
{
    
    // MARK: - Exposed properties
    
    @Binding var selection: String
    let filters: [String]
    
    // MARK: - Body
    
    var body: some View
    {
        Menu
        {
            Picker("Select a filter", selection: $selection)
            {
                ForEach(filters, id: \.self, content: Text.init)
            }
        }
        label:
        {
            Image(systemName: "line.3.horizontal.decrease.circle")
                .imageScale(.large)
        }
        .tint(.night)
    }
}

// MARK: - Previews

#Preview
{
    FilterButton(selection: .constant("All"), filters: ["All", "Future"])
}
