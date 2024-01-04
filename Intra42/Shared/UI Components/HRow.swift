//
//  HRow.swift
//  Intra42
//
//  Created by Marc Mosca on 03/01/2024.
//

import SwiftUI

struct HRow: View
{
    
    // MARK: - Exposed properties
    
    let title: String.LocalizationValue
    let value: String
    
    init(title: String.LocalizationValue, value: String)
    {
        self.title = title
        self.value = value
    }
    
    init(title: String.LocalizationValue, value: Date)
    {
        self.title = title
        self.value = value.formatted(.dateTime.day().month().year().hour().minute())
    }
    
    // MARK: - Body
    
    var body: some View
    {
        HStack
        {
            Text(String(localized: title))
                .foregroundStyle(.primary)
                .padding(.trailing, 10)
            
            Spacer()
            
            Text(value)
                .foregroundStyle(.secondary)
                .font(.subheadline)
                .multilineTextAlignment(.trailing)
        }
        .padding(.vertical, 4)
    }
}

// MARK: - Previews

#Preview
{
    HRow(title: "Name", value: "Marc MOSCA")
}
