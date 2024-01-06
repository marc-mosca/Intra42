//
//  Profile+GridInformations.swift
//  Intra42
//
//  Created by Marc Mosca on 06/01/2024.
//

import SwiftUI

extension ProfileView
{
    
    struct GridInformations: View
    {
        
        // MARK: - Exposed properties
        
        let location: String?
        let grade: String?
        let poolYear: String
        
        // MARK: - Body
        
        var body: some View
        {
            HStack
            {
                gridItem(title: String(localized: "Location"), value: location ?? "N/A")
                gridItem(title: String(localized: "Grade"), value: grade ?? "N/A")
                gridItem(title: String(localized: "Promotion"), value: poolYear)
            }
        }
        
        // MARK: - Private components
        
        private func gridItem(title: String, value: String) -> some View
        {
            VStack(spacing: 8)
            {
                Text(title)
                    .foregroundStyle(.secondary)
                    .font(.footnote)
                
                Text(value)
                    .foregroundStyle(.primary)
                    .font(.system(.body, weight: .semibold))
            }
            .frame(maxWidth: .infinity)
        }
        
    }
    
}
